require "gosu"

class HelloWorldGame < Gosu::Window
  def initialize width=800, height=600, fullscreen=false
    super
    self.caption = "Hello world!"
    @image = Gosu::Image.from_text self,
                                   "Hello world!",
                                   Gosu.default_font_name,
                                   100
  end

  def button_down id
    close if id == Gosu::KbEscape
  end

  def update
    center_x = self.width/2
    center_y = self.height/2
    @image_x  = center_x - @image.width/2
    @image_y  = center_y - @image.height/2
    @image_x += 150 * Math.sin(Time.now.to_f)
    @image_y += 200 * Math.cos(Time.now.to_f)
  end

  def draw
    @image.draw @image_x, @image_y, 1
  end
end

HelloWorldGame.new.show
