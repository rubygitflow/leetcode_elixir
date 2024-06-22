# https://leetcode.com/problems/merge-intervals/description/
# 56. Merge Intervals

defmodule Solution do
  @spec merge(intervals :: [[integer]]) :: [[integer]]
  def merge(intervals) do
    if length(intervals) > 0 do
      [h | t] = Enum.sort(intervals)
      Enum.reduce(t, [h], fn [e_0, e_1] = e,
                             [[l, r] | t_acc] = acc ->
        if e_0 <= r && e_1 >= l do
          [[min(e_0, l), max(e_1, r)] | t_acc]
        else
          [e | acc]
        end
      end)
      |> Enum.reverse()
    else
      []
    end
  end
end


IO.inspect(Solution.merge([[1,3],[2,6],[8,10],[15,18]]))
# Output: [[1,6],[8,10],[15,18]]
IO.inspect(Solution.merge([[1,3],[15,18],[2,6],[8,10]]))
# Output: [[1,6],[8,10],[15,18]]
IO.inspect(Solution.merge([[1,4],[4,5]]))
# Output: [[1,5]]
IO.inspect(Solution.merge([]))
# Output: []
IO.inspect(Solution.merge([[-11,40],[1,4],[4,5]]))
# Output: [[-11,40]]
