class Map
  def initialize
    @map = []
  end

  def assign(key,value)
    unless (self.lookup(key))
      @map << [key,value]
    end
  end

  def lookup(key)
    @map.each do |keyval|
      if(key == keyval[0])
        return keyval[1]
      end
    end
    return nil
  end

  def remove(key)
    @map = @map.select do |keyval|
      key != keyval[0]
    end
  end

  def show
    @map
  end

end

map = Map.new

map.assign("hello", 1)
p map.show
map.assign("hello", 2)
p map.show
map.assign("bye", 3)
p map.show
map.assign("hola", 4)
p map.show
p map.lookup("bye")
map.remove("bye")
p map.show
