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
  defp take_while_eq(<<l1::binary-size(1), rest1::bitstring()>>,
                     <<l2::binary-size(1), rest2::bitstring()>>,
                     acc) when l1 == l2 do
    take_while_eq(rest1, rest2, acc <> l1)
  end
  defp take_while_eq(_,_, acc), do: acc
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
