class Image
	attr_reader :x,:y,:w,:h
	def initialize(img,x,y,z)
		@img = Gosu::Image.new(img)
		@w,@h = @img.width,@img.height
		@x,@y,@z = x,y,z
	end
	def draw
		@img.draw(@x,@y,@z)
	end
end
class Player < Image
	def initialize
		super "image/ship_1.bmp",500,200,1
		@screen_w = 1000
		@speed = 3
		@max_bomb_carry = 5
		@cd = 0
		@cold = 200

		@b_img = Gosu::Image.new("image/bomb.bmp")
		#@b_w, @b_h = @b_img.width, @b_img.height

	end
	def right
		@x+=@speed if @x<@screen_w-@w
	end
	def left
		@x-=@speed if @x>0
	end
	def drop?(list,currtime)
		if list.size<@max_bomb_carry && @cd<currtime
			@cd = currtime+@cold
			true
		else
			false
		end
	end
	
	def draw
		@img.draw(@x,@y-@h,@z)
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
