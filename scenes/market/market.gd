extends Node3D

var _items: Array[PackedScene] = [
	preload("res://scenes/bomb.tscn")
]

func _spawn_items():
	$Item1.add_child(_items.pick_random().instantiate())

func _ready() -> void:
	_spawn_items()
