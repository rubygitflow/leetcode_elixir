# https://leetcode.com/problems/single-number/
# 136. Single Number

defmodule Solution do
  @spec single_number(nums :: [integer]) :: integer
  def single_number(nums) do
    Enum.reduce(nums, &Bitwise.bxor/2)
  end
end


IO.inspect("Single Number")
IO.inspect(Solution.single_number([2,2,1,1,1]))
# Output: 1
IO.inspect(Solution.single_number([2,2,1]))
# Output: 1
IO.inspect(Solution.single_number([4,1,2,1,2]))
# Output: 4
IO.inspect(Solution.single_number([1]))
# Output: 1
