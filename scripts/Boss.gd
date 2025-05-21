extends CharacterBody2D

signal boss_defeated

@export var speed := 80
@export var shoot_interval := 3.0
@export var health := 20
@export var projectile_scene : PackedScene

var _direction := 1
var _shoot_timer := 0.0

func _ready():
    _shoot_timer = shoot_interval

func _physics_process(delta):
    velocity.x = speed * _direction
    velocity = move_and_slide(velocity, Vector2.UP)
    if is_on_wall():
        _direction *= -1

    _shoot_timer -= delta
    if _shoot_timer <= 0:
        _shoot_timer = shoot_interval
        shoot()

func shoot():
    if projectile_scene:
        var projectile = projectile_scene.instantiate()
        projectile.position = global_position
        get_parent().add_child(projectile)

func take_damage(amount):
    health -= amount
    if health <= 0:
        emit_signal("boss_defeated")
        queue_free()
