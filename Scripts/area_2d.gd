extends Area2D

#Garbage Collector
func _on_body_entered(body: Node2D) -> void:
	body.queue_free()
