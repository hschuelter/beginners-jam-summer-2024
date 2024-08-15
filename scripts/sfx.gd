extends AudioStreamPlayer2D

func _play(time: float = 0):
	self.pitch_scale = randf_range(0.8, 1.2)
	self.play(time)
