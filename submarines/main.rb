#coding: utf-8

require 'gosu'
require_relative 'lib/ui'
require_relative 'lib/animation'
require_relative 'lib/player'
require_relative 'lib/submarine'
require_relative 'lib/bomb'

class Main < Gosu::Window
	# Creates a new window with the specified width and height,
	# and also initializes the game state.
	#
	# @param width [Integer] the width of the window
	# @param height [Integer] the height of the window
	def initialize
		super 1000,500
		self.caption = "Submarines"

		# Creates a new UI object and starts playing the background music
		@ui = UI.new
		@ui.play_bgm

		# Set the initial score to 0
		@score=0

		# Set the initial game state to not lose
		@lose=false

		# Create an empty array to store the explosion animations
		@animations = []

		# Load the explosion sound effect
		@sound_effext = Gosu::Song.new("sound/explosion.wav")

		# Store the position of the explosion animation
		@exp_x=-100
		@exp_y=-100

		# Store the time when the explosion animation should be shown
		@show_time=0

		# Create a new player object
		@player=Player.new

		# Create an empty array to store the bombs
		@bombs=[] # => Array

		# Create an empty array to store the enemies
		@enemys=[] # => Array

		# Store the time when the enemies can be created
		@enemys_cd=0

		# Store the time between the creation of enemies
		@enemys_cold=200

		# Create an empty array to store the torpedos
		@torpedos=[]
	end

	# Update the game state
	def update
		unless @lose
			# update player state
			button_down?(Gosu::KB_RIGHT) and @player.right
			button_down?(Gosu::KB_LEFT) and @player.left
			if @player.drop?(@bombs, Gosu.milliseconds)
				button_down?(Gosu::KB_Z) and @bombs << Bomb.new(@player.x, @player.y)
				button_down?(Gosu::KB_X) and @bombs << Bomb.new(@player.x+@player.w/2, @player.y)
				button_down?(Gosu::KB_C) and @bombs << Bomb.new(@player.x+@player.w, @player.y)
			end

			# Create new enemies
			if @enemys_cd<Gosu.milliseconds
				# Randomly decide to create an enemy from the left or right
				rand()<0.05 and @enemys<<FromLeftSubmarine.new
				rand()<0.05 and @enemys<<FromRightSubmarine.new
				@enemys_cd=Gosu.milliseconds+@enemys_cold
			end

			# Create torpedos
			@enemys.each do |enemy|
				if enemy.dead == false
					rand()<0.015 and @torpedos<<Torpedo.new(enemy.x+enemy.w, enemy.y)
				end
			end

			# Check for collision between bombs and enemies
			self.collision(@bombs, @enemys)

			# Check for collision between torpedos and player
			@torpedos.each do |torpedo|
				if torpedo.x+torpedo.w/2>@player.x && torpedo.x+torpedo.w/2<@player.x+@player.w && torpedo.y<200+torpedo.h/2
					torpedo.dead=(true)
					@animations << Explosion.new(@player.x+@player.w/2, @player.y-@player.h/2, Gosu.milliseconds)
					@lose=true
				end
			end

			# Update positions of bombs, enemies, and torpedos
			@bombs.each(&:move)
			@bombs.reject!(&:update)

			@enemys.each(&:move)
			@enemys.reject!(&:update)
			@torpedos.each(&:move)
			@torpedos.reject!(&:update)

		end

		# Check for quit or restart
		button_down?(Gosu::KB_ESCAPE) and exit
		button_down?(Gosu::KB_R) and self.restart

		# Remove dead animations
		@animations.delete_if(&:die?)
		@ui.stop_bgm if @lose
	end

	# Check for collision between bombs and enemies
	def collision(bombs, ships)
		bombs.each do |bomb|
			ships.each do |ship|
				#
				if overleap(bomb, ship)
					bomb.dead = (true)
					ship.dead = (true)
					@animations << Explosion.new(bomb.x, bomb.y+bomb.h, Gosu.milliseconds)
					@sound_effext.play

					chain = @animations.length
					case ship.id
					when 1..4
						@animations[-1].set_text(20,chain)
						@score += 20*chain
					when 5,6
						@animations[-1].set_text(30,chain)
						@score += 30*chain
					when 7,8
						@animations[-1].set_text(40,chain)
						@score += 40*chain
					end
				end
			end
		end
	end

	# Checks if two objects are overlapping
	# @param obj1 [Object] first object
	# @param obj2 [Object] second object
	# @return [Boolean] whether the two objects are overlapping
	def overleap(obj1, obj2)
		return !(obj1.x+obj1.w < obj2.x || obj1.x > obj2.x+obj2.w || obj1.y+obj2.h < obj2.y || obj1.y > obj2.y+obj2.h)
	end

	# Restarts the game
	#
	# Resets player, bombs, enemies, torpedos, score and game state
	def restart
		@player=Player.new
		@bombs=[]
		@enemys=[]
		@torpedos=[]
		@score=0
		@lose=false
	end

	# This method is a callback for Gosu.
	# It's called about 60 times per second.
	def draw

		unless @lose
			@player.draw
			@player.draw_remained_bombs(@bombs)
		end
		@bombs.each(&:draw)
		@enemys.each(&:draw)
		@torpedos.each(&:draw)

		@ui.draw_background
		@ui.draw_score(@score)
		@ui.draw_lose_menu if @lose

		@animations.each(&:draw)
		@animations.each(&:draw_text)

	end
end

Main.new.show
