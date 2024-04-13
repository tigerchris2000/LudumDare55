extends Node

func _on_TextureRect_gui_input(ev):  
	if ev is InputEventMouseButton and ev.doubleclick:
		print("yippee")
	
