# https://leetcode.com/problems/sum-of-digits-of-string-after-convert/
# 1945. Sum of Digits of String After Convert

defmodule Solution do
  @spec get_lucky(s :: String.t, k :: integer) :: integer
  def get_lucky(s, k) do
    for <<x <- s>>, reduce: 0 do
      acc -> acc + take_digit_sum(x - ?a + 1, 0)
    end |> do_get_lucky(k - 1)
  end

  defp take_digit_sum(num, out) when num > 0, do: take_digit_sum(div(num, 10), out + rem(num, 10))
  defp take_digit_sum(_, out), do: out

  defp do_get_lucky(tmp, k) when k > 0 and tmp > 9, do: do_get_lucky(take_digit_sum(tmp, 0), k - 1)
  defp do_get_lucky(tmp, _), do: tmp
end

IO.inspect(Solution.get_lucky("iiii", 1))
# Output: 36
IO.inspect(Solution.get_lucky("leetcode", 2))
# Output: 6
IO.inspect(Solution.get_lucky("zbax", 2))
# Output: 8
