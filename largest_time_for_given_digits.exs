# https://leetcode.com/problems/largest-time-for-given-digits/description/
# 949. Largest Time for Given Digits

defmodule Solution do
  @spec largest_time_from_digits(arr :: [integer]) :: String.t
  def largest_time_from_digits(arr) do
    out = 0..2
      |> Enum.to_list()
      |> Enum.reverse()
      |> Enum.find(fn el -> Enum.member?(arr, el) end)
    if out == nil do
      ""
    else
      hour_first_digit(List.delete(arr, out), to_string(out))
    end
  end

  defp hour_first_digit(arr, res) do
    out = 0..(if res == "2", do: 3, else: 9 )
      |> Enum.to_list()
      |> Enum.reverse()
      |> Enum.find(fn el -> Enum.member?(arr, el) end)
    if out == nil do
      ""
    else
      minute_second_digit(List.delete(arr, out), res <> to_string(out) <> ":")
    end
  end

  defp minute_second_digit(arr, res) do
    out = 0..5
      |> Enum.to_list()
      |> Enum.reverse()
      |> Enum.find(fn el -> Enum.member?(arr, el) end)
    if out == nil do
      ""
    else
      minute_first_digit(List.delete(arr, out), res <> to_string(out))
    end
  end

  defp minute_first_digit([head|_], res) do
    res <> to_string(head)
  end
end

Solution.largest_time_from_digits([1,5,3,4]) |> IO.inspect()
# Output: "15:43"
Solution.largest_time_from_digits([1,2,3,4]) |> IO.inspect()
# Output: "23:41"
Solution.largest_time_from_digits([5,5,5,5]) |> IO.inspect()
# Output: ""
Solution.largest_time_from_digits([0,9,9,9]) |> IO.inspect()
# Output: ""
