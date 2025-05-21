extends StaticBody2D

var steps := 0

func _ready():
    connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
    if body.name == "MrPlus" or body is CharacterBody2D:
        if body.velocity.y > 0:
            steps += 1
            if steps >= 2:
                queue_free()
