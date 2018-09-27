require_relative 'navigation'
require_relative 'node'
require_relative 'binary_tree'

tree = BinaryTree.new(50)
tree.add(100)
tree.add(30)
tree.add(40)
tree.add(60)
tree.add(88)
tree.add(10)
tree.add(55)
tree.add(5)
puts "Tree nodes: #{tree.to_s}"
tree.navigation
tree.remove_node_with_children(60)
puts "Tree nodes: #{tree.to_s}"
tree.remove_node_with_children(30)
puts "Tree nodes: #{tree.to_s}"

