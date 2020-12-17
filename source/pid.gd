var Reference
class_name PID

var error_weight := 1.0
var integral_weight := 0.0
var derivative_weight := 1.0

var integral := 0.0
var previous_error := 0.0


func update(error: float, delta: float):
	integral += error * delta
	var derivative = (error - previous_error) / delta
	previous_error = error
	return error * error_weight + integral * integral_weight + derivative * derivative_weight
