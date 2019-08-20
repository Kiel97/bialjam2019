extends Node

func raise_error(error_code : int) -> void:
	print_stack()
	printerr("Error code: ", error_code)