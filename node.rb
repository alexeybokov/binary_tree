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
    @errors << "Value can't be blank" if value.nil? || value == ''
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
