extends Label


func _process(delta):
	text = "Cost: " + str(UpgradeManager.slow_upgrade_price)
