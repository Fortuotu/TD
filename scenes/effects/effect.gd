class_name Effect extends Node

const STUNNED_SPEED = 0.1

func apply(balloon: Balloon):
	var previous_speed = balloon.get_speed()
	
	balloon.set_speed(STUNNED_SPEED)
