class Node
  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end

  def children?
    @left.nil? && @right.nil?
  end

  def left_child?
    !@left.nil?
  end

  def right_child?
    !@right.nil?
  end

  def one_child_only?
    return false if left_child? && right_child?

    left_child? == true || right_child? == true
  end
end

class BinaryTree

  attr_accessor :root

  def initialize(first_value = nil)
    if first_value.nil?
      @root = nil
    else
      @root = Node.new(first_value)
    end
  end

  def add(new_value)
    if @root.nil?
      @root = Node.new(new_value)
    end

    current = @root
    loop do
      if new_value >= current.value
        if current.right.nil?
          current.right = Node.new(new_value)
          break
        else
        current = current.right
        end
      else
        if current.left.nil?
          current.left = Node.new(new_value)
          break
        else
          current = current.left
        end
      end
    end
  end

  def remove_node_with_children(value, current_node = nil)
    current_node = search(value)
    parent = parent_node(value)
    parent.left = nil if parent.left && parent.left == ObjectSpace._id2ref(current_node.object_id)
    parent.right = nil if parent.right && parent.right == ObjectSpace._id2ref(current_node.object_id)
  end

  def parent_node(value, current_node = nil)
    return puts('Tree is empty') if @root.nil?

    current_node = @root if current_node.nil?
    if current_node.left && current_node.left.value == value
      return current_node
    elsif current_node.right && current_node.right.value == value
      return current_node
      elsif value < current_node.value
      parent_node(value, current_node.left)
    elsif value > current_node.value
      parent_node(value, current_node.right)
    end
  end

  def search(value)
    return nil if @root.nil?

    return search_at_node(@root, value)
  end

  def search_at_node(tree_node, value)
    return nil if tree_node.nil?

    return tree_node.value if value == tree_node.value

    return search_at_node(tree_node.left, value) if value < tree_node.value

    return search_at_node(tree_node.right, value)
  end

  def find_max_from_node(start_node)
    current = start_node
    until current.nil?
      break if current.right.nil?

      current = current.right
    end
    current
  end

  def find_min_from_node(start_node)
    current = start_node
    until current.nil?
      break if current.left.nil?

      current = current.left
    end
    current
  end

  def walk
    return nil if @root.nil?

    node = @root
    stack = []
    ignore_left = false

    loop do
      if ignore_left
        ignore_left = false
      else
        unless node.left.nil?
          stack << node
          node = node.left
          next
        end
      end

      yield node

      unless node.right.nil?
        node = node.right
        next
      end
      break if stack.length.zero?

      node = stack.pop
      ignore_left = true
    end
  end

  def to_s
    return '' if @root.nil?

    a = []
    walk { |n| a << n.value.to_s }
    a.join(', ')
  end
end

tree = BinaryTree.new(50)
tree.add(100)
tree.add(120)
puts "Tree nodes: #{tree.to_s}"
tree.remove_node_with_children(120)
puts "Tree nodes: #{tree.to_s}"

























#   def delete_node(node)
#     parent = find_parent_node(node)
#     is_left_node = node.value < parent.value
#     if node.children?
#       if is_left_node
#         parent.left = nil
#       else
#         parent.right = nil
#       end
#       return
#     end
#     if node.one_child_only?
#       if is_left_node
#         parent.left = node.left if node.left_children?
#         parent.left = node.right if node.right_children?
#       else
#         parent.right = node.left if node.left_children?
#         parent.right = node.right if node.right_children?
#       end
#       return
#     end
#     min_node_to_the_right = find_min_from_node(node.right)
#     min_value_to_the_right = min_node_to_the_right.value
#     delete_node(min_node_to_the_right)
#     node.value = min_value_to_the_right
#   end
#   def find_parent_node(node)
#     return nil if @root.object_id == node.object_id
#
#     current = @root
#     parent = nil
#     node_found = false
#
#     while current
#       if current.object_id == node.object_id
#         node_found = true
#         break
#       end
#
#       parent = current
#       if node.value > current.value
#         current = current.right
#       else
#         current.left
#       end
#     end
#
#     raise ArgumentError, "Node can't found." if node_found == false
#
#     parent
#   end
