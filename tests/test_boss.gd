extends UnitTest

var boss
var phase_event
var shots

func before_each():
    boss = preload("res://scripts/Boss.gd").new()
    boss.intro_duration = 0.1
    boss.shoot_interval = 1.0
    boss.rage_shoot_interval = 0.5
    boss.move_and_slide = func(v, up := Vector2.UP):
        return v
    boss.is_on_wall = func():
        return false
    shots = 0
    boss.shoot = func():
        shots += 1
    phase_event = null
    boss.connect("phase_changed", func(p): phase_event = p)

func test_phase_transitions():
    boss._ready()
    boss._physics_process(0.05)
    assert_eq(boss.phase, "intro")
    boss._physics_process(0.05)
    assert_eq(boss.phase, "normal")
    assert_eq(phase_event, "normal")
    boss.take_damage(boss.health / 2)
    assert_eq(boss.phase, "rage")
    assert_eq(phase_event, "rage")

func test_projectile_timing_per_phase():
    boss.intro_duration = 0
    boss._ready()
    boss._physics_process(0.4)
    assert_eq(shots, 0)
    boss._physics_process(0.6)
    assert_eq(shots, 1)
    boss._physics_process(1.0)
    assert_eq(shots, 2)
    boss.take_damage(boss.health / 2)
    boss._physics_process(0.2)
    assert_eq(shots, 2)
    boss._physics_process(0.3)
    assert_eq(shots, 3)
