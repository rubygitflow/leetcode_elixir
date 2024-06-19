# https://leetcode.com/problems/multiply-strings/description/
# 43. Multiply Strings
# Simulating Mathematical Multiplication: digit by digit

defmodule Solution do
  @spec multiply(num1 :: String.t, num2 :: String.t) :: String.t
  def multiply(num1, num2) do
    multiply_lists(to_digits(num1), to_digits(num2))
    |> back_to_string()
  end

  defp to_digits(num) do
    String.to_charlist(num)
    |> Enum.reverse()
    |> Enum.map(fn ch -> ch - ?0 end)
  end

  defp multiply_lists(list1, list2) do
    Enum.reduce(list1, {[], []}, fn val1, {product, acc} ->
      Enum.reduce(list2, {[], acc}, fn
        val2, {acc2, [x | acc]} -> {[val1 * val2 + x | acc2], acc}
        val2, {acc2, []} -> {[val1 * val2 | acc2], []}
      end)
      |> then(fn {acc2, acc} ->
        Enum.reverse(acc2, acc)
      end)
      |> then(fn [head | tail] ->
        {[head | product], tail}
      end)
    end)
    |> then(fn {product, acc} ->
      Enum.reverse(product, acc)
    end)
  end

  defp back_to_string(list, carry \\ 0, ans \\ [])
  defp back_to_string([x | tail], carry, ans) do
    sum = x + carry
    back_to_string(tail, div(sum, 10), [rem(sum, 10) | ans])
  end
  defp back_to_string([], carry, ans) do
    [carry | ans]
    |> Enum.drop_while(&(&1 == 0))
    |> then(fn
      [] -> "0"
      list -> Enum.join(list)
    end)
  end
end

IO.inspect(Solution.multiply("2", "3"))
# Output: "6"
IO.inspect(Solution.multiply("123", "456"))
# Output: "56088"
IO.inspect(Solution.multiply("999", "9"))
# Output: "8991"
