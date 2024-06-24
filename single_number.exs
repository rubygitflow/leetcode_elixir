# https://leetcode.com/problems/single-number/
# 136. Single Number

#######################
# https://leetcode.com/problems/single-number-ii/description/
# 137. Single Number II


defmodule Solution do
  @spec single_number(nums :: [integer]) :: integer
  def single_number(nums) do
    Enum.reduce(nums, &Bitwise.bxor/2)
  end

  @spec single_number_ii(nums :: [integer]) :: integer
  def single_number_ii(nums) do
    try do
      hd(for {a, b} <- Enum.frequencies(nums), b == 1, do: a)
    rescue
      _ -> 0
    end
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

IO.inspect("Single Number II")
IO.inspect(Solution.single_number_ii([2,2,3,2]))
# Output: 3
IO.inspect(Solution.single_number_ii([0,1,0,1,0,1,99]))
# Output: 99
IO.inspect(Solution.single_number_ii([0,1,0,1,0,1]))
# Output: 0
