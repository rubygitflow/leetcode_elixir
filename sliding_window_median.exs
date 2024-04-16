# https://leetcode.com/problems/sliding-window-median/
# 480. Sliding Window Median

require Integer

defmodule Solution do
  @spec median_sliding_window(nums :: [integer], k :: integer) :: [float]
  def median_sliding_window(nums, k) do
    # odd = if Integer.is_odd(k), do: true, else: false
    median_index = if Integer.is_odd(k), do: div(k, 2), else: div(k, 2)-1
    median_index_next = median_index + 1
    if length(nums) < k do
      []
    else
      do_median_sliding_window(nums, [], {median_index, median_index_next, k}, {})
    end
  end

  defp do_median_sliding_window([], res, {_median_index, _median_index_next, k}, window) when tuple_size(window) < k, do: Enum.reverse(res) 
  defp do_median_sliding_window([], res, {median_index, median_index_next, k}, window) do
    # the last step of the cycle
    output = fetch_median({median_index, median_index_next, k}, window)
    do_median_sliding_window([], [output | res], {median_index, median_index_next, k}, window
      |> Tuple.delete_at(0))
  end
  defp do_median_sliding_window([head | tail], res, {median_index, median_index_next, k}, window) when tuple_size(window) < k do
    do_median_sliding_window(tail, res, {median_index, median_index_next, k}, Tuple.append(window, head))
  end
  defp do_median_sliding_window([head | tail], res, {median_index, median_index_next, k}, window) do
    # the main body of the cycle
    output = fetch_median({median_index, median_index_next, k}, window)
    do_median_sliding_window(tail, [output | res], {median_index, median_index_next, k}, window
      |> Tuple.delete_at(0)
      |> Tuple.append(head))
  end
  defp fetch_median({median_index, median_index_next, k}, window) do
    wnd = window
      |> Tuple.to_list()
      |> Enum.sort()
      |> List.to_tuple()
    # IO.inspect(wnd)
    if Integer.is_odd(k) do
      elem(wnd, median_index)
    else
      (elem(wnd, median_index) + elem(wnd, median_index_next)) / 2
    end
  end
end

IO.inspect("Sliding Window Median")
Solution.median_sliding_window([1,3,-1,-3,5,3,6,7], 3) |> IO.inspect()
# Output: [1, -1, -1, 3, 5, 6]
Solution.median_sliding_window([1,2,3,4,2,3,1,4,2], 3) |> IO.inspect()
# Output: [2, 3, 3, 3, 2, 3, 2]
Solution.median_sliding_window([1,3,-1,-3,5,3,6,7], 4) |> IO.inspect()
# Output: [0.0, 1.0, 1.0, 4.0, 5.5]
Solution.median_sliding_window([1,3,-1,-3,5,3,6,7], 1) |> IO.inspect()
# Output: [1,3,-1,-3,5,3,6,7]
Solution.median_sliding_window([1,3,-1,-3,5,3,6,7], 10) |> IO.inspect()
# Output: []

