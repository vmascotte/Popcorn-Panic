extends StaticBody2D

@export var popcorn_scene : PackedScene
var triggered := false

func _ready():
    connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
    if triggered:
        return
    if body.name == "MrPlus" or body is CharacterBody2D:
        if body.velocity.y < 0 and body.global_position.y > global_position.y:
            triggered = true
            if popcorn_scene:
                var popcorn = popcorn_scene.instantiate()
                popcorn.position = global_position + Vector2(0, -16)
                get_parent().add_child(popcorn)
