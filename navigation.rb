module Navigate
  def navigation
    current_node = root
    loop do
      puts '_________________________________________________________'
      puts 'Allowed commands:'
      puts '   1 - level up'
      puts '   2 - level down left'
      puts '   3 - level down right'
      puts '   4 - show current node'
      puts '   5 - stop navigation'
      puts '========================================================='

      command = gets.chomp
      unless (1..5).to_a.include? command.to_i
        puts "Wrong command - #{command}"
        next
      end

      case command.to_i
      when 1
        if current_node.root?
          puts 'Error: this is a root node, there is no parent node!'
        else
          current_node = current_node.parent
          show_node(current_node)
        end
      when 2
        if current_node.left?
          current_node = current_node.left
          show_node(current_node)
        else
          puts 'Error: there is no left child!'
        end
      when 3
        if current_node.right?
          current_node = current_node.right
          show_node(current_node)
        else
          puts 'Error: there is no right child!'
        end
      when 4
        show_node(current_node)
      when 5
        return
      end
    end
  end
end
