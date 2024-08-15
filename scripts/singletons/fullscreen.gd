extends Button

@onready var previous_window = DisplayServer.window_get_mode()
@onready var current_window = DisplayServer.window_get_mode()

func _input(event):
	if Input.is_action_just_pressed("f11"):

		current_window = DisplayServer.window_get_mode()
		if current_window != 4:
			previous_window = current_window
			DisplayServer.window_set_mode(4)
		else:
			if previous_window == 4:
				previous_window = 2
			DisplayServer.window_set_mode(previous_window)
