# https://leetcode.com/problems/minimum-cost-for-tickets/description/
# 983. Minimum Cost For Tickets

defmodule Solution do
  @spec mincost_tickets(days :: [integer], costs :: [integer]) :: integer
  def mincost_tickets(days, [c1, c7, c30]) do
    {first, last} = Enum.min_max(days)
    days = MapSet.new(days)
    for d <- first..last, reduce: %{ first => 0 } do
      min_costs ->
        if MapSet.member?(days, d) do
          mincost =
            Enum.min([
              Map.get(min_costs, d - 1, 0) + c1,
              Map.get(min_costs, d - 7, 0) + c7,
              Map.get(min_costs, d - 30, 0) + c30
            ])
          Map.put(min_costs, d, mincost)
        else
          Map.put(min_costs, d, min_costs[d - 1])
        end
    end
    |> Map.get(last)
  end
end

[1,4,6,7,8,20] |> Solution.mincost_tickets([2,7,15]) |> IO.inspect()
# Output: 11
[1,2,3,4,5,6,7,8,9,10,30,31] |> Solution.mincost_tickets([2,7,15]) |> IO.inspect()
# Output: 17
[1,24,146] |> Solution.mincost_tickets([2,7,15]) |> IO.inspect()
# Output: 6
