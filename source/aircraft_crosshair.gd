extends TextureRect

export (NodePath) var aircraft_path

onready var aircraft: Spatial = get_node(aircraft_path)
onready var viewport := get_viewport()
onready var camera := viewport.get_camera()


func _process(delta: float) -> void:
	var aircraft_direction: Vector3 = aircraft.transform.basis.z
	var point: Vector3 = aircraft.transform.origin + aircraft_direction * FlightPointer.DISTANCE
	if not camera.is_position_behind(point):
		var screen_position: Vector2 = camera.unproject_position(point)
		rect_position = screen_position - rect_size / 2
