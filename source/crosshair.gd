extends TextureRect

export (NodePath) var flight_pointer_path

onready var flight_pointer: FlightPointer = get_node(flight_pointer_path)
onready var camera := get_viewport().get_camera()


func _process(delta: float) -> void:
	var screen_position = camera.unproject_position(flight_pointer.get_point())
	rect_position = screen_position - rect_size / 2
