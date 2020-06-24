class Animation
	def initialize(tiles,w,h,x,y,z,lifetime)
		@tiles = Gosu::Image.load_tiles(tiles,w,h)
		@w,@h,@x,@y,@z = w,h,x,y,z
		@lifetime = lifetime
	end
	def draw
		currtime = Gosu.milliseconds
		if @lifetime > currtime
			i = (currtime/100) % @tiles.size
			@tiles[i].draw(@x-@w/2,@y-@h/2,@z)
		end
	end
	def die?
		@lifetime < Gosu.milliseconds
	end
end

class Explosion < Animation
	def initialize(x,y,currtime)
		delay = 750
		@score,@chain = nil
		@font = Gosu::Font.new(25)
		super "image/explosion.bmp",62,62,x,y,2,currtime+delay
	end
	def set_text(score,chain)
		@score,@chain = score,chain
	end
	def draw_text
		@font.draw_text("#{@score}x#{@chain}", @x-@w/2,@y-@h/2+25,@z, 1.0, 1.0, Gosu::Color::YELLOW)
	end
end