require 'byebug'

class PolyTreeNode
  attr_reader :value, :parent, :children
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end
  
  def parent=(new_parent)
    if !(self.parent.nil?)
      prev_parent = self.parent
      # debugger
      prev_parent.children.delete(self)
    end
    @parent = new_parent 
    if !(new_parent.nil?)
      new_parent.children << self unless new_parent.children.include?(self)
    end
  end
  
  def inspect
    "#{self}, #{self.value}"
  end
  
  def add_child(child_node)
    child_node.parent = self
  end
  
  def remove_child(child)
    raise "node is not a child" if child.parent.nil?
    child.parent = nil
  end
  
  def dfs(target_value)
    return self if self.value == target_value
    
    unless children.empty?
      self.children.each do |child_node|
      result =  child_node.dfs(target_value)
      return result if result
      end
    end
    nil
  end
  
  
  def bfs(target_value)
     local_array = [self]
     until local_array.length == 0
       first_node = local_array.shift 
       # debugger
         if first_node.value == target_value
           return first_node
         else
           local_array += first_node.children
         end
       end
  end
end

p1 = PolyTreeNode.new(1)
p2 = PolyTreeNode.new(2)
p3 = PolyTreeNode.new(3)
p4 = PolyTreeNode.new(4)
p5 = PolyTreeNode.new(5)

p2.parent = p1
p3.parent = p1
p4.parent = p2
p5.parent = p2
# p p1.value
p p1.dfs(5)
