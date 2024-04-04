# https://leetcode.com/problems/number-of-students-doing-homework-at-a-given-time/description/
# 1450. Number of Students Doing Homework at a Given Time

defmodule Solution do
  @spec busy_student(start_time :: [integer], end_time :: [integer], query_time :: integer) :: integer
  def busy_student(start_time, end_time, query_time) do
    [start_time, end_time]
    |> Enum.zip_reduce(0, fn [v, w], count ->
      if v <= query_time and query_time <= w, do: count + 1, else: count
    end)
  end
end


[1,2,3] |> Solution.busy_student([3,2,7], 4) |> IO.inspect()
# Output: 1
[4] |> Solution.busy_student([4], 4) |> IO.inspect()
# Output: 1
[1,2,7] |> Solution.busy_student([2,2,8], 4) |> IO.inspect()
# Output: 0
[1,2,3] |> Solution.busy_student([12,22,18], 4) |> IO.inspect()
# Output: 3
[] |> Solution.busy_student([], 4) |> IO.inspect()
# Output: 0
[1] |> Solution.busy_student([], 4) |> IO.inspect()
# Output: 0
[] |> Solution.busy_student([4], 4) |> IO.inspect()
# Output: 0

