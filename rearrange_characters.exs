# https://leetcode.com/problems/rearrange-characters-to-make-target-string/description/
# 2287. Rearrange Characters to Make Target String

defmodule Solution do
  @spec rearrange_characters(s :: String.t, target :: String.t) :: integer
  def rearrange_characters(s, target) do
    sc = count_chars(s)
    tc = count_chars(target)

    Enum.map(tc, fn {k, v} ->
      div(Map.get(sc, k, 0), v)
    end)
    |> Enum.min()
  end

  defp increment(count) do
    count + 1
  end
  defp to_count_map(char, map) do
    map
    |> Map.update(char, 1, &increment/1)
  end
  def count_chars(text) do
    text
    |> String.graphemes
    |> Enum.reduce(%{}, &to_count_map/2)
  end
end

IO.inspect(Solution.rearrange_characters("ilovecodingonleetcode","code"))
# Output: 2
IO.inspect(Solution.rearrange_characters("abcba","abc"))
# Output: 1
IO.inspect(Solution.rearrange_characters("abbaccaddaeea","aaaaa"))
# Output: 1
IO.inspect(Solution.rearrange_characters("abbaccaddaeea","фd"))
# Output: 0
