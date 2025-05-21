extends Node2D

# Global game state that persists across scene changes
static var current_level_index: int = 0
static var score: int = 0
static var lives: int = 3

# Array of level scene paths ("res://Level1.tscn", "res://Level2.tscn", ...)
@export var levels: Array[String] = []

@onready var player := $MrPlus
@onready var ui := $UI
@onready var boss := get_node_or_null("Boss")

func _ready():
    # When a new level loads, sync the UI with the stored state
    ui.update_lives(lives)
    ui.update_score(score)
    if boss:
        boss.boss_defeated.connect(on_boss_defeated)

func on_pipoca_collected():
    ui.add_score(1)
    # Preserve score between levels
    score = ui.score
    if ui.score >= 10:
        on_level_completed()

func on_player_hit():
    ui.remove_life()
    lives = ui.lives

func load_next_level():
    # Store the latest score and lives before switching scenes
    score = ui.score
    lives = ui.lives

    current_level_index += 1
    if current_level_index >= levels.size():
        # No more levels; reload current as a simple fallback
        current_level_index = clamp(current_level_index, 0, levels.size() - 1)
        get_tree().reload_current_scene()
        return

    var next_scene_path := levels[current_level_index]
    get_tree().change_scene_to_file(next_scene_path)

func on_level_completed():
    print("Channel switched… Get ready for the next dimension!")
    load_next_level()

func on_boss_defeated():
    load_next_level()
