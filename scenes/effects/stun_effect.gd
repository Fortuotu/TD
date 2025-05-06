class_name StunEffect extends Effect

const STUNNED_SPEED = 0.1

func apply(balloon: Balloon) -> void:
	var previous_speed = balloon.get_speed()
	balloon.set_speed(STUNNED_SPEED)
