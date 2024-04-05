# https://leetcode.com/problems/detect-pattern-of-length-m-repeated-k-or-more-times/description/
# 1566. Detect Pattern of Length M Repeated K or More Times

defmodule Solution do
  @spec contains_pattern(arr :: [integer], m :: integer, k :: integer) :: boolean
  def contains_pattern(arr, m, k) do
    do_contains_pattern(arr,  m, k)
  end

  defp do_contains_pattern(arr, m, k) when length(arr) - m * k >= 0 do
    sliced = arr |> Enum.take(m) |> Enum.join() |> String.duplicate(k)
    targetStr = arr |> Enum.take(m * k) |> Enum.join()
    sliced == targetStr || do_contains_pattern(tl(arr), m, k)
  end
  defp do_contains_pattern(_, _, _), do: false
end

[1,2,4,4,4,4] |> Solution.contains_pattern(1, 3) |> IO.inspect()
# Output: true
[1,2,1,2,1,1,1,3] |> Solution.contains_pattern(2, 2) |> IO.inspect()
# Output: true
[1,2,1,2,1,3] |> Solution.contains_pattern(2, 3) |> IO.inspect()
# Output: false
[1,2,1,2] |> Solution.contains_pattern(2, 3) |> IO.inspect()
# Output: false
