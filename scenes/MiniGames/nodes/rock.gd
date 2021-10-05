extends RigidBody2D

var velocity = Vector2.ZERO
var atype: String
var scaleVector: Vector2
onready var tween = $COMPRESS
onready var expand = $EXPAND
onready var transparency = $TRANSPARENCY
onready var colShape = $CollisionShape2D
onready var polShape = $Polygon2D
func _ready():
	polShape.set_polygon(_generate_poly())
	position = Vector2(rand_range(40, 1024 - 40), rand_range(0, 640 / 2))
	expand.interpolate_property(self, "scale", Vector2(0, 0), self.scale, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	expand.interpolate_property(polShape, "modulate", Color(0,0,0,0), Color(1, 1, 1, polShape.color.a), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	expand.start()
	polShape.set_scale(scaleVector)
	colShape.set_scale(scaleVector)
	polShape.color = Global.ore_colors[atype]
	polShape.rotation_degrees = rand_range(0, 360)
	
func _initialize(type: String, scale: float):
	scaleVector = Vector2(scale, scale)
	atype = type

func _generate_poly() -> PoolVector2Array:
	var pvar = []
	var points = 30
	while points > 0:
		points -= 1
		pvar.append(Vector2(_random_point()))
	pvar.sort_custom(self, "_sort_clockwise")
	return PoolVector2Array(pvar)

func _random_point() -> Vector2:
	var alp = 2 * PI * randf()
	return Vector2(cos(alp) * 24, sin(alp) * 24)

func _sort_clockwise(a, b):
	return a.angle() < b.angle()
	
func _compress_matter():
	transparency.interpolate_property(polShape, "modulate", polShape.modulate, Color(0, 0, 0, 0.9), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	transparency.start()
	add_to_group("destroyed")
	set_collision_mask(2)
	set_collision_layer(2)
	tween.interpolate_property(self, "scale", self.scale, Vector2(0.1, 0.1), 3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	add_force(Vector2.ZERO, Vector2.UP * 800)
	z_index = -10
	
func _on_COMPRESS_tween_all_completed():
	queue_free()

func _on_EXPAND_tween_all_completed():
	add_force(Vector2.ZERO, Vector2.DOWN * 50)
	set_collision_mask(1)
	set_collision_layer(1)
