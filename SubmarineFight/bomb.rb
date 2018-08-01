class Bomb
	attr_reader :x, :y, :w, :h
	def initialize(x, y)
		@img=Gosu::Image.new("image/bomb.bmp")
		@w, @h=@img.width, @img.height
		@x, @y=x, y
		@screen_h=500
		@speed=2
		@dead=false
	end
	def move
		@y+=@speed
	end
	def dead=(state)
		@dead=state
	end
	def update
		if @y>@screen_h
			true
		elsif @dead
			true
		else
			false
		end
	end
	def draw
		@img.draw(@x-@w/2, @y, 1)
	end
end

class Torpedo
	attr_reader :x, :y, :w, :h
	def initialize(x, y)
		@img=Gosu::Image.new("image/torpedo.bmp")
		@w, @h=@img.width, @img.height
		@x, @y=x, y
		@screen_h=500
		@speed=rand(1..2)
		@dead=false
	end
	def dead=(state)
		@dead=state
	end
	def move
		@y-=@speed
	end
	def update
		if @y<200-@h/2
			true
		elsif @dead
			true
		else
			false
		end	
	end
	def draw
		@img.draw(@x-@w/2, @y, 1)
	end
end