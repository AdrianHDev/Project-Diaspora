extends Node

# from godot docs. https://docs.godotengine.org/en/stable/getting_started/step_by_step/singletons_autoload.html

var current_scene = null
var ore_rarities = {
	"copper": 0.8,
	"iron": 0.5,
	"silicon": 0.2,
	"cobalt": 0.1,
	"gold": 0.1,
}
const ore_colors = {
	"copper": Color("#B87333"),
	"iron": Color("#A59C94"),
	"silicon": Color(0.933333,0.85098,0.741176, 0.4),
	"cobalt": Color("#0264AE"),
	"gold": Color("#EEBC1D"),
}

func _ready():
	randomize()
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func goto_scene(path):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:

	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	# It is now safe to remove the current scene
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instance()

	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)
