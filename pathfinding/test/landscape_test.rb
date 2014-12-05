require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/spec'
require_relative '../lib/landscape'
require_relative '../lib/pathfinder'

describe Node do
  it "is passable if content is not '#'" do
    assert Node.new(" ").passable?
    assert Node.new("S").passable?
    refute Node.new("#").passable?
  end

  it "is the objective if content is 'F'" do
    assert Node.new("F").objective?
    refute Node.new("S").objective?
  end

  it 'has edges' do
    n = Node.new("", 0,0,"top", "right", "bottom", "left")
    assert_equal(["top", "right", "bottom", "left"], n.edges)
  end

  it 'leaves empty edges from edges' do
    n = Node.new("", 0,0,"top", "right", nil, "left")
    assert_equal(["top", "right", "left"], n.edges)
  end
end

describe Landscape do
  it "generates a landscape from a fixture file" do
    matrix = [["#", "#", "#", "#", "#", "#", "#", "#", "#", "#", "#"],
              ["#", " ", "S", " ", " ", " ", " ", " ", " ", " ", "#"],
              ["#", " ", "#", "#", "#", "#", "#", " ", "#", " ", "#"],
              ["#", " ", " ", " ", "#", " ", " ", " ", "#", " ", "#"],
              ["#", "#", "#", " ", "#", " ", "#", "#", "#", " ", "#"],
              ["#", " ", " ", " ", " ", " ", "#", " ", " ", " ", "#"],
              ["#", " ", "#", " ", "#", "#", "#", " ", "#", "#", "#"],
              ["#", " ", "#", " ", " ", " ", "#", " ", " ", " ", "#"],
              ["#", " ", "#", "#", "#", " ", "#", " ", "#", " ", "#"],
              ["#", " ", " ", " ", " ", " ", "#", " ", "F", " ", "#"],
              ["#", "#", "#", "#", "#", "#", "#", "#", "#", "#", "#"]]
    loaded = Landscape.load(File.join(__dir__, "fixtures", "landscape1.txt")).matrix
    matrix.each_with_index do |line, index|
      assert_equal line, loaded[index], "line #{index} did not match"
    end
  end

  it "creates nodes for each square in the graph" do
    loaded = Landscape.load(File.join(__dir__, "fixtures", "landscape1.txt"))
    assert_equal loaded.matrix.map(&:count).reduce(:+), loaded.nodes.count
    assert loaded.nodes.all? { |n| n.is_a?(Node) }
  end

  it "connects nodes to other nodes" do
    loaded = Landscape.load(File.join(__dir__, "fixtures", "landscape1.txt"))
    assert_equal [0,0], loaded.nodes.first.coords
    assert_equal [1,0], loaded.nodes.first.right.coords
    assert_equal [0,1], loaded.nodes.first.bottom.coords
    assert_equal [2,0], loaded.nodes.first.right.right.coords
    assert_nil loaded.nodes.first.left
    assert_nil loaded.nodes.first.top
  end

  it "prints itself" do
    landscape = Landscape.load(File.join(__dir__, "fixtures", "landscape1.txt"))
    assert_equal File.read(File.join(__dir__, "fixtures", "landscape1.txt")).chomp, landscape.to_s
  end

  it "finds start and finish" do
    landscape = Landscape.load(File.join(__dir__, "fixtures", "landscape1.txt"))
    assert_equal [2,1], landscape.start.coords
    assert_equal [8,9], landscape.finish.coords
  end
end

describe Pathfinder do
  before do
    @landscape = Landscape.load(File.join(__dir__, "fixtures", "landscape1.txt"))
    @pathfinder = Pathfinder.new
  end

  describe "#solve" do
    it "returns a path as an array of coordinates" do
      solution = [[2,1],[3,1],[4,1],[5,1],[6,1],[7,1],[8,1],[9,1],
                  [9,2],[9,3],[9,4],[9,5],[8,5],[7,5],[7,6],
                  [7,7],[7,8],[7,9],[8,9]]
      assert_equal solution, @pathfinder.solve(@landscape)
    end
  end
end
