#coding: utf-8
require 'gosu'
require_relative 'ui'
require_relative 'animation'
require_relative 'player'
require_relative 'submarine'
require_relative 'bomb'

class Main < Gosu::Window
	def initialize
		super 1000,500
		self.caption = "Submarine Fight"
		@ui = UI.new
		@ui.play_bgm
		@score=0
		
		@lose=false
		#explosion animation
		@animations = []
		
		@sound_effext = Gosu::Song.new("audio/explosion.wav")
		@exp_x=-100
		@exp_y=-100
		@show_time=0
		#player, enemy, bomb
		@player=Player.new
		@bombs=[] # => Array
		@enemys=[] # => Array
		@enemys_cd=0
		@enemys_cold=200
		@torpedos=[]
	end
	def update
		unless @lose
			#update player state
			button_down?(Gosu::KB_RIGHT) and @player.right
			button_down?(Gosu::KB_LEFT) and @player.left
			if @player.drop?(@bombs, Gosu.milliseconds)
				button_down?(Gosu::KB_Z) and @bombs << Bomb.new(@player.x, @player.y)
				button_down?(Gosu::KB_X) and @bombs << Bomb.new(@player.x+@player.w/2, @player.y)
				button_down?(Gosu::KB_C) and @bombs << Bomb.new(@player.x+@player.w, @player.y)
			end
			#create enemy
			if @enemys_cd<Gosu.milliseconds
				rand()<0.05 and @enemys<<FromLeftSubmarine.new
				rand()<0.05 and @enemys<<FromRightSubmarine.new
				@enemys_cd=Gosu.milliseconds+@enemys_cold
			end
			#enemy drop the torpedo
			@enemys.each do |enemy|
				if enemy.dead == false
					rand()<0.015 and @torpedos<<Torpedo.new(enemy.x+enemy.w, enemy.y)
				end
			end
			#check collision between bomb and ship
			self.collision(@bombs, @enemys)
			@torpedos.each do |torpedo|
				if torpedo.x+torpedo.w/2>@player.x && torpedo.x+torpedo.w/2<@player.x+@player.w && torpedo.y<200+torpedo.h/2
					torpedo.dead=(true)
					@animations << Explosion.new(@player.x+@player.w/2, @player.y-@player.h/2, Gosu.milliseconds)
					@lose=true
				end
			end
			#update bomb state
			@bombs.each(&:move)
			@bombs.reject!(&:update)
			#update enemy state
			@enemys.each(&:move)
			@enemys.reject!(&:update)
			@torpedos.each(&:move)
			@torpedos.reject!(&:update)
=begin
			The same as people.collect { |p| p.name }
				people.collect(&:name)
			The same as people.select { |p| p.manager? }.collect { |p| p.salary }
				people.select(&:manager?).collect(&:salary)
=end
		end
		button_down?(Gosu::KB_ESCAPE) and exit
		button_down?(Gosu::KB_R) and self.restart
		
		@animations.delete_if(&:die?)		
		@ui.stop_bgm if @lose
	end
	def collision(bombs, ships)
		bombs.each do |bomb|
			ships.each do |ship|
				if Gosu.distance(bomb.x+bomb.w, bomb.y+bomb.h ,ship.x+ship.w, ship.y+ship.h) < 20
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
	def restart
		@player=Player.new
		@bombs=[]
		@enemys=[]
		@torpedos=[]
		@score=0
		@lose=false
		#@ui.play_bgm
	end
	def draw
		#draw player, bomb, enemy
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
