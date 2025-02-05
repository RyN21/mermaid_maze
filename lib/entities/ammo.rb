class Ammo
  attr_reader x, y
  def initialize x, y, direction
    @x = x
    @y = y
    @direction = direction
    @speed = 5
    @image = Gosu::Image.new("assets/images/ammo.png")
  end


  def update
    case @direction
    when :up then @y -= @speed
    when :down then @y += @speed
    when :left then @x -= @speed
    when :right then @x += @speed
  end

  def draw
    @image.draw(@x, @y, 1)
  end

end
