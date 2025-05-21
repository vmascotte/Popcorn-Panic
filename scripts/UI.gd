extends CanvasLayer

var score := 0
var lives := 3

func update_score(value):
    score = value
    $ScoreLabel.text = "Popcorn: %s" % score

func add_score(amount):
    update_score(score + amount)

func update_lives(value):
    lives = value
    $LivesLabel.text = "Lives: %s" % lives

func remove_life():
    lives -= 1
    update_lives(lives)
    if lives <= 0:
        get_tree().reload_current_scene()
