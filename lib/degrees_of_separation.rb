class Edge
  attr_accessor :src, :dst
  
  def initialize(src, dst)
    @src = src
    @dst = dst
  end
end

class Graph < Array
  attr_reader :edges
  
  def initialize
    @edges = []
  end
  
  def connect(src, dst)
    unless self.include?(src)
      raise ArgumentException, "No such vertex: #{src}"
    end
    unless self.include?(dst)
      raise ArgumentException, "No such vertex: #{dst}"
    end
    @edges.push Edge.new(src, dst)
  end
  
  def connect_both(v1, v2)
    self.connect v1, v2
    self.connect v2, v1
  end

  def neighbors(v)
    neighbors = []
    @edges.each do |edge|
      neighbors.push edge.dst if edge.src == v
    end
    return neighbors.uniq
  end

  def distance_between(src, dst)
    @edges.each do |edge|
      return 1 if edge.src == src and edge.dst == dst
    end
    nil
  end

  def degrees_of_separation(src, dst = nil)
    distances = {}
    previous_nodes = {}
    self.each do |v|
      distances[v] = nil
      previous_nodes[v] = nil
    end
    distances[src] = 0
    vertices = self.clone
    until vertices.empty?
      nearest_vertex = vertices.inject do |a, b|
        next b unless distances[a]
        next a unless distances[b]
        next a if distances[a] < distances[b]
        b
      end
      break unless distances[nearest_vertex] # Infinity
      if dst and nearest_vertex == dst
        return distances[dst] - 1
      end
      neighbors = vertices.neighbors(nearest_vertex)
      neighbors.each do |vertex|
        alt = distances[nearest_vertex] + vertices.distance_between(nearest_vertex, vertex)
        if distances[vertex].nil? or alt < distances[vertex]
          distances[vertex] = alt
          previous_nodes[vertices] = nearest_vertex
          # decrease-key v in Q # ???
        end
      end
      vertices.delete nearest_vertex
    end
    if dst
      return nil
    else
      return distances
    end
  end
end