extends Area2D

@export var collect_sound: AudioStreamPlayer

func _ready():
    connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
    if body.name == "MrPlus" or body is CharacterBody2D:
        if collect_sound:
            collect_sound.play()
        var scene = get_tree().current_scene
        if scene and scene.has_method("on_pipoca_collected"):
            scene.on_pipoca_collected()
        queue_free()
