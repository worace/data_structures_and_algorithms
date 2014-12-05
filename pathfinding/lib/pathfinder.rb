class Pathfinder
  def solve(landscape)
    start = landscape.start
    sources = {}
    sources[start] = nil
    frontier = [start]
    objective = nil
    while (current_node = frontier.shift) && (objective.nil?) do
      current_node.edges.each do |next_node|
        unless sources.has_key?(next_node)
          frontier << next_node if next_node.passable?
          sources[next_node] = current_node
          objective = next_node and break if next_node.objective?
        end
      end
    end
    path = [objective]
    while previous_node = sources[path.first] do
      path.unshift(previous_node)
    end
    path.map(&:coords)
  end
end
