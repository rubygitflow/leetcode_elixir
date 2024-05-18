# https://leetcode.com/problems/find-edges-in-shortest-paths/description/
# 3123. Find Edges in Shortest Paths

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
        IO.inspect(q.tree)
        {priority, element, tree} = :gb_trees.take_smallest(q.tree)
        {{priority, element}, %{q | tree: tree}}
    end
  end
end

defmodule Solution do
  @spec find_answer(n :: integer, edges :: [[integer]]) :: [boolean]
  def find_answer(n, edges) do
    IO.inspect(edges)
    # Add tests for PriorityQueue
    if n > 5 do
      pq = PriorityQueue.new([{10, 2},{8, 3}])
      pq = PriorityQueue.push(pq,{5,1})
      pq = PriorityQueue.push(pq,{0,0})
      IO.inspect(pq.tree)
      IO.inspect(PriorityQueue.size(pq))
      {{_priority, _element}, _pq} = PriorityQueue.pop(pq)
    end
  end
end


Solution.find_answer(6,[[0,1,4],[0,2,1],[1,3,2],[1,4,3],[1,5,1],[2,3,1],[3,5,3],[4,5,2]]) |> IO.inspect()
# Output: [true,true,true,false,true,true,true,false]
Solution.find_answer(4,[[2,0,1],[0,1,1],[0,3,4],[3,2,2]]) |> IO.inspect()
# Output: [true,false,false,true]
