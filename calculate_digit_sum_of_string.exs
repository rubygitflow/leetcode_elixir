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
end

IO.inspect(Solution.digit_sum("11111222223", 3))
# Output: "135"
IO.inspect(Solution.digit_sum("00000000", 3))
# Output: "000"

