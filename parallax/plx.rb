require "gosu"

class Sprite
  attr_accessor :x, :y, :width, :height, :min_x, :max_x
  def initialize window
    @window = window
    # image
    @width = @height = 160
    @idle = Gosu::Image.load_tiles @window,
                                   "player_160x160_idle.png",
                                   @width, @height, true
    @move = Gosu::Image.load_tiles @window,
                                   "player_160x160_move.png",
                                   @width, @height, true
    # center image
    @x = @window.width/2  - @width/2
    @y = @window.height/2 - @height/2
    # bounds
    @min_x = 0
    @max_x = @window.width
    # direction and movement
    @direction = :right
    @frame = 0
    @moving = false
  end

  def update
    @frame += 1
    @moving = false
    if @window.button_down? Gosu::KbLeft
      @direction = :left
      @moving = true
      @x += -5
      @x = @min_x if @x < @min_x
    elsif @window.button_down? Gosu::KbRight
      @direction = :right
      @moving = true
      @x += 5
      @x = @max_x if @x > @max_x
    end
  end

  def draw
    # @move and @idle are the same size,
    # so we can use the same frame calc.
    f = @frame % @idle.size
    image = @moving ? @move[f] : @idle[f]
    if @direction == :right
      image.draw @x, @y, 1
    else
      image.draw @x + @width, @y, 1, -1, 1
    end
  end

end

class PlxGame < Gosu::Window
  def initialize width=800, height=600, fullscreen=false
    super
    @foreground = Gosu::Image.new(self, "foreground.png", false)
    @background = Gosu::Image.new(self, "background.png", false)
    @sprite = Sprite.new self
    @sprite.max_x = @foreground.width
    @movement = 8
    @x = @y = 0
  end

  def update
    close      if button_down? Gosu::KbEscape
    @sprite.update
  end

  def plx_ratio
    @plx_ratio ||= (@background.width - self.width) / (@foreground.width - self.width).to_f
  end

  def plx_coords
    [(cam_coords.first * plx_ratio), 0]
  end

  def cam_coords
    cam_x = [[@sprite.x - self.width/2, 0].max, [@sprite.x + self.width/2, @foreground.width - self.width].min].min
    [0 - cam_x, 0 - @y]
  end

  def draw
    translate *plx_coords do
      @background.draw 0, 0, -2
    end
    translate *cam_coords do
      @foreground.draw 0, 0, -1
      @sprite.draw
    end
  end
end

PlxGame.new.show
