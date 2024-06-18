# https://leetcode.com/problems/jump-game/description/
# 55. Jump Game

defmodule Solution do
  @spec can_jump(nums :: [integer]) :: boolean
  def can_jump(nums) do
    do_can_jump?(0, length(nums) - 1, nums)
  end

  defp do_can_jump?(as_far_as_possible, dist, _) when as_far_as_possible >= dist, do: true
  defp do_can_jump?(as_far_as_possible, _, _) when as_far_as_possible < 0, do: false
  defp do_can_jump?(as_far_as_possible, dist, [head | tail]) do
    # bringing the right border closer to the left edge
    do_can_jump?(max(as_far_as_possible, head) - 1, dist - 1, tail)
  end
end

IO.inspect("Jump Game")
IO.inspect(Solution.can_jump([2,3,1,1,4]))
# Output: true
IO.inspect(Solution.can_jump([3,2,1,0,4]))
# Output: false
