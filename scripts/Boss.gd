extends CharacterBody2D

signal boss_defeated
signal phase_changed

@export var speed := 80
@export var shoot_interval := 3.0
@export var health := 20
@export var projectile_scene : PackedScene

@export var intro_duration := 1.0
@export var rage_speed := 150
@export var rage_shoot_interval := 1.0

var phase := "intro"
var _direction := 1
var _shoot_timer := 0.0
var _intro_timer := 0.0
var _rage_threshold := 0

func _ready():
    _intro_timer = intro_duration
    _shoot_timer = shoot_interval
    _rage_threshold = int(health / 2)

func _physics_process(delta):
    if phase == "intro":
        _intro_timer -= delta
        if _intro_timer <= 0:
            phase = "normal"
            _shoot_timer = shoot_interval
            emit_signal("phase_changed", phase)
        return

    var current_speed := speed if phase == "normal" else rage_speed
    velocity.x = current_speed * _direction
    velocity = move_and_slide(velocity, Vector2.UP)
    if is_on_wall():
        _direction *= -1

    _shoot_timer -= delta
    if _shoot_timer <= 0:
        _shoot_timer = shoot_interval if phase == "normal" else rage_shoot_interval
        shoot()

func shoot():
    if projectile_scene:
        var projectile = projectile_scene.instantiate()
        projectile.position = global_position
        get_parent().add_child(projectile)
        if phase == "rage":
            var projectile2 = projectile_scene.instantiate()
            projectile2.position = global_position + Vector2(0, -16)
            get_parent().add_child(projectile2)

func take_damage(amount):
    health -= amount
    if health <= _rage_threshold and phase == "normal":
        phase = "rage"
        _shoot_timer = rage_shoot_interval
        emit_signal("phase_changed", phase)
    if health <= 0:
        emit_signal("boss_defeated")
        queue_free()
