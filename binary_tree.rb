class BinaryTree
  include Navigate

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
end
