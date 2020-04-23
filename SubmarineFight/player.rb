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
		
		@b_img = Gosu::Image.new("image/bomb.bmp")
		#@b_w, @b_h = @b_img.width, @b_img.height

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
	def draw_remained_bombs(bombs)
		remained = @max_bomb_carry-bombs.length
		x = @screen_w/2-50
		offset = 20
		(remained).times do |b|
			@b_img.draw(x, 0, 1)
			x += offset
		end
	end
end