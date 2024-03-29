# https://leetcode.com/problems/valid-anagram/description/
# 242. Valid Anagram

defmodule Solution do
  @spec is_anagram?(s :: String.t, t :: String.t) :: boolean
  # https://elixirschool.com/en/lessons/basics/strings#anagrams-9
  def is_anagram?(s, t) when is_binary(s) and is_binary(t) do
    sort_string(s) == sort_string(t)
  end

  def sort_string(string) do
    string
    |> String.downcase()
    |> String.graphemes()
    |> Enum.sort()
  end
end

"anagram" |> Solution.is_anagram?("nagaram") |> IO.inspect()
# Output: true
"anagram" |> Solution.is_anagram?("nagram") |> IO.inspect()
# Output: false
"rat" |> Solution.is_anagram?("car") |> IO.inspect()
# Output: false
