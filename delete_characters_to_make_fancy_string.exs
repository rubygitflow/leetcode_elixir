# https://leetcode.com/problems/delete-characters-to-make-fancy-string/description/
# 1957. Delete Characters to Make Fancy String

defmodule Solution1957 do
  @spec make_fancy_string(s :: String.t) :: String.t
  def make_fancy_string(s) do
    do_make_fancy_string(s, nil, nil, <<>>)
  end

  defp do_make_fancy_string(<<ch, rest::bytes>>, prev_ch, prev2_ch, acc) do
    cond do
      ch == prev_ch && ch == prev2_ch -> do_make_fancy_string(rest, prev_ch, prev2_ch, acc)
      true -> do_make_fancy_string(rest, ch, prev_ch, <<acc::bytes, ch>>)
    end
  end
  defp do_make_fancy_string(_, _, _, acc), do: acc

  def make_fancy_string_ii(s) do
    s
    |> String.to_charlist
    |> Enum.reduce({"","",""}, fn ch, {acc, prev_ch, prev2_ch} ->
      {
        if(ch == prev_ch && ch == prev2_ch, do: acc, else: <<acc::bytes, ch>>),
        ch,
        prev_ch
      }
    end)
    |> elem(0)
  end
end


IO.inspect("Delete Characters to Make Fancy String (FOR-loop)")
IO.inspect(Solution1957.make_fancy_string("leeetcode"))
# Output: "leetcode"
IO.inspect(Solution1957.make_fancy_string("aaabaaaa"))
# Output: "aabaa"
IO.inspect(Solution1957.make_fancy_string("aab"))
# Output: "aab"

IO.inspect("Delete Characters to Make Fancy String (reduce)")
IO.inspect(Solution1957.make_fancy_string_ii("leeetcode"))
# Output: "leetcode"
IO.inspect(Solution1957.make_fancy_string_ii("aaabaaaa"))
# Output: "aabaa"
IO.inspect(Solution1957.make_fancy_string_ii("aab"))
# Output: "aab"
