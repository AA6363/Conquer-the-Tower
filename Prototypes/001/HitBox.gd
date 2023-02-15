extends Area2D
class_name hitBox

export(int) var enemy_hp = 5
export(int) var bossHp = 99

func _on_HitBox_body_entered(body):
	if body is Player:
		if Global.player_lives <= 0:
			Global.player_lives = 3
			body.player_die()
		else:
			Global.player_lives -= 1
			get_tree().call_group("Hp", "size_reduction")
			AudioPlayer.play_sound(AudioPlayer.HURT)
		
	if body is Bullet:
		if get_parent() is walkingEnemey: #Detects if parent the bullet collided with enemy
			if enemy_hp <= 0:
				get_parent().queue_free()
			else:
				enemy_hp -=1
				AudioPlayer.play_sound(AudioPlayer.ENEHURT)
		if get_parent() is jumpingEnemey: #Detects if parent the bullet collided with enemy
			if enemy_hp <= 0:
				get_parent().queue_free()
			else:
				enemy_hp -=1
				AudioPlayer.play_sound(AudioPlayer.ENEHURT)
		if get_parent() is slimeBoss:
			if bossHp <= 0:
				get_parent().queue_free()
				
			else: 
				bossHp -= 1
				AudioPlayer.play_sound(AudioPlayer.ENEHURT)
		body.queue_free()


