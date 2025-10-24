extends AnimatedSprite2D

func die():
	play("death")

func idle():
	play("idle meow")

func standing():
	play("standing pose")
	
func drinking():
	play("drinking")

func jump():
	play("jump")
