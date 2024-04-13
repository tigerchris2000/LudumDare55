extends Node

var MouseOver = false

func _on_start_button_down():
	print("Start")


func _on_exit_button_down():
	get_tree().quit()
