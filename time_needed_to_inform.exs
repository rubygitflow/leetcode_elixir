# https://leetcode.com/problems/time-needed-to-inform-all-employees/description/
# 1376. Time Needed to Inform All Employees

defmodule Solution do
  @spec num_of_minutes(n :: integer, head_id :: integer, manager :: [integer], inform_time :: [integer]) :: integer
  def num_of_minutes(_n, head_id, manager, inform_time) do
    team = manager
      |> Enum.with_index()
      |> Enum.reduce( Map.new(), fn {u, v}, acc -> Map.update(acc, u, [v], &[v | &1]) end)
    dfs(head_id, team, List.to_tuple(inform_time))
  end

  defp dfs(emp, team, inform_time) do
    team_iterate(emp, team, Map.get(team, emp, []), inform_time, 0)
  end

  defp team_iterate(_emp, _team, [], _inform_time, output), do: output
  defp team_iterate(emp, team, [head | tail], inform_time, output) do
    res = Enum.max([output, dfs(head, team, inform_time) + elem(inform_time, emp)])
    team_iterate(emp, team, tail, inform_time, res)
  end
end

Solution.num_of_minutes(1, 0, [-1], [0]) |> IO.inspect()
# Output: 0
Solution.num_of_minutes(6, 2, [2,2,-1,2,2,2], [0,0,1,0,0,0]) |> IO.inspect()
# Output: 1
Solution.num_of_minutes(9, 2, [2,2,-1,2,2,2,3,4,5], [0,0,1,2,2,1,1,1,1]) |> IO.inspect()
# Output: 3
