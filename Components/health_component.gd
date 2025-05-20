@icon("../module.svg")
extends Node
class_name HealthComponent
## Used for managing a Node's health. 

## Total/maximum amount of health.
@export var max_health: int

## Current amount of health,[br]
## [b]Default is [member HealthComponent.max_health][/b].
@onready var health: int = max_health
@onready var overkill: int = 0

## Boolean for if the Node is alive or dead.
var alive = true

## Signal that is emitted when the Node dies.
signal Died

## Reduces the [member HealthComponent.health] by the amount specified,[br]
## and will kill if the [member HealthComponent.health] reaches 0.
func damage(amount: int) -> void:
	health -= amount

func flush() -> void:
	if health <= 0:
		kill()

## Kills the Node, which emits the [signal HealthComponent.Died],
## sets [code]health = 0[/code], and [code]alive = false[/code].
func kill() -> void:
	alive = false
	overkill = abs(health)
	Died.emit()
