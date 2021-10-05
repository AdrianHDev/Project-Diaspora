extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var time = 30
signal finished_minigame
var timer = Timer.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout", self, "_on_timeout")
	update_time()
	add_child(timer)
	timer.start()
#func _init(secs):
#	time = secs

func _on_timeout():
	time -= 1
	if time == 0:
		timer.stop()
		emit_signal("finished_minigame")
		Global.goto_scene("res://scenes/DebugMenu.tscn")
	update_time()
	
func update_time():
	var secs = time % 60 
	var s_secs = secs as String if len(secs as String) > 1 else '0' + (secs as String)
	self.text = "TIME\n" + (time / 60) as String + ':' + s_secs
