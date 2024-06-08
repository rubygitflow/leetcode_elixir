# https://leetcode.com/problems/maximum-total-importance-of-roads/description/
# 2285. Maximum Total Importance of Roads

defmodule Solution do
  @spec maximum_importance_iii(n :: integer, roads :: [[integer]]) :: integer
  def maximum_importance_iii(n, roads) do
    Enum.concat(roads)
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.sort(:desc)
    |> Enum.with_index(fn x, i -> x * (n - i) end)
    |> Enum.sum()
  end

  @spec maximum_importance_ii(n :: integer, roads :: [[integer]]) :: integer
  def maximum_importance_ii(n, roads) do
    initial = Map.new(0..(n - 1), fn x -> {x, 0} end)
    Enum.reduce(roads, initial, fn [from, to], acc ->
      tmp = Map.update(acc, from, 1, fn x -> x + 1 end)
      Map.update(tmp, to, 1, fn x -> x + 1 end)
    end)
    |> Map.values()
    |> Enum.sort()
    |> Enum.with_index()
    |> Enum.map(fn {x, i} -> x * (i + 1) end)
    |> Enum.sum()
  end

  # refactoring  maximum_importance_iii and maximum_importance_ii
  @spec maximum_importance(n :: integer, roads :: [[integer]]) :: integer
  def maximum_importance(_n, roads) do
    Enum.concat(roads)
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.sort()
    |> Enum.with_index(fn x, i -> x * (i + 1) end)
    |> Enum.sum()
  end
end

IO.inspect(Solution.maximum_importance(5,[[0,1],[1,2],[2,3],[0,2],[1,3],[2,4]]))
# Output: 43
IO.inspect(Solution.maximum_importance(5,[[0,3],[2,4],[1,3]]))
# Output: 20
IO.inspect(Solution.maximum_importance_ii(5,[[0,1],[1,2],[2,3],[0,2],[1,3],[2,4]]))
# Output: 43
IO.inspect(Solution.maximum_importance_ii(5,[[0,3],[2,4],[1,3]]))
# Output: 20
IO.inspect(Solution.maximum_importance_iii(5,[[0,1],[1,2],[2,3],[0,2],[1,3],[2,4]]))
# Output: 43
IO.inspect(Solution.maximum_importance_iii(5,[[0,3],[2,4],[1,3]]))
# Output: 20
