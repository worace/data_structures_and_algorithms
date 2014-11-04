class IterativeLinkedList < Struct.new(:head)
  def [](index)
    return nil if (index + 1) > count
    i = 0
    current = head
    while i < index
      current = current.next
      i += 1
    end
    current
  end

  def insert(index, data)
    if index > count
      push(data)
    else
      left = self[index - 1]
      right = left.next
      left.next = Node.new(data, right)
    end
  end

  def insert_after(anchor, data)
    if left = find(anchor)
      right = left.next
      left.next = Node.new(data, right)
    end
  end

  def count
    if current_node = head
      count = 1
      while next_node = current_node.next
        current_node = next_node
        count += 1
      end
      count
    else
      0
    end
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
      popped.data
    end
  end

  def delete(data)
    return unless head
    if head.data == data
      self.head = head.next
    elsif head.next.nil?
    else
      current = head
      begin
        if current.next && current.next.data == data
          cut_node(current, current.next)
        end
      end while current = current.next
    end
  end

  def cut_node(previous, node_to_cut)
    previous.next = node_to_cut.next
  end

  def find(data)
    current = head
    while current
      return current if current.data == data
      current = current.next
    end
  end

  def index(data)
    i = 0
    current = head
    while current
      break if current.data == data
      current = current.next
      i += 1
    end
    i
  end

  def push(data)
    if head
      tail.next = Node.new(data)
    else
      self.head = Node.new(data)
    end
  end

  def tail
    if current_node = head
      while next_node = current_node.next
        current_node = next_node
      end
      current_node
    else
      nil
    end
  end

  def to_a
    if head.nil?
      []
    else
      a = []
      current = head
      while current
        a << current
        current = current.next
      end
      a.map(&:data)
    end
  end

  def include?(data)
    current = head
    while current
      return true if current.data == data
      current = current.next
    end
    false
  end
end

class Node < Struct.new(:data, :next)
end
