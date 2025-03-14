require_relative 'node'
require 'pry-byebug'
class LinkedList
  def initialize(value = nil)
    @head_node = Node.new(value)
  end

  def append(value)
    new_node = Node.new(value)
    appended = false
    current_node = @head_node
    while appended == false
      if current_node.next_node.nil?
        current_node.next_node = new_node
        @head_node = new_node if @head_node.value.nil?
        appended = true
      else
        current_node = current_node.next_node
      end
    end
  end

  def prepend(value)
    new_node = Node.new(value, @head_node)
    if @head_node.value.nil?
      @head_node.value = value
    else
      @head_node = new_node
    end
  end

  def size
    size = 1
    current_node = @head_node
    until current_node.next_node.nil?
      size += 1
      current_node = current_node.next_node
    end
    size
  end

  def head
    @head_node
  end

  def tail
    current_node = @head_node
    current_node = current_node.next_node until current_node.next_node.nil?
    current_node
  end

  def at(index)
    node_index = 0
    current_node = @head_node
    node_found = false
    while node_found == false
      if node_index == index
        node_found = true
      elsif current_node.nil?
        break
      else
        node_index += 1
        current_node = current_node.next_node
      end
    end
    return "Linked list doesn't have this index" if node_found == false

    current_node
  end

  def pop
    popped = false
    current_node = @head_node
    while popped == false
      if current_node.next_node.next_node.nil?
        current_node.next_node = nil
        popped = true
      else
        current_node = current_node.next_node
      end
    end
  end

  def contains?(value)
    value_found = false
    current_node = @head_node
    until current_node.nil? || value_found
      if current_node.value == value
        value_found = true
      else
        current_node = current_node.next_node
      end
    end
    value_found
  end

  def find(value)
    node_index = 0
    value_found = false
    current_node = @head_node
    until current_node.nil? || value_found == true
      if current_node.value == value
        value_found = true
      else
        current_node = current_node.next_node
        node_index += 1
      end
    end
    return nil if value_found == false

    node_index
  end

  def to_s
    linked_list_string = ''
    current_node = @head_node
    return 'nil' if @head_node.nil?

    until current_node.nil?
      linked_list_string << "( #{current_node.value} ) -> "
      linked_list_string << 'nil' if current_node.next_node.nil?
      current_node = current_node.next_node
    end
    linked_list_string
  end

  def insert_at(value, index)
    # this works with negative and too high indexes, being simply appended
    node_at_index = at(index)
    node_at_prev_index = at(index - 1)
    new_node = Node.new(value)
    new_node.next_node = node_at_index

    # if the user's input is equal to the first or after the last index
    append(value) if node_at_index.is_a? String
    prepend(value) if index.zero?

    node_at_prev_index.next_node = new_node unless node_at_prev_index.is_a? String
  end

  def remove_at(index)
    selected_node = at(index)
    node_at_prev_index = at(index - 1)
    @head_node = selected_node.next_node if index.zero?
    node_at_prev_index.next_node = selected_node.next_node unless node_at_prev_index.is_a? String
  end
end
