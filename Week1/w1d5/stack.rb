class Stack

  attr_accessor :stack

  def initialize
      @stack = []
  end

  def add(el)
    @stack << el
  end

  def remove
    @stack.pop
  end

  def show
    @stack
  end

end

stack = Stack.new

stack.add(5)
p stack.show
stack.add(4)
p stack.show
stack.remove
p stack.show
stack.add(1)
p stack.show
stack.remove
p stack.show
stack.remove
p stack.show
