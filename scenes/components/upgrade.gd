class_name Upgrade extends Node

static var _scene = preload("res://scenes/components/upgrade.tscn")

static func create(function: Callable, description: String) -> Upgrade:
	var inst: Upgrade = _scene.instantiate()
	inst.function = function
	inst.description = description
	return inst

var function: Callable
var description: String
