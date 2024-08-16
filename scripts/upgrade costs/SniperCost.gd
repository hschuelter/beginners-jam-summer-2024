extends Label


func _process(delta):
	text = "Cost: " + str(UpgradeManager.sniper_upgrade_price)
