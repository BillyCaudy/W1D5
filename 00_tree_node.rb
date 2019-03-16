class PolyTreeNode

  attr_reader :value, :parent, :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(parent_node = nil)
    if @parent != parent_node
      if @parent != nil
        siblings = @parent.children 
        siblings.delete_at(siblings.index(self)) 
      end
      @parent = parent_node 
      parent_node.children << self if parent_node != nil
    end
    parent_node
  end

  def add_child(child)
    child.parent = self if child.parent != self
  end

  def remove_child(child)
    raise "The node: \n#{child} \nis not a child of the node: \n#{self} \n" if child.parent != self
    child.parent = nil if child != nil
  end

  def dfs(target) #recursive
    return self if @value == target #base
    @children.each do |child| 
      target_node = child.dfs(target) #recursion
      return target_node if target_node != nil && target_node.value == target
    end
    nil
  end

  def bfs(target) #iterative
    
    # return self if @value == target 
    # search_queue = @children.dup
    
    search_queue = [self]

    until search_queue.empty?
      node = search_queue.shift
      return node if node.value == target
      search_queue += node.children
      
    end
    nil
  end

  # def inspect
  #   return self
  #   # parent_val = @parent.value if @parent != nil #else parent_val = nil
  #   # chill_vals = []
  #   # @children.each { |child| chill_vals << child.value }
  #   # return "value = #{@value}, parent = #{parent_val||"nil"}, children = #{chill_vals}"
  # end

end