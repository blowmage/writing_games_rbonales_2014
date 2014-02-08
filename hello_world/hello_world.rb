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
  end

  def draw
    @image.draw self.width/2  - @image.width/2,
                self.height/2 - @image.height/2,
                1
  end
end

HelloWorldGame.new.show
