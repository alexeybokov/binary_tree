require_relative 'navigation'
require_relative 'node'
require_relative 'binary_tree'

@current_tree = BinaryTree.new(0)

loop do
  puts '___________________________________________________'
  puts 'Allowed commands:'
  puts '    1 - Create binary-tree'
  puts '    2 - Add new item'
  puts '    3 - Remove item ( its delete all child of item )'
  puts '    4 - Start navigation for binary-tree'
  puts '    5 - Exit'

  command = gets.chomp
  unless (1..5).to_a.include? command.to_i
    puts "Wrong command - #{command}"
    next
  end

  case command.to_i
  when 1
    puts 'For create binary-tree puts first item(root):'
    root = gets.chomp
    binary_tree = BinaryTree.new(root)
    @current_tree = binary_tree
    puts "Now your binary-tree: #{binary_tree.to_s}"
  when 2
    puts 'Enter item for add to binary-tree:'
    item = gets.chomp
    @current_tree.add(item)
    puts "Inserting #{item}......"
    puts "Now your binary-tree: #{@current_tree.to_s}"
  when 3
    puts 'Enter item for delete (also delete items children if they are):'
    r_item = gets.chomp
    @current_tree.remove_node_with_children(r_item)
    puts "Now your binary-tree: #{@current_tree.to_s}"
  when 4
    @current_tree.navigation
  when 5
    puts ' Good Bye!'
    return
  end
end
