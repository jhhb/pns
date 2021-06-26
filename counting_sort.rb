#!/usr/bin/env ruby

require 'benchmark'


# TODO: JB - handle duplicates you numbskull.
# # TODO: JB handle negative numbers.
# TODO: finally, see if there is a way to do this where you may use *more* arrays, but can guarantee those arrays will have 0 holes in them.

<<-ORG
The v1 of this counting sort works, but suffers from the following:
- no use of min value to constrain array length
- no use of max value to constrain array length

Both of the above result in producing an array with holes, that then requires
filtering.

A better version requires a way to:
- appropriately size the array to exactly what is required (this is easy)
- a way to easily compute or lookup the position of an element for the new array (less easy)
ORG

def v1(input)
  max = input.max
  array_size = max + 1

  empty = Array.new(array_size).fill(0)
  input.each do |value|
    empty[value] += 1
  end

  unfiltered = empty.each_with_index.map do |each, index|
    each == 0 ? nil : index
  end
  .select{|index| index != nil}
end

<<-ORG
OK, this version is better, but can we do the filtering in place somehow?
  - I dont think this even matters for runtime unless we can appropriately size
  the array in the first place, because we will still have to copy the array just to
  return the correct result.
ORG

def v2(input)
  max = input.max
  array_size = max + 1

  empty = Array.new(array_size).fill(0)
  input.each do |value|
    empty[value] += 1
  end

  final_arr = Array.new(input.length)
  idx_in_final = 0
  empty.each_with_index do |each, index|
    if each > 0
      final_arr[idx_in_final] = index
      idx_in_final += 1
    end
  end

  final_arr
end

def test_v1
  input = [10, 8, 7, 1, 5, 4, 2, 3, 15]
  v1(input)
end

def test_v2
  input = [10, 8, 7, 1, 5, 4, 2, 3, 15]
  v2(input)
end

test_v1
test_v2

Benchmark.bmbm do |x|
  x.report("v1") { test_v1 }
  x.report("v2") { test_v2 }
end