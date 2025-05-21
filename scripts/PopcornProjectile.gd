extends Area2D

@export var speed := 200
var direction := Vector2.RIGHT

func _physics_process(delta):
    position += direction * speed * delta

func _ready():
    connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
    if body and body.has_method("take_damage"):
        body.take_damage(1)
    queue_free()
