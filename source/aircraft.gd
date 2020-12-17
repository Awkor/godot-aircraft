extends RigidBody

export (NodePath) var flight_pointer_path

onready var flight_pointer: FlightPointer = get_node(flight_pointer_path)

var thrust = 200
var pitch = 0
var yaw = 0
var roll = 0

var pitch_pid = PID.new()
var yaw_pid = PID.new()
var roll_pid = PID.new()

var pitch_torque = 1.0
var yaw_torque = 1.0
var roll_torque = 1.0


func _process(delta: float) -> void:
	var point = flight_pointer.get_point()
	var angle = (-transform.basis.z).angle_to(point) * (2 * PI)

	point = to_local(point)
	point = point.normalized()

	pitch = pitch_pid.update(point.y, delta)
	pitch = clamp(pitch, -1, 1) * pitch_torque

	yaw = yaw_pid.update(-point.x, delta)
	yaw = clamp(yaw, -1, 1) * yaw_torque

	var influence = inverse_lerp(0, 5, angle)
	var roll_error = lerp(-transform.basis.x.y, point.x, influence)

	roll = roll_pid.update(roll_error, delta)
	roll = clamp(roll, -1, 1) * roll_torque


func _physics_process(delta):
	var torque_vector = Vector3(pitch, yaw, roll)
	add_torque(transform.basis * torque_vector)
	add_central_force(transform.basis.z * thrust * delta)
