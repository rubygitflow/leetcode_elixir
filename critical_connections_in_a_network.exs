# https://leetcode.com/problems/corporate-flight-bookings/description/
# 1109. Corporate Flight Bookings

defmodule TarjanState do
  defstruct [:discovered, :lowest, :bridges, :times]

  def new() do
    %TarjanState{discovered: %{}, lowest: %{}, bridges: [], times: 0}
  end
end

defmodule Solution do
  defp tarjan(u, p, graph, state) do
    state = Map.update!(state, :times, &(&1 + 1))
    state = Map.update!(state, :discovered, &Map.put(&1, u, state.times))
    state = Map.update!(state, :lowest, &Map.put(&1, u, state.times))

    Map.get(graph, u, [])
    |> Enum.reject(fn v -> v == p end)
    |> Enum.reduce(state, fn v, state ->
      if Map.has_key?(state.discovered, v) do
        low_u = min(state.lowest[u], state.discovered[v])
        Map.update!(state, :lowest, &Map.put(&1, u, low_u))
      else
        state = tarjan(v, u, graph, state)
        low_u = min(state.lowest[u], state.lowest[v])
        state = Map.update!(state, :lowest, &Map.put(&1, u, low_u))

        if state.lowest[v] > state.discovered[u] do
          Map.update!(state, :bridges, &[[u, v] | &1])
        else
          state
        end
      end
    end)
  end

  @spec critical_connections(n :: integer, connections :: [[integer]]) :: [[integer]]
  def critical_connections(_n, connections) do
    graph =
      Enum.reduce(connections, Map.new(), fn [u, v], acc ->
        Map.update(acc, u, [v], &[v | &1]) |> Map.update(v, [u], &[u | &1])
      end)

    tarjan(0, -1, graph, TarjanState.new()).bridges
  end
end

4 |> Solution.critical_connections([[0,1],[1,2],[2,0],[1,3]]) |> IO.inspect()
# Output: [[1,3]]
2 |> Solution.critical_connections([[0,1]]) |> IO.inspect()
# Output: [[0,1]]
# infinity sign
5 |> Solution.critical_connections([[0,1],[1,2],[2,0],[1,3],[3,4],[4,1]]) |> IO.inspect()
# Output: []
# dumbbell
6 |> Solution.critical_connections([[0,1],[1,2],[2,0],[1,3],[3,4],[4,5],[5,3]]) |> IO.inspect()
# Output: [[1,3]]
# 2 donuts
6 |> Solution.critical_connections([[0,1],[1,2],[2,0],      [3,4],[4,5],[5,3]]) |> IO.inspect()
# Output: []
# star
7 |> Solution.critical_connections([[0,1],[0,2],[2,3],[0,4],[0,5],[5,6]]) |> IO.inspect()
# Output: [[0, 1], [2, 3], [0, 2], [0, 4], [5, 6], [0, 5]]
