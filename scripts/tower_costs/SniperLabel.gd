extends Label

func _process(delta):
	text = "Sniper\nCost: " + str(UpgradeManager.sniper_price)
