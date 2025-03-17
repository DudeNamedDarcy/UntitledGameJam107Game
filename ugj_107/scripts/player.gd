class_name Player extends CharacterBody3D

@onready var camera_3d: Camera3D = %Camera3D

@export_range(0.001, 1.0) var mouse_sensitivity = 0.005

#adding maximum speeds and accelerations to our movement
@export_category("Ground Movement")
@export_range(1.0, 10.0, 0.1) var max_speed_jog = 4.0
#export_ranfw works like (minimum value, maximum value, 
@export_range(1.0, 15.0, 0.1) var max_speed_sprint = 8.7
@export_range(1.0, 100.0, 0.1) var acceleration_jog = 15.0
@export_range(1.0, 100.0, 0.1) var acceleration_sprint = 25.0
@export_range(1.0, 100.0, 0.1) var deceleration = 15.0




func _unhandled_input(event: InputEvent): #NOTE: THIS FUNCTION MUST BE CALLED"_unhandled_input" to work!!!
	#to remove the mouse cursor from our game window, we use "Input.mouse_mode" for that!
	var is_mouse_button = event is InputEventMouseButton #checks if the mouse was clicked
	var is_mouse_captured = Input.mouse_mode == Input.MOUSE_MODE_CAPTURED #boolean statement to see if the mouse cursot is gone (true) or not (false)
	var is_escape_pressed = event.is_action_pressed("ui_cancel") #variable assigned to the Escape key being pressed.
	
	if is_mouse_button and not is_mouse_captured:
		print("1")
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED #if the mouse cursor is not captured and we clicked a mouse button in the game, then we capture the mouse cursor
	elif is_escape_pressed and is_mouse_captured:
		print("2")
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE #allows us to use the mouse again!
		#elif = else if
		# When any mouse button is clicked and the mouse isn't already captured, we capture it by setting Input.mouse_mode to Input.MOUSE_MODE_CAPTURED
		# When the esc key is pressed (ui_cancel) and the mouse is captured, we release the mouse by setting the mouse mode to Input.MOUSE_MODE_VISIBLE
	if (event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED):
		var look_offset_2d: Vector2 = event.screen_relative * mouse_sensitivity
		rotate_camera(look_offset_2d)
	
	


func rotate_camera(look_offset_2d: Vector2):
	#The x component of the mouse motion should control the camera's rotation around the Y-axis. The y component of the mouse motion should control the camera's rotation around the X-axis
	camera_3d.rotation.y -= look_offset_2d.x
	camera_3d.rotation.x -= look_offset_2d.y
	camera_3d.rotation.y = wrapf(camera_3d.rotation.y, -PI, PI)
	const MAX_VERTICAL_ANGLE = PI/3.0
	camera_3d.rotation.x = clampf(camera_3d.rotation.x, -1 * MAX_VERTICAL_ANGLE, MAX_VERTICAL_ANGLE)
	camera_3d.orthonormalize()
	

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	var input_direction_2d = Input.get_vector("move_left", "move_right", "move_forward", "move_back") #calculate's the input's direction!!!
	var movement_direction_2d = input_direction_2d.rotated(-1.0 * camera_3d.rotation.y) #rotates the input direction to be relative to the camera's look direction
	var movement_direction_3d = Vector3(movement_direction_2d.x, 0.0, movement_direction_2d.y) #converts the input vector to 3D
	#use the x value for left and right movement, and the y value for forward and backward movement, which is mapped to the 3D vector's z component
	var player_is_moving = movement_direction_2d.length() > 0.1 #checks if our vector input isn't 0, AKA, we are pressing buttons
	if player_is_moving:
		var max_speed = max_speed_jog
		var acceleration = acceleration_jog
		if Input.is_action_just_pressed("run"): #if we press the Sprint/Shift key AKA RUNNING!
			max_speed = max_speed_sprint
			acceleration = acceleration_sprint
		var velocity_ground_plane = Vector3(velocity.x, 0, velocity.z)
		var velocity_change = acceleration * delta
		velocity_ground_plane = velocity_ground_plane.move_toward(movement_direction_3d * max_speed, velocity_change)
		velocity.x = velocity_ground_plane.x
		velocity.z = velocity_ground_plane.z
	
	else: #and if the player has NO INPUT
		var velocity_ground_plane = Vector3(velocity.x, 0, velocity.z)
		velocity_ground_plane = velocity_ground_plane.move_toward(Vector3(0,0,0), deceleration * delta)
		velocity.x = velocity_ground_plane.x
		velocity.z = velocity_ground_plane.z

	move_and_slide() #ALWAYS ADD THIS AT THE END OF PHYSICS PROCESS FOR SOMETHING THAT MOVES!!!
	
