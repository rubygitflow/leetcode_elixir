# https://leetcode.com/problems/minimum-time-visiting-all-points/description/
# 1266. Minimum Time Visiting All Points

defmodule Solution do
  @spec min_time_to_visit_all_points(points :: [[integer]]) :: integer
  def min_time_to_visit_all_points(points) when length(points) < 2, do: 0
  def min_time_to_visit_all_points(points), do: do_min_time_to_visit_all_points(points, 0)

  defp do_min_time_to_visit_all_points([p1 | [p2 | _] = tl], acc),
    do: do_min_time_to_visit_all_points(tl, acc + distance(p1, p2))
  defp do_min_time_to_visit_all_points([_], acc), do: acc

  defp distance([x1, y1], [x2, y2]), do: max(abs(x1 - x2), abs(y1 - y2))
end

[[1,1],[3,4],[-1,0]] |> Solution.min_time_to_visit_all_points() |> IO.inspect()
# Output: 7
[[3,2],[-2,2]] |> Solution.min_time_to_visit_all_points() |> IO.inspect()
# Output: 5
[[3,2]] |> Solution.min_time_to_visit_all_points() |> IO.inspect()
# Output: 0
