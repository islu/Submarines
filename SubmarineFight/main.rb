#coding: utf-8
require 'gosu'
require_relative 'ui'
require_relative 'player'
require_relative 'submarine'
require_relative 'bomb'

class Main < Gosu::Window
	def initialize
		super(1000, 500)
		self.caption = "Submarine💣Fight"
		@ui = UI.new
		@score=0
		@lose=false
		#explosion animation
		@animation=Gosu::Image.load_tiles("image/explosion.bmp", 62, 62) # => Image[]
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
			button_down?(Gosu::KB_C) and @player.drop?(@bombs, Gosu.milliseconds) and @bombs<<Bomb.new(@player.x+@player.w/2, @player.y)
			#create enemy
			if @enemys_cd<Gosu.milliseconds 
				rand()<0.02 and @enemys<<FromLeftSubmarine.new
				rand()<0.02 and @enemys<<FromRightSubmarine.new
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
					@exp_x=torpedo.x
					@exp_y=torpedo.y-torpedo.h-20
					@show_time=Gosu.milliseconds+1500
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
		button_down?(Gosu::KB_R) and self.init
	end 
	def collision(bombs, ships)
		bombs.each do |bomb|
			ships.each do |ship|
				if Gosu.distance(bomb.x+bomb.w, bomb.y+bomb.h ,ship.x+ship.w, ship.y+ship.h) < 20
					bomb.dead=(true)
					ship.dead=(true)
					@exp_x=bomb.x
					@exp_y=bomb.y+10
					@show_time=Gosu.milliseconds+1500
					case ship.id
					when 1..4
						@score+=100
					when 5,6
						@score+=200
					when 7,8
						@score+=500
					end
				end	
			end
		end
	end
	def init
		@player=Player.new
		@bombs=[]
		@enemys=[]
		@torpedos=[]
		@score=0
		@lose=false
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
		if @show_time>Gosu.milliseconds then @animation[(Gosu.milliseconds/100)% @animation.size].draw(@exp_x, @exp_y, 2) end		

		@ui.draw_background
		@ui.draw_text(@score)			
		@ui.draw_lose_menu if @lose

	end
end

Main.new.show