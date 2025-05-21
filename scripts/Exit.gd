extends Area2D

func _ready():
    connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
    if body.name == "MrPlus" or body is CharacterBody2D:
        var scene = get_tree().current_scene
        if scene and scene.has_method("on_level_completed"):
            scene.on_level_completed()
