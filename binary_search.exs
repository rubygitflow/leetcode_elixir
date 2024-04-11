# https://leetcode.com/problems/binary-search/description/
# 704. Binary Search

defmodule Solution do
  @spec search(nums :: [integer], target :: integer) :: integer
  def search(nums, target) do
    tuple = List.to_tuple(nums)
    binary_search(tuple, 0, tuple_size(tuple) - 1, target)
  end

  defp binary_search(tuple, left, right, target) when is_tuple(tuple) and left <= right do
    mid = floor((left + right) / 2)
    current = elem(tuple, mid)
    cond do
      current < target -> binary_search(tuple, mid + 1, right, target)
      current > target -> binary_search(tuple, left, mid - 1, target)
      current == target -> mid
    end
  end
  defp binary_search(tuple, _left, _right, _target) when is_tuple(tuple), do: -1
end

IO.inspect("Binary Search")
Solution.search([-1,0,3,5,9,12], 9) |> IO.inspect()
# Output: 4
Solution.search([-1,0,3,5,9,12], 2) |> IO.inspect()
# Output: -1

