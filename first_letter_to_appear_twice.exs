# https://leetcode.com/problems/first-letter-to-appear-twice/description/
# 2351. First Letter to Appear Twice

defmodule Solution do
  @spec repeated_character(s :: String.t) :: char
  def repeated_character(s) do
    # s |> String.to_charlist() |> aux(MapSet.new())
    do_repeated_character(s, MapSet.new)
  end

  defp do_repeated_character(<<>>, _set), do: ""
  defp do_repeated_character(<<ch, rest::bytes>>, set) do
    if MapSet.member?(set, ch), do: ch, else: do_repeated_character(rest, MapSet.put(set, ch))
  end

  # defp aux([], _set), do: ""
  # defp aux([c | cs], set) do
  #   if MapSet.member?(set, c), do: c, else: aux(cs, MapSet.put(set, c))
  # end
end

IO.inspect(Solution.repeated_character("abccbaacz"))
# Output: "c"
IO.inspect(Solution.repeated_character("abcdd"))
# Output: "d"
IO.inspect(Solution.repeated_character("abcdef"))
# Output: ""
