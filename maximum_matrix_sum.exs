# https://leetcode.com/problems/maximum-matrix-sum/description/
# 1975. Maximum Matrix Sum

import Integer

defmodule Solution1975 do
  @spec max_matrix_sum(matrix :: [[integer]]) :: integer
  def max_matrix_sum(matrix) do
    {total, cnt, mi} = matrix
    |> List.flatten
    |> Enum.reduce({0, 0, :infinity}, fn elem, {total, cnt, mi} ->
      {
        total + abs(elem),
        if(elem < 0, do: cnt + 1, else: cnt),
        min(mi, abs(elem))
      }
    end)
    if is_even(cnt) || mi == 0, do: total, else: total - mi * 2
  end
end


IO.inspect(Solution1975.max_matrix_sum([[1,-1],[-1,1]]))
# Output: 4
IO.inspect(Solution1975.max_matrix_sum([[1,2,3],[-1,-2,-3],[1,2,3]]))
# Output: 16
