extends Node2D

signal level_completed

@onready var player := $MrPlus
@onready var ui := $UI

func _ready():
    ui.update_lives(3)
    ui.update_score(0)

func on_pipoca_collected():
    ui.add_score(1)

func on_player_hit():
    ui.remove_life()

func complete_level():
    emit_signal("level_completed")

func on_exit_body_entered(body):
    if body == player:
        complete_level()
