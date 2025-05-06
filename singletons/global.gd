extends Node

var _wave_spawner: WaveSpawner
var money_counter = 0

func set_wave_spawner(wave_spawner: WaveSpawner):
	_wave_spawner = wave_spawner

func get_wave_spawner():
	return _wave_spawner
