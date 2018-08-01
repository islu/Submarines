class Player
	attr_reader :x, :y, :w, :h
	def initialize
		@img=Gosu::Image.new("image/ship_1.bmp")
		@w, @h=@img.width, @img.height
		@x, @y=500, 200
		@screen_w=1000
		@speed=3
		@max_bomb_carry=5
		@cd=0
		@cold=200
	end
	def right
		@x+=@speed if @x<@screen_w-@w
	end
	def left
		@x-=@speed if @x>0
	end
	def drop?(list, time_now)
		if list.size<@max_bomb_carry && @cd<time_now
			@cd=time_now+@cold
			true
		else
			false
		end
	end
	def draw
		@img.draw(@x, @y-@h, 1)
	end
end