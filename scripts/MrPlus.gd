extends CharacterBody2D

@export var speed := 120
@export var jump_force := -300
@export var gravity := 800

var velocity := Vector2.ZERO

func _physics_process(delta):
    var input := Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
    velocity.x = input * speed

    if not is_on_floor():
        velocity.y += gravity * delta
    elif Input.is_action_just_pressed("ui_accept"):
        velocity.y = jump_force
        if has_node("JumpSound"):
            $JumpSound.play()

    velocity = move_and_slide(velocity, Vector2.UP)
