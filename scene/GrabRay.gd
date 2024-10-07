extends RayCast3D
#
#
#@onready var point = $"../Hold"
#
#var picked_object
#var pull_power = 7
#var rotation_power = 0.05
#var lock = false
#
#
## Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		#if picked_object == null:
			#pick_object()
			#rotate_object(picked_object)
		#elif picked_object != null:
			#remove_object()
#
	#if picked_object != null:
		#var a = picked_object.global_transform.origin
		#var b = point.global_transform.origin
		#picked_object.set_linear_velocity((b-a)*pull_power)
		#
		#
#func pick_object():
	#var collider = get_collider()
	#if collider != null and collider is RigidBody3D:
		#picked_object = collider
		#
#
#func remove_object():
	#if picked_object != null:
		#picked_object = null
		#
#
#func rotate_object(event):
	#if picked_object != null:
		#if event is InputEventMouseMotion:
			#point.rotate_x(deg_to_rad(event.relative.y * rotation_power))
			#point.rotate_y(deg_to_rad(event.relative.x * rotation_power))
	#
	#
	#
	#
	#
