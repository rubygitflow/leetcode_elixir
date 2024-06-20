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
