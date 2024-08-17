extends Label

func _process(delta):
	text = "Slow\nCost: " + str(UpgradeManager.slow_price)
