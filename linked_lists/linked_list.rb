class LinkedList
  attr_reader :head
  # holds the reference to head
  # contains all the methods (push, count, ....)
  # methods will need to be implemented in terms of head
  # since head is the only thing the list really knows about
  # pizza -> stromboli -> lasagna
  # 1 + count(stromboli)
  # 1 + 1 + count(lasagna)
  # 1 + 1 + 1 + count(nil)
  # 1 + 1 + 1 + 0 -> 3
  def count(node = head)
    if node.nil?
      0
    else
      1 + count(node.next_node)
    end
  end

  def push(data, node = head)
    if node.nil?
      @head = Node.new(data)
    else
      if node.next_node.nil?
        node.next_node = Node.new(data)
      else
        push(data, node.next_node)
      end
    end
  end

  def position(index, node = head)
    return nil if node.nil?
    if index == 0
      node.data
    else
      position(index - 1, node.next_node)
    end
  end

  def pop(node = head)
    if node.nil?
      @head = nil
    elsif node.next_node && node.next_node.next_node.nil?
      node.next_node = nil
    else
      pop(node.next_node)
    end
  end
end

class Node
  attr_accessor :data, :next_node

  def initialize(data)
    @data = data
  end
end
