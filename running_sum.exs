# https://leetcode.com/problems/running-sum-of-1d-array/description/
# 1480. Running Sum of 1d Array

defmodule Solution do
  @spec running_sum([integer]) :: [integer]
  def running_sum(nums, prev \\ 0, out \\ [])
  def running_sum([head | tail], prev, out) do
    running_sum(tail, head + prev, out ++ [head + prev])
  end
  def running_sum([] ,_ , out), do: out

  @spec running_sum_ex([integer]) :: [integer]
  def running_sum_ex(nums) do
    nums
    |> tl()
    |> Enum.reduce([hd(nums)], fn n, [prev_sum | _] = sums ->
      [prev_sum + n | sums]
    end)
    |> Enum.reverse()
  end
end

[1,2,3,4] |> Solution.running_sum() |> IO.inspect()
# Output: [1,3,6,10]
[1,1,1,1,1] |> Solution.running_sum() |> IO.inspect()
# Output: [1,2,3,4,5]
[3,1,2,10,1] |> Solution.running_sum() |> IO.inspect()
# Output: [3,4,6,16,17]

[1,2,3,4] |> Solution.running_sum_ex() |> IO.inspect()
# Output: [1,3,6,10]
[1,1,1,1,1] |> Solution.running_sum_ex() |> IO.inspect()
# Output: [1,2,3,4,5]
[3,1,2,10,1] |> Solution.running_sum_ex() |> IO.inspect()
# Output: [3,4,6,16,17]
