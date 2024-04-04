# https://leetcode.com/problems/maximum-number-of-balloons/
# 1189. Maximum Number of Balloons

defmodule Solution do
  @spec max_number_of_balloons(text :: String.t) :: integer
  @chars [?b, ?a, ?l, ?o, ?n]

  @spec max_number_of_balloons(text :: String.t) :: integer
  def max_number_of_balloons(text) do
    text_char_count = get_char_count(text, Map.new(@chars, &{&1, 0}))
    per_word_count = %{?b => 1, ?a => 1, ?l => 2, ?o => 2, ?n => 1}
    do_max_number_of_balloons(@chars, text_char_count, per_word_count, nil)
  end

  defp get_char_count(<<f, rest::bytes>>, map) do
    map = if f in @chars, do: Map.update(map, f, 1, &(&1 + 1)), else: map
    get_char_count(rest, map)
  end
  defp get_char_count(<<>>, map), do: map

  defp do_max_number_of_balloons([ch | tl], total_count, per_word_count, max_count) do
    count = div(total_count[ch], per_word_count[ch])
    do_max_number_of_balloons(tl, total_count, per_word_count, min(count, max_count))
  end
  defp do_max_number_of_balloons([], _, _, max_count), do: max_count
end

"nlaebolko" |> Solution.max_number_of_balloons() |> IO.inspect()
# Output: 1
"loonbalxballpoon" |> Solution.max_number_of_balloons() |> IO.inspect()
# Output: 2
"leetcode" |> Solution.max_number_of_balloons() |> IO.inspect()
# Output: 0
