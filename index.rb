require_relative 'navigation'
require_relative 'node'
require_relative 'binary_tree'

@current_tree = BinaryTree.new(0)

loop do
  puts '___________________________________________________'
  puts 'Allowed commands:'
  puts '    1 - Create binary-tree'
  puts '    2 - Add new item'
  puts '    3 - Remove item ( its deletes all children if they exist! )'
  puts '    4 - Start navigation for binary-tree'
  puts '    5 - Exit'

  command = gets.chomp
  unless (1..5).to_a.include? command.to_i
    puts "Wrong command - #{command}"
    next
  end

  case command.to_i
  when 1
    puts 'To create binary-tree enter root value:'
    root = gets.chomp
    binary_tree = BinaryTree.new(root)
    @current_tree = binary_tree
    puts "Now your binary-tree look so: #{binary_tree.to_s}"
  when 2
    puts 'Enter item for add into binary-tree:'
    item = gets.chomp
    @current_tree.add(item)
    puts "Inserting #{item}......"
    puts "Now your binary-tree look so: #{@current_tree.to_s}"
  when 3
    puts 'Enter item to delete (also deletes children if they exist!):'
    r_item = gets.chomp
    @current_tree.remove_node_with_children(r_item)
    puts "Now your binary-tree look so: #{@current_tree.to_s}"
  when 4
    @current_tree.navigation
  when 5
    puts 'Good Bye!'
    return
  end
end
