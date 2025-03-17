extends Control
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var timer: Timer = $Timer

var losing_oxygen: bool = true #note: boolean is called bool in Godot


func onready():
	progress_bar.value = 100;


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		print("YAYYYYY")
		losing_oxygen = !losing_oxygen


func _on_timer_timeout() -> void:
	if losing_oxygen:
		print(progress_bar.value)
		progress_bar.value -= 0.05
	else:
		if (progress_bar.value <= 15):
			progress_bar.value += .4
		if (progress_bar.value <= 30):
			progress_bar.value += .33
		if (progress_bar.value <= 45):
			progress_bar.value += .25
		else:
			progress_bar.value += 0.2
