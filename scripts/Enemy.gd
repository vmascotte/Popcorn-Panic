extends CharacterBody2D

@export var speed := 50
var direction := -1

func _physics_process(delta):
    velocity.x = speed * direction
    velocity = move_and_slide(velocity, Vector2.UP)

    if is_on_wall():
        direction *= -1
