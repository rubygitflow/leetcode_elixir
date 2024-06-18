# https://leetcode.com/problems/jump-game/description/
# 55. Jump Game

########################
# https://leetcode.com/problems/jump-game-vii/
# 1871. Jump Game VII


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

  @spec can_reach(s :: String.t, min_jump :: integer, max_jump :: integer) :: boolean
  def can_reach(s, min_jump, max_jump) do
    do_can_reach(0, s, min_jump, max_jump)
  end

  defp do_can_reach(i, s, min_jump, max_jump) do
    if String.length(s) == i+1 do
      true
    else
      do_iter(i, s, min_jump, max_jump)
    end
  end

  defp do_iter(i, s, min_jump, max_jump) do
    Enum.reduce_while( min_jump..max_jump, false, fn step, _  ->
      with true <- String.at(s, i + step) == "0",
           true <- do_can_reach(i + step, s, min_jump, max_jump) do
        {:halt, true}
      else
        _ ->
          {:cont, false}
      end
    end)
  end
end

IO.inspect("Jump Game")
IO.inspect(Solution.can_jump([2,3,1,1,4]))
# Output: true
IO.inspect(Solution.can_jump([3,2,1,0,4]))
# Output: false


IO.inspect("Jump Game VII")
IO.inspect(Solution.can_reach("011010", 2, 3))
# Output: true
IO.inspect(Solution.can_reach("01101110", 2, 3))
# Output: false
