# https://leetcode.com/problems/find-edges-in-shortest-paths/description/
# 3123. Find Edges in Shortest Paths

# https://rosettacode.org/wiki/Priority_queue#Elixir
# https://www.erlang.org/doc/man/gb_trees
defmodule PriorityQueue do
  defstruct [:tree]

  def new(), do: %__MODULE__{tree: :gb_trees.empty()}
  def new([]), do: new()
  def new([{_priority, _element} | _] = list), do: %__MODULE__{tree: :gb_trees.from_orddict(list)}

  def size(%__MODULE__{} = q) do
    :gb_trees.size(q.tree)
  end

  def push(%__MODULE__{} = q, {priority, element}) do
    %__MODULE__{tree: :gb_trees.enter( priority, element, q.tree )}
  end

  def pop(%__MODULE__{} = q) do
    case :gb_trees.size(q.tree) do
      0 ->
        :empty
      _else ->
        {priority, element, tree} = :gb_trees.take_smallest(q.tree)
        {{priority, element}, %__MODULE__{tree: tree}}
    end
  end
end

defmodule Solution do
  @spec find_answer(n :: integer, edges :: [[integer]]) :: [boolean]
  def find_answer(n, edges) do
    # IO.inspect(edges)
    graph =
      Enum.reduce(edges, Map.new(), fn [a, b, w], acc ->
        Map.update(acc, a, %{b => w}, &Map.merge(&1, %{b => w}) )
          |> Map.update(b, %{a => w}, &Map.merge(&1, %{a => w}) )
      end)
    # IO.inspect(graph)
    source_dist = dijkstra(0, graph)
    # IO.inspect('source_dist')
    # IO.inspect(source_dist)
    target_dist = dijkstra(n - 1, graph)
    # IO.inspect('target_dist')
    # IO.inspect(target_dist)
    if Map.has_key?(source_dist, n - 1) do
      d = Map.get(source_dist, n - 1)
      Enum.map(edges, fn [a, b, w] ->
        Map.get(source_dist, a, INF) + w + Map.get(target_dist, b, INF) == d ||
        Map.get(source_dist, b, INF) + w + Map.get(target_dist, a, INF) == d
      end)
    else
      List.duplicate(false, length(edges))
    end
  end

  defp dijkstra(source, graph) do
    dijkstra_loop(
      PriorityQueue.new([{0, source}]),
      %{source => 0},
      graph
    )
  end

  defp dijkstra_loop(pq, dist, graph) do
    if PriorityQueue.size(pq) > 0 do
      {{d, cur}, pq} = PriorityQueue.pop(pq)
      {dist, pq} = if d == dist[cur] do
        for {nb, w} <- graph[cur], reduce: {dist, pq} do
          {acc_dist, acc_pq} ->
            if Map.get(dist, nb, :infinity) > d + w do
              new_dist = Map.put(acc_dist, nb, d + w)
              {
                new_dist ,
                PriorityQueue.push(acc_pq, {new_dist[nb],nb})
              }
            else
              {acc_dist, acc_pq}
            end
        end
      else
        {dist, pq}
      end
      dijkstra_loop(pq, dist, graph)
    else
      dist
    end
  end
end

Solution.find_answer(6,[[0,1,4],[0,2,1],[1,3,2],[1,4,3],[1,5,1],[2,3,1],[3,5,3],[4,5,2]]) |> IO.inspect()
# Output: [true,true,true,false,true,true,true,false]
Solution.find_answer(4,[[2,0,1],[0,1,1],[0,3,4],[3,2,2]]) |> IO.inspect()
# Output: [true,false,false,true]
