# https://leetcode.com/problems/minimum-time-to-collect-all-apples-in-a-tree/description/
# 1443. Minimum Time to Collect All Apples in a Tree

defmodule Solution do
  @spec min_time(n :: integer, edges :: [[integer]], has_apple :: [boolean]) :: integer
  def min_time(n, edges, has_apple) do
    g = Enum.reduce(edges, %{}, fn [x, y], map ->
      Map.update(map, x, [y], &([y | &1]))
      |> Map.update(y, [x], &([x | &1]))
    end)
    # IO.inspect(g)
    dfs(n, 0, g, List.to_tuple(has_apple))
  end

  defp dfs(prev, curr, g, has_apple) do
    Map.get(g, curr, [])
    # skip visited paths
    |> Enum.filter(&(&1 != prev))
    |> Enum.reduce(0, fn u, ans ->
      # collect all paths
      ans2 = dfs(curr, u, g, has_apple)
      if ans2 > 0 or elem(has_apple, u) do
        # add "last mile" cost
        ans + ans2 + 2
      else
        ans + ans2
      end
    end)
  end
end

Solution.min_time(7,[[0,1],[0,2],[1,4],[1,5],[2,3],[2,6]],[false,false,true,false,true,true,false]) |> IO.inspect()
# Output: 8 
Solution.min_time(7,[[0,1],[0,2],[1,4],[1,5],[2,3],[2,6]],[false,false,true,false,false,true,false]) |> IO.inspect()
# Output: 6
Solution.min_time(7,[[0,1],[0,2],[1,4],[1,5],[2,3],[2,6]],[false,false,false,false,false,false,false]) |> IO.inspect()
# Output: 0
Solution.min_time(7,[[0,1],[0,2],[1,4],[1,5],[2,3],[2,6]],[true,false,false,false,false,false,false]) |> IO.inspect()
# Output: 0
Solution.min_time(9,[[0,1],[0,2],[1,4],[1,5],[2,3],[2,6],[4,7],[4,8]],[false,false,false,false,false,false,false,false,true]) |> IO.inspect()
# Output: 6
Solution.min_time(9,[[0,1],[0,2],[1,4],[1,5],[2,3],[2,6],[4,7],[4,8]],[false,true,false,false,true,false,false,false,true]) |> IO.inspect()
# Output: 6
