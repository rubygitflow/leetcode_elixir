# https://leetcode.com/problems/minimum-time-to-type-word-using-special-typewriter/description/
# 1974. Minimum Time to Type Word Using Special Typewriter

defmodule Solution1974 do
  @spec min_time_to_type(word :: String.t) :: integer
  def min_time_to_type(word) do
    do_min_time_to_type(word, byte_size(word), ?a)
  end

  defp do_min_time_to_type(<<ch, rest::bytes>>, seconds, start_ch) do
    do_min_time_to_type(rest, seconds + move_pointer(start_ch, ch), ch)
  end
  defp do_min_time_to_type(_, seconds, _), do: seconds

  defp move_pointer(start_ch, ch) do
    distance = abs(start_ch - ch) 
    min(distance, 26 - distance)
  end
end

IO.inspect(Solution1974.min_time_to_type("abc"))
# Output: 5
IO.inspect(Solution1974.min_time_to_type("bza"))
# Output: 7
IO.inspect(Solution1974.min_time_to_type("zjpc"))
# Output: 34
