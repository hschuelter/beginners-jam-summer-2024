extends AudioStreamPlayer2D

@onready var day_music = preload("res://assets/music/MusicaDia.wav")
@onready var night_music = preload("res://assets/music/MúsicaNoite.wav")
@onready var menu_music = preload("res://assets/music/MúsicaMenu.wav")

func play_day():
	self.stream = day_music
	self.play()

func play_night():
	self.stream = night_music
	self.play()

func play_menu():
	self.stream = menu_music
	self.play()
