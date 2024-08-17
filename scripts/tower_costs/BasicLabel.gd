extends Label

func _process(delta):
	text = "Basic\nCost: " + str(UpgradeManager.basic_price)
