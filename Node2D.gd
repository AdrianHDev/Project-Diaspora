extends Node2D

const rock = preload("res://scenes/MiniGames/nodes/rock.tscn")
onready var items = get_node("../UI/VBoxContainer")

var ores_obtained = {
	"copper": 0,
	"iron": 0,
	"silicon": 0,
	"cobalt": 0,
	"gold": 0,
	"atypical": 0
}

func _ready():
	print('loaded!')
	print("Starting Miner MiniGame with\n", Global.ore_rarities)
	_update_UI()


func _on_Timer_timeout():
	for x in Global.ore_rarities:
		var y = randf()
		if y < Global.ore_rarities[x]:
			var newRock = rock.instance()
			newRock._initialize(x, randf() + 0.5)
			add_child(newRock)

func _on_Area2D_body_exited(body: Node2D):
	if not body.is_in_group("destroyed"):
		body.queue_free()

func _on_Area2D_body_entered(body):
	ores_obtained[body.atype] += 1
	_update_UI()
	body._compress_matter()
	
func _update_UI():
	for node in items.get_children():
		node.text = node.name.capitalize() + ": " + ores_obtained[node.name] as String
