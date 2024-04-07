# https://leetcode.com/problems/time-needed-to-rearrange-a-binary-string/description/
# 2380. Time Needed to Rearrange a Binary String

defmodule Solution do
  @spec seconds_to_remove_occurrences(s :: String.t) :: integer
  def seconds_to_remove_occurrences(s) do
    Enum.reduce(String.to_charlist(s), {0, 0}, fn ch, {output, zeroes} ->
      if ch == ?1 do
        out = if zeroes > 0 do
          max(output + 1, zeroes)
        else
          output
        end
        {out, zeroes}
      else
        {output, zeroes + 1}
      end
    end)
    |> elem(0)
  end
end

Solution.seconds_to_remove_occurrences("000111") |> IO.inspect()
# Output: 5
Solution.seconds_to_remove_occurrences("0110001") |> IO.inspect()
# Output: 4
Solution.seconds_to_remove_occurrences("0110101") |> IO.inspect()
# Output: 4
Solution.seconds_to_remove_occurrences("11100") |> IO.inspect()
# Output: 0
