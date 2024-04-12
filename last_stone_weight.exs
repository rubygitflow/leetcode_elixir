# https://leetcode.com/problems/last-stone-weight/description/
# 1046. Last Stone Weight

#######################
# https://leetcode.com/problems/last-stone-weight-ii/description/
# 1049. Last Stone Weight II

defmodule Solution do
  @spec last_stone_weight(stones :: [integer]) :: integer
  def last_stone_weight(stones) do
    do_last_stone_weight(stones)
  end

  defp do_last_stone_weight([]), do: 0
  defp do_last_stone_weight(stones) when length(stones) == 1, do: hd(stones)
  defp do_last_stone_weight(stones) when length(stones) > 1 do
    u =  Enum.max(stones)
    u_stones = List.delete(stones, u)
    v =  Enum.max(u_stones)
    v_stones = List.delete(u_stones, v)
    diff = u - v
    if diff > 0 do
      do_last_stone_weight([diff | v_stones])
    else
      do_last_stone_weight(v_stones)
    end
  end

  @spec last_stone_weight_ii(stones :: [integer]) :: integer
  def last_stone_weight_ii(stones) do
    prev_state = stones
      |> Enum.reduce(MapSet.new([0]), fn elem, prev_state ->
        Enum.reduce(prev_state, MapSet.new(), fn prev, state ->
          state
            |> MapSet.put(prev + elem)
            |> MapSet.put(abs(prev - elem))
        end)
      end)
    Enum.min(prev_state)
  end
end

IO.inspect("Last Stone Weight")
Solution.last_stone_weight([2,7,4,1,8,2]) |> IO.inspect()
# Output: 0
Solution.last_stone_weight([2,7,4,1,8,1]) |> IO.inspect()
# Output: 1
Solution.last_stone_weight([1]) |> IO.inspect()
# Output: 1
Solution.last_stone_weight([31,26,33,21,40]) |> IO.inspect()
# Output: 9

IO.inspect("Last Stone Weight II")
Solution.last_stone_weight_ii([2,7,4,1,8,1]) |> IO.inspect()
# Output: 1
Solution.last_stone_weight_ii([31,26,33,21,40]) |> IO.inspect()
# Output: 5
