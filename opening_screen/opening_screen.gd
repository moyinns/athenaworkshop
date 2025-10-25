extends Node2D


@onready var load_status = $"load settings/load status"
@onready var load_timer = $"load settings/load timer"
@onready var fail_load_timer = $"load settings/fail load timer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"music settings".visible = false
	$"load settings".visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://naming_screen/naming_scene.tscn")

func _on_load_pressed() -> void:
	load_data()
	$"load settings".visible = true
	if load_data() == true:
		load_status.text = "load successful!"
		load_timer.start()
	else:
		load_status.text = "no load found"
		fail_load_timer.start()


func load_data():
	if FileAccess.file_exists(Globals.save_path):
		var file = FileAccess.open(Globals.save_path, FileAccess.READ)
		Globals.hunger = file.get_var()
		Globals.thirst = file.get_var()
		Globals.level = file.get_var()
		Globals.pet_name = file.get_var()
		return true
	else:
		return false
		
func _on_load_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://main_homscreen/main_homescreen.tscn")	

func _on_fail_load_timer_timeout() -> void:
	$"load settings".visible = false

func _on_music_pressed() -> void:
	$"music settings".visible = true

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))


func _on_quit_music_button_pressed() -> void:
	$"music settings".visible = false
