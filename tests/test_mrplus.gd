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

func test_attack_spawns_projectile():
    var parent = Node.new()
    var added
    parent.add_child = func(n):
        added = n
    player.get_parent = func():
        return parent
    var instance = Node2D.new()
    var scene_stub = {
        func instantiate():
            return instance
    }
    player.projectile_scene = scene_stub
    Input.is_action_just_pressed = func(action):
        return action == "ui_attack"
    Input.get_action_strength = func(action):
        return 0
    player._physics_process(0.016)
    assert_eq(added, instance)
