# https://leetcode.com/problems/count-number-of-special-subsequences/
# 1955. Count Number of Special Subsequences
# Explanation: https://algo.monster/liteproblems/1955

defmodule Solution do
  @mod 10**9 + 7

  @spec count_special_subsequences(nums :: [integer]) :: integer
  def count_special_subsequences(nums) do
    nums
    |> Enum.reduce({0,0,0}, fn n, {total_zeros, total_ones, total_twos} ->
      {
        if(n == 0, do: Integer.mod(1 + 2*total_zeros, @mod), else: total_zeros),
        if(n == 1, do: Integer.mod(total_zeros + 2*total_ones, @mod), else: total_ones),
        if(n == 2, do: Integer.mod(total_ones + 2*total_twos, @mod), else: total_twos)
      }
    end)
    |> elem(2)
  end
end

IO.inspect(Solution.count_special_subsequences([0,1,2]))
# Output: 1
IO.inspect(Solution.count_special_subsequences([0,1,2,0]))
# Output: 1
IO.inspect(Solution.count_special_subsequences([0,1,2,2]))
# Output: 3
IO.inspect(Solution.count_special_subsequences([2,2,0,0]))
# Output: 0
IO.inspect(Solution.count_special_subsequences([0,1,2,0,1,2]))
# Output: 7
