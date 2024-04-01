# https://leetcode.com/problems/minimum-time-to-make-rope-colorful/description/
# 1578. Minimum Time to Make Rope Colorful

defmodule Solution do
  @spec min_cost(colors :: String.t, needed_time :: [integer]) :: integer
  def min_cost(colors, needed_time) do
    color_graph = colors |> String.graphemes()
    min_cost(color_graph, needed_time, -1)
  end

  defp min_cost(color_graph, needed_time, accumulator) when length(color_graph) != length(needed_time),
    do: accumulator
  defp min_cost(color_graph, needed_time, _accumulator) do
    Enum.zip(color_graph, needed_time)
    |> traverse(0)
  end

  defp traverse([], accumulator), do: accumulator
  defp traverse([{char, time_a} | [{char, time_b} | tail]], accumulator) when time_a > time_b,
    do: traverse([{char, time_a} | tail], accumulator + time_b)
  defp traverse([{char, time_a} | [{char, time_b} | tail]], accumulator) when time_a <= time_b,
    do: traverse([{char, time_b} | tail], accumulator + time_a)
  defp traverse([_ | tail], accumulator), do: traverse(tail, accumulator)
end

"abaacs" |> Solution.min_cost([1,2,3,4,5]) |> IO.inspect()
# Output: -1
"abaac" |> Solution.min_cost([1,2,3,4,5]) |> IO.inspect()
# Output: 3
"abc" |> Solution.min_cost([1,2,3]) |> IO.inspect()
# Output: 0
"aabaa" |> Solution.min_cost([1,2,3,4,1]) |> IO.inspect()
# Output: 2
"abaaac" |> Solution.min_cost([1,2,3,4,1,5]) |> IO.inspect()
# Output: 4
