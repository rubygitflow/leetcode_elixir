# https://leetcode.com/problems/first-unique-character-in-a-string/description/
# 387. First Unique Character in a String

defmodule Solution do
  @spec first_uniq_char(s :: String.t) :: integer
  def first_uniq_char(s) do
    chars = String.to_charlist(s)
    cnt = chars |> Enum.frequencies()
    ind = Enum.find_index(chars, fn c -> Map.get(cnt, c) == 1 end)
    if ind, do: ind, else: -1
  end
end

IO.inspect(Solution.first_uniq_char("leetcode"))
# Output: 0
IO.inspect(Solution.first_uniq_char("loveleetcode"))
# Output: 2
IO.inspect(Solution.first_uniq_char("aabb"))
# Output: -1
