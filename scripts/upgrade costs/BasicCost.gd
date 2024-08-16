extends Label


func _process(delta):
	text = "Cost: " + str(UpgradeManager.basic_upgrade_price)
