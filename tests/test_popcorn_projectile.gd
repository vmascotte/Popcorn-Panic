extends UnitTest

func test_move_forward():
    var p = preload("res://scripts/PopcornProjectile.gd").new()
    p.speed = 100
    p.direction = Vector2.RIGHT
    p.position = Vector2.ZERO
    p._physics_process(0.5)
    assert_eq(p.position.x, 50)

func test_damage_on_hit():
    var p = preload("res://scripts/PopcornProjectile.gd").new()
    var enemy = Node.new()
    var damaged := false
    enemy.take_damage = func(amount):
        damaged = true
    var freed := false
    p.queue_free = func():
        freed = true
    p._on_body_entered(enemy)
    assert_true(damaged)
    assert_true(freed)
