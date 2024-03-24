# https://leetcode.com/problems/two-sum/description/
# 1. Two Sum

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
end

[2,7,11,15] |> Solution.two_sum(9) |> IO.inspect()
# Output: [0,1]
[3,2,4] |> Solution.two_sum(6) |> IO.inspect()
# Output: [1,2]
[3,3] |> Solution.two_sum(6) |> IO.inspect()
# Output: [0,1]
[3,3] |> Solution.two_sum(5) |> IO.inspect()
# Output: []
