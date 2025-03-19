extends Control

@onready var timer_test_label: RichTextLabel = $CenterContainer/VBoxContainer/TimerTestLabel
@onready var timer: Timer = $Timer

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if Input.mouse_mode != Input.MOUSE_MODE_VISIBLE:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _physics_process(delta: float) -> void:
	var time_left_in_seconds = snapped(timer.time_left, 0.1) #"snapped() essentially limits a float's decimal value! Tidies up reading from the timer
	#snapped odcumentation link: https://docs.godotengine.org/en/latest/classes/class_%40globalscope.html#class-globalscope-method-snapped
	timer_test_label.text = "[center]" + str(time_left_in_seconds) + "[/center]"

func _on_quit_game_button_pressed() -> void:
	get_tree().quit()
