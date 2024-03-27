# https://leetcode.com/problems/concatenation-of-array/description/
# 1929. Concatenation of Array

defmodule Solution do
  @spec get_concatenation(nums :: [integer]) :: [integer]
  def get_concatenation(nums), do: nums ++ nums
end

[1,2,1] |> Solution.get_concatenation() |> IO.inspect()
# Output: [1,2,1,1,2,1]
[1,3,2,1] |> Solution.get_concatenation() |> IO.inspect()
# Output: [1,3,2,1,1,3,2,1]
