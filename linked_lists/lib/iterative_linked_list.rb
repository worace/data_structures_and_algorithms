class IterativeLinkedList < Struct.new(:head)
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
end

class Node < Struct.new(:data, :next)
end
