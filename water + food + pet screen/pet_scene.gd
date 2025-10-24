extends Node2D

@onready var hunger_bar = $"hunger bar"
@onready var thirst_bar = $"thirst bar"
@onready var scene_switch_timer = $"scene switch timer"
var timer_started = false


#func _ready() -> void:

func _process(delta: float) -> void:
	if Globals.hunger == 0 or Globals.thirst == 0:
		get_tree().change_scene_to_file("res://main_homscreen/death_scene.tscn")
	$cat.standing()

func _on_hunger_timer_timeout() -> void:
	Globals.hunger = max(Globals.hunger - 1, 0)  # decrease by 1 but don’t go below 0
	hunger_bar.text = "hunger: " + str(Globals.hunger) + "%"

func _on_thirst_timer_timeout() -> void:
	Globals.thirst = max(Globals.thirst - 1, 0)  # decrease by 1 but don’t go below 0
	thirst_bar.text = "thirst: " + str(Globals.thirst) + "%"


func _on_area_2d_mouse_entered() -> void:
	pass # Replace with function body.
