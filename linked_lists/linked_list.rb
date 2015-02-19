class LinkedList
  attr_reader :head
  # holds the reference to head
  # contains all the methods (push, count, ....)
  # methods will need to be implemented in terms of head
  # since head is the only thing the list really knows about
  def initialize(head = nil)
    @head = head
  end

  def position(index)
    if index == 0
      head
    else
      position = 0
      current_node = head
      while position < index
        return nil if current_node.nil?
        position = position + 1
        current_node = current_node.next_node
      end
      current_node
    end
  end

  # head v
  # pizza -> hello -> world -> today -> nil
  # list.recursive_count
  # pizza:
  # 1 + recursive_count(hello)
  # 1 + 1 + recursive_count(world)
  # 1 + 1 + 1 + recursive_count(today)
  # 1 + 1 + 1 + 1 + recursive_count(nil)
  # 1 + 1 + 1 + 1 + 0

  def recursive_count(node = head)
    if node.nil?
      0
    else
      1 + recursive_count(node.next_node)
    end
  end

  def count
    if head.nil?
      0
    else
      count = 1
      current_node = head
      while current_node.next_node
        count = count + 1
        current_node = current_node.next_node
      end
      count
    end
  end

  def push(data)
    node = Node.new(data) #next_node of this will be nil
    if head.nil?
      @head = node
    else
      # Question: how to iterate these dynamically?????
      # while we have more nodes
      # keep walking down
      # when we run out of next nodes
      # assign the new node as the next node
      # of our current one
      current_node = head
      while current_node.next_node
        current_node = current_node.next_node
      end
      #stop at the point where there is no next node
      #node is my new node
      #current_node is now the last node <--- key
      current_node.next_node = node
    end
  end
end

class Node
  attr_reader :data
  attr_accessor :next_node
  def initialize(data, next_node = nil)
    @data = data
    @next_node = next_node
  end
end

# OLD APPENDING CODE:
#if head.next_node.nil?
  #head.next_node = node
#else
  #puts "assigning node of data #{data} to next node next node of head"
  #if head.next_node.next_node.nil?
    #head.next_node.next_node = node
  #else
    #head.next_node.next_node.next_node = node
  #end
#end
