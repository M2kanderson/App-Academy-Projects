class Queue
  def initialize
    @queue = []
  end

  def enqueue(el)
    @queue.unshift(el)
  end

  def dequeue
    @queue.pop
  end

  def show
    @queue
  end

end


queue = Queue.new

queue.enqueue(1)
p queue.show
queue.enqueue(2)
p queue.show
queue.enqueue(3)
p queue.show
queue.enqueue(4)
p queue.show
queue.enqueue(5)
p queue.show
queue.dequeue
p queue.show
queue.dequeue
p queue.show
queue.enqueue(6)
p queue.show
queue.dequeue
p queue.show
queue.dequeue
p queue.show
