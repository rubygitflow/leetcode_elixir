# https://leetcode.com/problems/time-needed-to-buy-tickets/
# 2073. Time Needed to Buy Tickets

defmodule Solution do
  @spec time_required_to_buy(tickets :: [integer], k :: integer) :: integer
  def time_required_to_buy(tickets, k) do
    k_ticket = Enum.at(tickets, k)
    for x <- tickets, reduce: {0, 0} do
      {i, acc} -> acc = acc + (if i <= k, do: min(x, k_ticket), else: min(x, k_ticket - 1))
                  {i + 1, acc}
    end |> elem(1)
  end
end

Solution.time_required_to_buy([2,3,2], 2) |> IO.inspect()
# Output: 6
Solution.time_required_to_buy([5,1,1,1], 0) |> IO.inspect()
# Output: 8
Solution.time_required_to_buy([5, 2, 3, 4], 2) |> IO.inspect()
# Output: 10
