class Node < Struct.new(:data, :left, :right)
end

class BinarySearchTree
  attr_reader :root_node

  def push(data, node = root_node)
    @root_node = Node.new(data) and return if root_node.nil?
    if data <= node.data
      if node.left
        push(data, node.left)
      else
        node.left = Node.new(data)
      end
    else
      if node.right
        push(data, node.right)
      else
        node.right = Node.new(data)
      end
    end
  end

  def count(node = root_node)
    return 0 unless node
    1 + count(node.left) + count(node.right)
  end

  def include?(data, node = root_node)
    return false unless node
    node.data == data || include?(data, node.left) || include?(data, node.right)
  end

  def max_depth(node = root_node)
    return 0 unless node
    [(1 + max_depth(node.left)), (1 + max_depth(node.right))].max
  end

  def min(node = root_node)
    return nil unless node
    min(node.left) || node.data
  end

  def max(node = root_node)
    return nil unless node
    max(node.right) || node.data
  end

  def to_array(node = root_node)
    return [] unless node
    [node.data] + to_array(node.left) + to_array(node.right)
  end

  def sort(node = root_node)
    return [] unless node
    sort(node.left) + [node.data] + sort(node.right)
  end

  def post_ordered(node = root_node)
    return [] unless node
    post_ordered(node.left) + post_ordered(node.right) + [node.data]
  end

  def min_height(node = root_node)
    return 0 unless node
    [1 + min_height(node.left), 1 + min_height(node.right)].min
  end

  def max_height(node = root_node)
    return 0 unless node
    [1 + max_height(node.left), 1 + max_height(node.right)].max
  end

  def balanced?
    (max_height - min_height).abs <= 1
  end

  def balance!
    data = to_array
    new_root = data.delete(data.length/2)
    @root_node = Node.new(new_root)
    data.each { |i| push(i) }
  end
end
