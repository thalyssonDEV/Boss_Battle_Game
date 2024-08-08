extends CharacterBody2D
class_name Player

const SPEED = 170
const JUMP_VELOCITY = -300.0

@onready var animated_sprite = $AnimatedSprite2D
var attack:bool = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: float = 0;

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
				 		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	direction = Input.get_axis("left", "right") if !attack else 0
	if attack:
		velocity.x = 0.0
	
	move_and_slide()
	animations(direction);

## Função responsável por cotrolar as animações do personagem.	
func animations(direction):
	# Permite a movimentação do personagem apenas se ele n estiver atacando, exceto o pulo.
	if !attack:
		if is_on_floor():
			if direction == 0:
				animated_sprite.play("idle")
			elif direction != 0:
				animated_sprite.play("run")
	
	if Input.is_action_just_pressed("jump"):
			animated_sprite.play("jump")
			
	if Input.is_action_just_pressed("attack"):
		attack = true
		# Verifica se o personagem esta no chão ou no ar e define uma animação de ataque para cada uma das possibilidades
		if is_on_floor():
			animated_sprite.play("basic_attack")
		else:
			animated_sprite.play("jump_attack")
		velocity = Vector2.ZERO;
		# Espera a animção de ataque finalizar para permitir o movimento novamente.
		await (animated_sprite.animation_finished)
		attack = false;
		
	# Inverte a posição do personagem de acordo com seu eixo.		
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
