extends TileMap

var speed = 10 
var acceleration = 5
var final_speed = 250

func _process(delta):
	self.position.x -= speed * delta
	
	if final_speed != speed:
		if final_speed < speed:
			speed -= acceleration
		else:
			speed += acceleration
			
	
	

func modify_speed(new_final_speed):
	final_speed = new_final_speed
