# https://leetcode.com/problems/two-sum/description/
# 1. Two Sum

#######################
# https://leetcode.com/problems/two-sum-ii-input-array-is-sorted/description/
# 167. Two Sum II - Input Array Is Sorted

defmodule Solution do
  @spec two_sum(nums :: [integer], target :: integer) :: [integer]
  def two_sum(nums, target) do
    find_two_sum(nums, target)
  end

  def find_two_sum(nums, target, position \\ 0, seen \\ %{})
  def find_two_sum(nums, _target, _position, _seen) when length(nums) < 1, do: []
  def find_two_sum([head|tail], target, position, seen) do
    if Map.has_key?(seen, target-head) do
      [Map.get(seen, target-head), position]
    else
      find_two_sum(tail, target, position+1, Map.put_new(seen, head, position))
    end
  end

  @spec two_sum_sorted(numbers :: [integer], target :: integer) :: [integer]
  def two_sum_sorted(numbers, target) do
    [head | tail] = numbers
    fetch_two_sum_sorted(head, 0, tail, target)
  end
  def fetch_two_sum_sorted(_value, _position, nums, _target) when length(nums) < 1, do: []
  def fetch_two_sum_sorted(value, position, nums, target) do
    res = target - value
    {out_r, out_v} = Enum.reduce_while(nums, {0, '*'}, fn num, acc ->
      {pos, val} = acc
      if num == res do
        {:halt, {pos+1, num}}
      else
        if num < res do
          {:cont, {pos+1, val}}
        else
          {:halt, {0, val}}
        end
      end
    end)
    if out_v == '*'  do
      [head | tail] = nums
      fetch_two_sum_sorted(head, position+1, tail, target)
    else
      [position+1, out_r + position + 1]
    end
  end
end

IO.puts('Two Sum')
[2,7,11,15] |> Solution.two_sum(9) |> IO.inspect()
# Output: [0,1]
[3,2,4] |> Solution.two_sum(6) |> IO.inspect()
# Output: [1,2]
[3,3] |> Solution.two_sum(6) |> IO.inspect()
# Output: [0,1]
[3,3] |> Solution.two_sum(5) |> IO.inspect()
# Output: []

IO.puts('Two Sum II - Input Array Is Sorted')
[2,7,11,15] |> Solution.two_sum_sorted(9) |> IO.inspect()
# Output: [1,2]
[2,3,4] |> Solution.two_sum_sorted(6) |> IO.inspect()
# Output: [1,3]
[-1,0] |> Solution.two_sum_sorted(-1) |> IO.inspect()
# Output: [1,2]
[3,3] |> Solution.two_sum_sorted(5) |> IO.inspect()
# Output: []
[2,7,11,15,15,16,17,18,19,20,21,22,23,24,25] |> Solution.two_sum_sorted(46) |> IO.inspect()
# Output: [11,15]
