tool
extends ItemList


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var MiniGamesDir = ""
export var icon: Texture

# Called when the node enters the scene tree for the first time.
func _ready():
	self.clear()
	var scenes = list_files_in_directory(MiniGamesDir)
	for x in scenes:
		self.add_item(x, icon, true)
	print(scenes)
	self.grab_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func list_files_in_directory(path) -> Array:
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with(".") and file.ends_with('.tscn'):
			files.append(file)

	dir.list_dir_end()

	return files


func _on_ItemList_item_activated(ind):
	print(MiniGamesDir + self.items[ind * 3])
	Global.goto_scene(MiniGamesDir + self.items[ind * 3])
