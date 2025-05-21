extends UnitTest

var enemy

func before_each():
    enemy = preload("res://scripts/Enemy.gd").new()
    enemy.move_and_slide = func(v, up := Vector2.UP):
        return v

func test_reverse_on_wall():
    enemy.direction = -1
    enemy.is_on_wall = func(): return true
    enemy._physics_process(0.016)
    assert_eq(enemy.direction, 1)
