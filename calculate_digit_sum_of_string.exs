# https://leetcode.com/problems/calculate-digit-sum-of-a-string/description/
# 2243. Calculate Digit Sum of a String

defmodule Solution do
  @spec digit_sum(s :: String.t, k :: integer) :: String.t
  def digit_sum(s, k) do
    if String.length(s) > k do
      digit_sum(round(s, k), k)
    else
      s
    end
  end

  defp round(s, k) do
    s
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(k)
    |> Enum.map(&Enum.sum/1)
    |> Enum.map(&Integer.to_string/1)
    |> Enum.join("")
  end

  @spec digit_sum_ii(s :: String.t, k :: integer) :: String.t
  def digit_sum_ii(s, k) when byte_size(s) > k do
    # loop: converting s to acc=<<>>
    #       to restart the main digit_sum_ii procedure
    #       while the guard clause (byte_size(s) > k) is being executed
    do_digit_sum_ii(s, 0, 0, k, <<>>) |> digit_sum_ii(k)
  end
  def digit_sum_ii(s, _), do: s

  defp do_digit_sum_ii(s, grp_sum, counter, limiter, acc) when counter == limiter do
    # when guard clause "counter == limiter" is truthy
    # put grp_sum in acc as a byte array inside the binary syntax string <<>>
    do_digit_sum_ii(s, 0, 0, limiter, <<acc::bytes, "#{grp_sum}"::bytes>>)
  end
  defp do_digit_sum_ii(<<ch, rest::bytes>>, grp_sum, counter, limiter, acc) do
    # ch      - integer
    # ?0      - the code point of the character '0'
    # grp_sum - definitive accumulator
    do_digit_sum_ii(rest, grp_sum + (ch - ?0), counter + 1, limiter, acc)
  end
  defp do_digit_sum_ii(<<>>, grp_sum, counter, _limiter, acc) do
    # return the acc value from the converted s
    if counter > 0, do: <<acc::bytes, "#{grp_sum}"::bytes>>, else: acc
  end
end

IO.inspect(Solution.digit_sum("11111222229", 3))
# Output: "132"
IO.inspect(Solution.digit_sum("11111222223", 3))
# Output: "135"
IO.inspect(Solution.digit_sum("00000000", 3))
# Output: "000"

IO.inspect(Solution.digit_sum_ii("11111222229", 3))
# Output: "132"
IO.inspect(Solution.digit_sum_ii("11111222223", 3))
# Output: "135"
IO.inspect(Solution.digit_sum_ii("00000000", 3))
# Output: "000"
