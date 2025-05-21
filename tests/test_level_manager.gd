extends UnitTest

class UIStub:
    var score := 0
    var lives := 0
    var reload_called := false

    func update_score(v):
        score = v
    func add_score(a):
        score += a
    func update_lives(v):
        lives = v
    func remove_life():
        lives -= 1
        if lives <= 0:
            reload_called = true

var manager

func before_each():
    manager = preload("res://scripts/LevelManager.gd").new()
    manager.ui = UIStub.new()

func test_ready_initializes_ui():
    manager._ready()
    assert_eq(manager.ui.lives, 3)
    assert_eq(manager.ui.score, 0)

func test_score_increment():
    manager._ready()
    manager.on_pipoca_collected()
    assert_eq(manager.ui.score, 1)

func test_life_decrement_and_reload():
    manager._ready()
    manager.on_player_hit()
    assert_eq(manager.ui.lives, 2)
    manager.on_player_hit()
    assert_eq(manager.ui.lives, 1)
    manager.on_player_hit()
    assert_true(manager.ui.reload_called)
