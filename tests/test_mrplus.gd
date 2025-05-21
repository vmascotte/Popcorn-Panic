extends UnitTest

var player

func before_each():
    player = preload("res://scripts/MrPlus.gd").new()
    # override physics methods
    player.move_and_slide = func(v, up := Vector2.UP):
        return v

func test_jump():
    player.is_on_floor = func(): return true
    Input.is_action_just_pressed = func(action):
        return action == "ui_accept"
    player._physics_process(0.016)
    assert_eq(player.velocity.y, player.jump_force)

func test_gravity():
    player.is_on_floor = func(): return false
    var start_y := player.velocity.y
    var dt := 0.5
    player._physics_process(dt)
    assert_eq(player.velocity.y, start_y + player.gravity * dt)
