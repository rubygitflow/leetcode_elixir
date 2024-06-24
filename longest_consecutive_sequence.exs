# https://leetcode.com/problems/longest-consecutive-sequence/description/
# 128. Longest Consecutive Sequence

defmodule Solution do
  @spec longest_consecutive(nums :: [integer]) :: integer
  def longest_consecutive(nums) do
    do_longest_consecutive(nums, MapSet.new(nums), 0)
  end

  defp do_longest_consecutive([], _srt, max_arr), do: max_arr
  defp do_longest_consecutive([h | t], srt, max_arr) do
    new_max_arr = if !MapSet.member?(srt, h - 1) do
      max(max_arr, calc_length_while(srt, h, 1))
    else
      max_arr
    end
    do_longest_consecutive(t, srt, new_max_arr)
  end
  defp calc_length_while(srt, x, length) do
    if MapSet.member?(srt, x + length) do
      calc_length_while(srt, x, length+1)
    else
      length
    end
  end
end

IO.inspect(Solution.longest_consecutive([100,4,200,1,3,2]))
# Output: 4
IO.inspect(Solution.longest_consecutive([0,3,7,2,5,8,4,6,0,1]))
# Output: 9
IO.inspect(Solution.longest_consecutive([0,3,17,12,5,8,14,26,0,21]))
# Output: 1
