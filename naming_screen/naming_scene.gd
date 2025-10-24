extends Node2D

@onready var pet_name_input = $pet_name_input
var pet_name = ""  

func _ready() -> void:
	pet_name_input.text_submitted.connect(_on_pet_name_text_submitted)
	$cat.idle()

func _on_pet_name_text_submitted(new_text: String) -> void:
	Globals.pet_name = new_text 
	get_tree().change_scene_to_file("res://main_homscreen/main_homescreen.tscn")
