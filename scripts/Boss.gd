extends CharacterBody2D

signal attack

@export var speed := 40
@export var attack_interval := 2.0

var direction := 1
var velocity := Vector2.ZERO
var _timer := 0.0

func _ready():
    _timer = attack_interval

func _physics_process(delta):
    velocity.x = speed * direction
    velocity = move_and_slide(velocity, Vector2.UP)

    if is_on_wall():
        direction *= -1

    _timer -= delta
    if _timer <= 0:
        _timer = attack_interval
        emit_signal("attack")
