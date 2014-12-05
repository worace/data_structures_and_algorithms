class Node < Struct.new(:content, :x, :y, :top, :right, :bottom, :left)
  DIRECTIONS = {:top => [0, -1], #treating top-left as origin so negative vertical is up
                :right => [1, 0],
                :bottom => [0, 1],
                :left => [-1, 0]
               }

  def set_edges(matrix)
    DIRECTIONS.each do |dir, coords|
      if (0..matrix.length-1).include?(y + coords.last) && (0..matrix.first.length-1).include?(x + coords.first)
        node = matrix[(y + coords.last)][(x + coords.first)]
        self.send("#{dir}=", node)
      end
    end
  end

  def edges
    [top, right, bottom, left].compact
  end

  def coords
    [x,y]
  end

  def to_s
    "Node at #{coords} with content #{content} and #{edges.count} edges"
  end

  def inspect
    to_s
  end

  def passable?
    content != "#"
  end

  def objective?
    content == "F"
  end
end
class Landscape
  attr_reader :matrix

  def initialize(matrix)
    @matrix = matrix
  end

  def nodes
    @nodes ||= generate_nodes_from_matrix
  end

  def generate_nodes_from_matrix
    node_matrix = matrix.each_with_index.map do |row, row_index|
                    row.each_with_index.map do |content, col_index|
                      Node.new(content, col_index, row_index)
                    end
                  end
    node_matrix.flatten.map { |node| node.set_edges(node_matrix); node }
  end

  def self.load(file_path)
    matrix = File.open(file_path) do |file|
              file.each_line.map do |line|
                line.chomp!.chars
              end
            end
    self.new(matrix)
  end

  def to_s
    matrix.map { |l| l.join("") }.join("\n")
  end

  def start
    nodes.find { |n| n.content == "S" }
  end

  def finish
    nodes.find { |n| n.content == "F" }
  end

  def element_coords(element)
    row = matrix.find { |f| f.include?(element) }
    y = matrix.index(row)
    x = row.index(element)
    [x,y]
  end
end
