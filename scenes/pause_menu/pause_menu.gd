extends Control

var paused = false
const MAIN_MENU_SCENE : PackedScene = preload("res://scenes/main_menu.tscn")

func _on_resume_pressed():
	self.hide()
	get_tree().paused = false
	paused = false

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


func _on_restart_pressed():
	paused = false
	get_tree().paused = false
	self.hide()
	get_tree().reload_current_scene()


func _on_mainmenu_pressed():
	paused = false
	get_tree().paused = false
	get_tree().change_scene_to_packed(MAIN_MENU_SCENE)
