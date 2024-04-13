extends Node

func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):	
	if body.is_in_group("Spikes"):
		pass
