extends CanvasModulate

const MINUTES_PER_HOUR = 60
const INGAME_TO_REAL_MINUTE_DURATION = (2 * PI) / (MINUTES_PER_HOUR * 24)

signal time_tick(day: int, hour: int, minute: int)

@export var gradient: GradientTexture1D
@export var ingame_speed_rate: float = 1.0 
@export var initial_hour: int = 12

var time: float = 0
var past_minute: float = -1.0

func _ready() -> void:
	time = INGAME_TO_REAL_MINUTE_DURATION * initial_hour * MINUTES_PER_HOUR

func _process(delta):
	time += delta / ingame_speed_rate
	var value = (1 + sin(time - PI/2)) / 2.0
	self.color = gradient.gradient.sample(value)
	_recalculate_time()

func _recalculate_time() -> void:
	var total_minutes = int(time / INGAME_TO_REAL_MINUTE_DURATION)
	var current_day_minutes = total_minutes % (MINUTES_PER_HOUR * 24)
	
	var day = int(total_minutes / (MINUTES_PER_HOUR * 24))
	var hour = int(current_day_minutes / MINUTES_PER_HOUR)
	var minute = int(current_day_minutes % MINUTES_PER_HOUR)
	
	if past_minute != minute:
		past_minute = minute
		time_tick.emit(day, hour, minute)
