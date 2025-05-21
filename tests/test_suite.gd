extends TestSuite

func _init():
    add(preload("res://tests/test_mrplus.gd").new())
    add(preload("res://tests/test_enemy.gd").new())
    add(preload("res://tests/test_level_manager.gd").new())
    add(preload("res://tests/test_boss.gd").new())
