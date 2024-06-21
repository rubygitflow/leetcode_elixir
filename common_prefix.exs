# https://leetcode.com/problems/longest-common-prefix/description/
# 14. Longest Common Prefix

defmodule Solution do
  @spec longest_common_prefix(strs :: [String.t]) :: String.t
  def longest_common_prefix(strs) when length(strs) < 2, do: ""
  def longest_common_prefix(strs) do
    strs
    |> Enum.map(&String.to_charlist/1)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.uniq/1)
    # |> Enum.take_while(&match?([_], &1)) # Array of chars has only one character
    |> Enum.filter(&match?([_], &1)) # Array of chars has only one character
    |> IO.iodata_to_binary()
  end

  @spec longest_common_prefix_ii(strs :: [String.t()]) :: String.t()
  def longest_common_prefix_ii(strs) when length(strs) < 2, do: ""
  def longest_common_prefix_ii(strs) do
    Enum.reduce(strs, &take_while_eq/2)
  end

  defp take_while_eq(str1, str2, acc \\ "")
  defp take_while_eq(<<l1::binary-size(1), rest1::bitstring>>,
                     <<l2::binary-size(1), rest2::bitstring>>,
                     acc) when l1 == l2 do
    take_while_eq(rest1, rest2, acc <> l1)
  end
  defp take_while_eq(_,_, acc), do: acc

  @spec longest_common_prefix_at_least_one(arr1 :: [integer], arr2 :: [integer]) :: integer
  def longest_common_prefix_at_least_one(arr1, arr2) do
    acc = Enum.reduce(arr1, MapSet.new(), fn x, acc ->
      x
      |> Integer.digits()
      |> Enum.scan(&(&1 + &2*10))
      |> Enum.reduce(acc, fn x, acc -> MapSet.put(acc, x) end)
    end)
    Enum.reduce(arr2, 0, fn x, out -> while(acc, x, out) end)
  end

  defp while(acc, x, out) when x > 0 do
    cond do
      x <= 10 ** out ->
        out
      MapSet.member?(acc, x) ->
        Enum.max([out, String.length(Integer.to_string(x))])
      true ->
        while(acc, Integer.floor_div(x, 10), out)
    end
  end
  defp while(_, _, out), do: out
end


IO.inspect("Longest Common Prefix")
IO.inspect(Solution.longest_common_prefix(["flower","flow","flight"]))
# Output: "fl"
IO.inspect(Solution.longest_common_prefix(["dog","racecar","car"]))
# Output: ""
IO.inspect(Solution.longest_common_prefix(["flow","flow","flow"]))
# Output: "flow"
IO.inspect(Solution.longest_common_prefix(["dog"]))
# Output: ""

IO.inspect(Solution.longest_common_prefix_ii(["flower","flow","flight"]))
# Output: "fl"
IO.inspect(Solution.longest_common_prefix_ii(["dog","racecar","car"]))
# Output: ""
IO.inspect(Solution.longest_common_prefix_ii(["flow","flow","flow"]))
# Output: "flow"
IO.inspect(Solution.longest_common_prefix_ii(["dog"]))
# Output: ""

IO.inspect("Find the Length of the Longest Common Prefix")
IO.inspect(Solution.longest_common_prefix_at_least_one([1, 10, 100], [1000, 1]))
# Output: 3
IO.inspect(Solution.longest_common_prefix_at_least_one([1,2,3], [4,4,4]))
# Output: 0
IO.inspect(Solution.longest_common_prefix_at_least_one([1,2,3], []))
# Output: 0
