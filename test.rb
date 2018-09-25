# Node

class Node
  attr_accessor :value, :left, :right

  def initialize(value, left, right)
	  @value = value
	  @left = left
	  @right = right
  end
end

#Binary Search Tree

class BinarySearchTree
	attr_accessor :root_node

	def initialize(value)
    puts "Initializing with: " + value.to_s
		@root_node = Node.new(value, nil, nil)
  end

  def insert(value)
    puts "Inserting :" + value.to_s
    current_node = @root_node
    while nil != current_node
      if (value < current_node.value) && (current_node.left == nil)
        current_node.left = Node.new(value,nil,nil)
      elsif  (value > current_node.value) && (current_node.right == nil)
        current_node.right = Node.new(value,nil,nil)
      elsif (value < current_node.value)
        current_node = current_node.left
      elsif (value > current_node.value)
        current_node = current_node.right
      else
        return
      end
    end
  end

  def search(value)
    node = @root_node
    while(true)
      return nil if node == nil
      yield node if block_given?
      return node if value == node.value
      if value < node.value
        node = node.left
      else
        node = node.right
      end
    end
  end
end

array = [12, 85, 69, 85, 2, 25, 35]
bst = BinarySearchTree.new(10)
array.each { |elem| bst.insert(elem) }
# p bst.root_node

# p bst.root_node
p bst.search(11)








