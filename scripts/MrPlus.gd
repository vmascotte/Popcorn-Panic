extends CharacterBody2D

@export var speed := 120
@export var jump_force := -300
@export var gravity := 800
@export var projectile_scene : PackedScene

var velocity := Vector2.ZERO
var _facing := 1

func _physics_process(delta):
    var input := Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
    velocity.x = input * speed
    if input != 0:
        _facing = sign(input)

    if not is_on_floor():
        velocity.y += gravity * delta
    elif Input.is_action_just_pressed("ui_accept"):
        velocity.y = jump_force
        if has_node("JumpSound"):
            $JumpSound.play()

    if Input.is_action_just_pressed("ui_attack") and projectile_scene:
        var projectile = projectile_scene.instantiate()
        if projectile.has_variable("direction"):
            projectile.direction = Vector2(_facing, 0)
        projectile.position = global_position
        get_parent().add_child(projectile)

    velocity = move_and_slide(velocity, Vector2.UP)
