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

  @spec search_matrix(matrix :: [[integer]], target :: integer) :: boolean
  def search_matrix(matrix, target) do
    vector = List.to_tuple(matrix |> Enum.reduce_while([], fn x, acc ->
      if hd(x) <= target do
        {:cont, x}
      else
        {:halt, acc}
      end
    end))
    output = binary_search(vector, 0, tuple_size(vector) - 1, target)
    if output < 0, do: false, else: true
  end
end

IO.inspect("Binary Search")
Solution.search([-1,0,3,5,9,12], 9) |> IO.inspect()
# Output: 4
Solution.search([-1,0,3,5,9,12], 2) |> IO.inspect()
# Output: -1

IO.inspect("Search a 2D Matrix")
Solution.search_matrix([[1,3,5,7],[10,11,16,20],[23,30,34,60]], -2) |> IO.inspect()
# Output: false
Solution.search_matrix([[1,3,5,7],[10,11,16,20],[23,30,34,60]], 13) |> IO.inspect()
# Output: false
Solution.search_matrix([[1,3,5,7],[10,11,16,20],[23,30,34,60]], 23) |> IO.inspect()
# Output: true
Solution.search_matrix([[1,3,5,7],[10,11,16,20],[23,30,34,60]], 34) |> IO.inspect()
# Output: true
