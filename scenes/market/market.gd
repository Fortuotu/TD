extends Node3D

var _items: Array[PackedScene] = [
	preload("res://scenes/bomb.tscn")
]

func _spawn_items():
	$Item1.add_child(_items.pick_random().instantiate())

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_left"):
		_spawn_items()

func _ready() -> void:
	_spawn_items()
