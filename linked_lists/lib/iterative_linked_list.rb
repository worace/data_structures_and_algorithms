class IterativeLinkedList < Struct.new(:head)
  include Enumerable

  def nodes
    if head.nil?
      []
    else
      [head] + head.children
    end
  end

  def each(&block)
    nodes.each(&block)
  end

  def [](index)
    nodes[index]
  end

  def insert(index, data)
    if index > count
      push(data)
    else
      left,right = self[(index - 1)..index]
      left.next = Node.new(data, right)
    end
  end

  def insert_after(anchor, data)
    if left = find(anchor)
      left.next = Node.new(data, left.next)
    end
  end

  def count
    nodes.count
  end

  def pop
    if head.nil?
      nil
    elsif head.next.nil?
      popped = head
      self.head = nil
      popped.data
    else
      current = head
      while current.next && current.next.next
        current = current.next
      end
      popped = current.next
      current.next = nil
      popped.data if popped
    end
  end

  def delete(data)
    if head.data == data
      self.head = head.next
    else
      if index = index(data)
        left,right = self[(index - 1)..index]
        left.next = right.next
      end
    end
  end

  def find(data)
    nodes.find { |n| n.data == data }
  end

  def index(data)
    nodes.map(&:data).index(data)
  end

  def push(data)
    if head
      tail.next = Node.new(data)
    else
      self.head = Node.new(data)
    end
  end

  def tail
    nodes.last
  end

  def to_a
    nodes.map(&:data)
  end

  def include?(data)
    to_a.include?(data)
  end
end

class Node < Struct.new(:data, :next)
  def children
    if self.next.nil?
      []
    else
      [self.next] + self.next.children
    end
  end

  def ==(other)
    other == data
  end
end
