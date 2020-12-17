extends Spatial
class_name FlightCamera

export (NodePath) var flight_pointer_path
export (NodePath) var aircraft_path

var weight = 8

onready var camera: Camera = get_viewport().get_camera()
onready var spring_arm: SpringArm = get_child(0)
onready var flight_pointer: FlightPointer = get_node(flight_pointer_path)
onready var aircraft: Spatial = get_node(aircraft_path)


func _process(delta: float) -> void:
	spring_arm.rotation.x = lerp_angle(
		spring_arm.rotation.x, flight_pointer.rotation.x, weight * delta
	)
	rotation.y = lerp_angle(rotation.y, flight_pointer.rotation.y, weight * delta)
	transform.origin = aircraft.transform.origin
