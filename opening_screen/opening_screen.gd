extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"music settings".visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass



func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://naming_screen/naming_scene.tscn")

func _on_load_pressed() -> void:
	pass # Replace with function body.


func _on_music_pressed() -> void:
	$"music settings".visible = true
	


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))


func _on_quit_music_button_pressed() -> void:
	$"music settings".visible = false
