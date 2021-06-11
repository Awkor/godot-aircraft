class_name FlightCamera
extends Spatial

export (NodePath) var aircraft_path
export (NodePath) var flight_pointer_path

var default_fov = 90
var flight_pointer_weight = 0.02
var zoom = false
var zoom_fov = 45
var zoom_weight = 8

onready var viewport := get_viewport()
onready var camera := viewport.get_camera()
onready var aircraft: Spatial = get_node(aircraft_path)
onready var flight_pointer: FlightPointer = get_node(flight_pointer_path)


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_RIGHT:
			if event.pressed == false:
				_toggle_zoom()


func _process(delta: float) -> void:
	_update_camera_position()
	_follow_flight_pointer(delta)
	_update_camera_fov(delta)


func _follow_flight_pointer(delta: float) -> void:
	var point = flight_pointer.get_point()
	var viewport_position = camera.unproject_position(point)
	var viewport_center = viewport.size / 2
	var distance = (viewport_position - viewport_center).length()
	var weight = clamp(flight_pointer_weight * distance * delta, 0, 1)
	rotation.x = lerp_angle(rotation.x, flight_pointer.rotation.x, weight)
	rotation.y = lerp_angle(rotation.y, flight_pointer.rotation.y, weight)


func _toggle_zoom() -> void:
	zoom = not zoom


func _update_camera_fov(delta: float) -> void:
	var target_fov = zoom_fov if zoom else default_fov
	camera.fov = lerp(camera.fov, target_fov, zoom_weight * delta)


func _update_camera_position() -> void:
	transform.origin = aircraft.transform.origin
