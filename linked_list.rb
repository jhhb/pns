#!/usr/bin/env ruby
# Given the head of a linked list, delete an item with a given value from the list

class Node
  attr_reader :value
  attr_accessor :_next
  def initialize(value:, _next:)
    @_next = _next
    @value = value
  end

  # def inspect
  #   @value
  # end
  def to_s
    "{|#{value.to_s}|} --> "
  end
end

# [3, 2, 1] should give us a linked list like: 1 -> 2 -> 3 (since we insert at the head of the list)
def make_list(values)
  # make a linked list with each value, returning the head
  prev = Node.new(value: values.shift, _next: nil)
  values.each do |val|
    new_node = Node.new(value: val, _next: prev)
    prev = new_node
  end
  prev
end

def print_list(head)
  while head
    print head
    head = head._next
  end
end

# This is O(n), but it's using more space than necesary. Specifically:
# values.reverse copies our array
# #make_list creates n Node instances
# The solution is O(n) and T(3n), which is still just T(n)
def solution1(node, value)
  # make a copy of the list, but with our target value removed
  # what are some edge cases? List of size 0 or 1, element to remove occurs several times, element is at head, element is at tail
  values = []
  while node
    unless node.value == value
      values.push(node.value)
    end
    node = node._next
  end

  make_list(values.reverse)
end

def solution2(node, value)

end

# def solution2(node, value)
#   prev = node
#   curr = node
#
#   # while curr
#   #   if curr.value == value
#   #     if !prev
#   #
#   #     end
#   #     # This will not work when prev is nil
#   #     prev._next = curr._next._next
#   #   end
#   # end
# end


head = make_list([1,2,3])
print_list(head)
new_list = solution1(head, 1)
print_list(new_list)

