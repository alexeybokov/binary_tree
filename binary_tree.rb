class Node
  attr_accessor :value, :left, :right, :errors, :parent_from_left, :parent_from_right, :klass

  def initialize(value, klass)
    @value = value
    @left = nil
    @right = nil
    @parent_from_left = nil
    @parent_from_right = nil
    @errors = []
    @klass = klass
  end

  ALLOWED_CLASSES = [String, Integer].freeze

  def validate
    @errors << "Value can't be vlank" if value.nil? || value == ''
    @errors << "Value has wrong type - #{value.class}" unless ALLOWED_CLASSES.include?(value.class)
    @errors << "Value has wrong type - #{klass} expected" unless value.class == klass
    @errors.empty?
  end
  alias valid? validate

  def errors_to_string
    errors.join('; ')
  end

  def parent
    parent_from_right || parent_from_left
  end

  def root?
    @parent_from_left.nil? && @parent_from_right.nil?
  end

  def children?
    !@left.nil? && !@right.nil?
  end

  def left?
    !@left.nil?
  end

  def right?
    !@right.nil?
  end

  def one_child?
    !children? && (left_child? || right_child?)
  end
end

class BinaryTree

  attr_accessor :root, :klass

  def initialize(first_value)
    node = Node.new(first_value, first_value.class)
    if node.valid?
      @klass ||= first_value.class
      @root = node
    else
      fail node.errors_to_string
    end
  end

  def add(new_value)
    new_node = Node.new(new_value, klass)
    if new_node.valid?
      parent = find_parent_for(root, new_value)
      if new_value >= parent.value
        new_node.parent_from_right = parent
        parent.right = new_node
      else
        new_node.parent_from_left = parent
        parent.left = new_node
      end
    else
      fail new_node.errors_to_string
    end
  end

  def find_parent_for(current, new_value)
    if new_value >= current.value
      return current unless current.right?
      find_parent_for(current.right, new_value)
    else
      return current unless current.left?
      find_parent_for(current.left, new_value)
    end
  end

  def remove_node_with_children(value, current_node = nil)
    current_node = find_by_value(root, value)
    if current_node.parent_from_left
      current_node.parent_from_left.left = nil
    elsif
    current_node.parent_from_right.right = nil
    end
  end

  def find_by_value(node, value)
    return node if value == node.value
    if value < node.value
      find_by_value(node.left, value)
    else
      find_by_value(node.right, value)
    end
  end

  def walk
    node = @root
    stack = []
    ignore_left = false

    loop do
      if ignore_left
        ignore_left = false
      elsif node.left?
        stack.push(node)
        node = node.left
        next
      end

      yield node

      if node.right?
        node = node.right
        next
      end
      break if stack.length.zero?

      node = stack.pop
      ignore_left = true
    end
  end

  def to_s
    a = []
    walk { |n| a << n.value.to_s }
    a.join(', ')
  end

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

  def show_node(current_node)
    puts 'Current node details:'
    puts "Value: #{current_node.value}"
    if current_node.children?
      puts 'Has both children'
    elsif current_node.left?
      puts 'Has left child'
    elsif current_node.right?
      puts 'Has right child'
    else
      puts "Doesn't have children"
    end
    puts "Tree nodes: #{self.to_s}"
  end
end

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

