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

  @spec anagram(s :: String.t, t :: String.t) :: boolean
  def anagram(s, t), do: to_charlist(s) |> Enum.sort == to_charlist(t) |> Enum.sort

  @spec is_anagram(s :: String.t, t :: String.t) :: boolean
  def is_anagram(s, t), do: to_charlist(s) |> Enum.frequencies == to_charlist(t) |> Enum.frequencies

  @spec anagram?(s :: String.t, t :: String.t) :: boolean
  def anagram?(s, t), do: do_map(s) == do_map(t)

  def do_map(s) do
    for key <- to_charlist(s), reduce: %{} do
      acc -> Map.update(acc, key, 1, &(&1 + 1))
    end
  end
end

"ana👩ram" |> Solution.is_anagram?("na👩aram") |> IO.inspect()
# Output: true
"anagram" |> Solution.is_anagram?("nagaram") |> IO.inspect()
# Output: true
"anagram" |> Solution.is_anagram?("nagram") |> IO.inspect()
# Output: false
"rat" |> Solution.is_anagram?("car") |> IO.inspect()
# Output: false

"ana👩ram" |> Solution.is_anagram?("na👩aram") |> IO.inspect()
# Output: true
"anagram" |> Solution.anagram("nagaram") |> IO.inspect()
# Output: true
"anagram" |> Solution.anagram("nagram") |> IO.inspect()
# Output: false
"rat" |> Solution.anagram("car") |> IO.inspect()
# Output: false

"ana👩ram" |> Solution.is_anagram?("na👩aram") |> IO.inspect()
# Output: true
"anagram" |> Solution.is_anagram("nagaram") |> IO.inspect()
# Output: true
"anagram" |> Solution.is_anagram("nagram") |> IO.inspect()
# Output: false
"rat" |> Solution.is_anagram("car") |> IO.inspect()
# Output: false

"ana👩ram" |> Solution.is_anagram?("na👩aram") |> IO.inspect()
# Output: true
"anagram" |> Solution.anagram?("nagaram") |> IO.inspect()
# Output: true
"anagram" |> Solution.anagram?("nagram") |> IO.inspect()
# Output: false
"rat" |> Solution.anagram?("car") |> IO.inspect()
# Output: false
