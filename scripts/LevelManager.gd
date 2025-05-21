extends Node2D

@onready var player := $MrPlus
@onready var ui := $UI

func _ready():
    ui.update_lives(3)
    ui.update_score(0)

func on_pipoca_collected():
    ui.add_score(1)

func on_player_hit():
    ui.remove_life()
