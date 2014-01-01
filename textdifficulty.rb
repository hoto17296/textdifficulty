require 'RMagick'

class TextDifficulty

  attr_accessor :cache, :font, :size

  def initialize(csv=nil)
    load_cache csv
    @font = "ipag.ttf"
    @size = 100
  end

  def load_cache(csv)
    @cache = {}
    return if csv.nil?
    open(csv) do |file|
      file.each do |line|
        line = line.split(',')
        @cache[line[0]] = line[1]
      end
    end
  end

  def difficulty(str)
    0xFFFF - depth(str)
  end

  def depth(str)
    return 0xFFFF if str.length == 0
    sum = 0
    str.chars do |chr|
      sum += depth_chr chr
    end
    sum / str.length
  end
  
  def depth_chr(chr)
    return @cache[chr] if @cache.has_key?(chr)

    image = Magick::Image.new(@size, @size) { self.background_color = 'white' }
    draw = Magick::Draw.new
    
    font = @font; size = @size
    draw.annotate(image, 0, 0, 0, 0, chr) do
      self.font      = font
      self.fill      = 'black'
      self.stroke    = 'transparent'
      self.pointsize = size
      self.gravity   = Magick::NorthWestGravity
    end
    
    ave = 0
    for y in 0...image.rows
      for x in 0...image.columns
        ave += image.pixel_color(x, y).red
      end
    end
    depth = ave / @size ** 2

    @cache[chr] = depth
    return depth
  end

end

