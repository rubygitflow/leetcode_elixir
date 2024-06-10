# https://leetcode.com/problems/find-triangular-sum-of-an-array/description/
# 2221. Find Triangular Sum of an Array

defmodule Solution do
  @spec triangular_sum(nums :: [integer]) :: integer
  def triangular_sum([res]), do: res
  def triangular_sum(nums) do
    triangular_sum(triangle_round(nums))
  end

  defp triangle_round(list) do
    list 
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn [n1, n2] -> 
      rem(n1 + n2, 10)
    end)
  end
end

IO.inspect(Solution.triangular_sum([1,2,3,4,5]))
# Output: 8
IO.inspect(Solution.triangular_sum([5]))
# Output: 5

