extends Control

## Funções responsáveis por trocar o jogador de cena de acordo com o botão que for clicado.

func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/world.tscn")
	
func _on_options_pressed():
	get_tree().change_scene_to_file("res://scenes/opstions_menu.tscn")

func _on_exit_pressed():
	get_tree().quit()
