extends Control

var paused = false

func _on_resume_pressed():
	self.hide()
	get_tree().paused = false
	paused = false

func _on_quit_pressed():
	get_tree().quit()

func pauseMenu():
	if paused:
		get_tree().paused = false
		self.hide()
		paused = false
	else:
		get_tree().paused = true
		self.show()
		paused = true

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
