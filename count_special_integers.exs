# https://leetcode.com/problems/count-numbers-with-unique-digits/description/
# 357. Count Numbers with Unique Digits
# Explanation: https://algo.monster/liteproblems/357

defmodule Solution do
  @spec count_numbers_with_unique_digits(n :: integer) :: integer
  def count_numbers_with_unique_digits(n) do
    cond do
      n == 0 -> 1
      n == 1 -> 10
      true ->
         factor = [9] ++ (1..(n-1) |> Enum.map(fn x -> 10 - x end))
         take_num(factor, 1, 0) + 1
    end
  end

  defp take_num([], _cur, out), do: out
  defp take_num([h|t], cur, out) do
    take_num(t, h*cur, out+h*cur)
  end
end

IO.inspect(Solution.count_numbers_with_unique_digits(0))
# Output: 1
IO.inspect(Solution.count_numbers_with_unique_digits(1))
# Output: 10
IO.inspect(Solution.count_numbers_with_unique_digits(2))
# Output: 91
IO.inspect(Solution.count_numbers_with_unique_digits(3))
# Output: 739
IO.inspect(Solution.count_numbers_with_unique_digits(4))
# Output: 5275
IO.inspect(Solution.count_numbers_with_unique_digits(5))
# Output: 32491
IO.inspect(Solution.count_numbers_with_unique_digits(6))
# Output: 168571
IO.inspect(Solution.count_numbers_with_unique_digits(7))
# Output: 712891
IO.inspect(Solution.count_numbers_with_unique_digits(8))
# Output: 2345851
