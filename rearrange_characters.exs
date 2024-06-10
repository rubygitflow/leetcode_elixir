# https://leetcode.com/problems/rearrange-characters-to-make-target-string/description/
# 2287. Rearrange Characters to Make Target String

defmodule Solution do
  @spec rearrange_characters(s :: String.t, target :: String.t) :: integer
  def rearrange_characters(s, target) do
    # sc = count_chars(s)
    # tc = count_chars(target)
    sc = s |> String.graphemes() |> Enum.frequencies()
    tc = target |> String.graphemes() |> Enum.frequencies()

    Enum.map(tc, fn {k, v} ->
      div(Map.get(sc, k, 0), v)
    end)
    |> Enum.min()
  end

  # defp increment(count) do
  #   count + 1
  # end
  # defp to_count_map(char, map) do
  #   map
  #   |> Map.update(char, 1, &increment/1)
  # end
  # def count_chars(text) do
  #   text
  #   |> String.graphemes
  #   |> Enum.reduce(%{}, &to_count_map/2)
  # end

  @spec sum_of_unique(nums :: [integer]) :: integer
  def sum_of_unique(nums) do
    nums
    |> Enum.frequencies()
    |> Enum.filter(fn {_number, count} -> count == 1 end)
    |> Enum.map(&elem(&1, 0))
    |> Enum.sum()
  end
end

IO.inspect("Rearrange Characters to Make Target String")
IO.inspect(Solution.rearrange_characters("ilovecodingonleetcode","code"))
# Output: 2
IO.inspect(Solution.rearrange_characters("abcba","abc"))
# Output: 1
IO.inspect(Solution.rearrange_characters("abbaccaddaeea","aaaaa"))
# Output: 1
IO.inspect(Solution.rearrange_characters("abbaccaddaeea","фd"))
# Output: 0

IO.inspect("Sum of Unique Elements")
IO.inspect(Solution.sum_of_unique([1,2,3,2]))
# Output: 4
IO.inspect(Solution.sum_of_unique([1,1,1,1,1]))
# Output: 0
IO.inspect(Solution.sum_of_unique([1,2,3,4,5]))
# Output: 15
