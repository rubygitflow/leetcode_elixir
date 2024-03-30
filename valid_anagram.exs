# https://leetcode.com/problems/valid-anagram/description/
# 242. Valid Anagram

####################
# https://leetcode.com/problems/group-anagrams/description/
# 49. Group Anagrams

defmodule Solution do
  # Valid Anagram
  @spec is_anagram?(s :: String.t, t :: String.t) :: boolean
  # https://elixirschool.com/en/lessons/basics/strings#anagrams-9
  def is_anagram?(s, t) when is_binary(s) and is_binary(t) do
    sort_string(s) == sort_string(t)
  end

  defp sort_string(string) do
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

  defp do_map(s) do
    for key <- to_charlist(s), reduce: %{} do
      acc -> Map.update(acc, key, 1, &(&1 + 1))
    end
  end

  # Group Anagrams
  @spec group_anagrams(strs :: [String.t]) :: [[String.t]]
  def group_anagrams(strs) do
    strs
    |> Enum.group_by(&sort_letters(&1))
    |> Map.values()
  end

  defp sort_letters(word), do: word |> String.graphemes() |> Enum.sort()

  @spec group_anagrams_ex(strs :: [String.t]) :: [[String.t]]
  def group_anagrams_ex(strs) do
    strs
    |> Stream.map(&{&1 |> String.to_charlist() |> Enum.frequencies(), &1})
    |> Enum.group_by(&elem(&1, 0), &elem(&1, 1))
    |> Map.values()
  end
end

IO.inspect("Valid Anagram")
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

IO.inspect("Group Anagrams")
["eat","tea","tan","ate","nat","bat"] |> Solution.group_anagrams() |> IO.inspect()
# Output: [["bat"],["nat","tan"],["ate","eat","tea"]]
[""] |> Solution.group_anagrams() |> IO.inspect()
# Output: [[""]]
["a"] |> Solution.group_anagrams() |> IO.inspect()
# Output: [["a"]]

["eat","tea","tan","ate","nat","bat"] |> Solution.group_anagrams_ex() |> IO.inspect()
# Output: [["bat"],["nat","tan"],["ate","eat","tea"]]
[""] |> Solution.group_anagrams_ex() |> IO.inspect()
# Output: [[""]]
["a"] |> Solution.group_anagrams_ex() |> IO.inspect()
# Output: [["a"]]
