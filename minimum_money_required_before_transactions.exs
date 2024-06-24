# https://leetcode.com/problems/minimum-money-required-before-transactions/description/
# 2412. Minimum Money Required Before Transactions
# Explanation from https://algo.monster/liteproblems/2412

defmodule Solution do
  @spec minimum_money(transactions :: [[integer]]) :: integer
  def minimum_money(transactions) do
    total_negative_cash_flow = transactions
    |> Enum.reduce(0, fn [cost, cashback], acc ->
      acc + max(0, cost - cashback)
    end)
    transactions
    |> Enum.reduce(0, fn [cost, cashback], max_additional_money_required ->
      max(
        max_additional_money_required,
        if(cost > cashback, do: total_negative_cash_flow + cashback, else: total_negative_cash_flow + cost)
      )
    end)
  end
end

IO.inspect(Solution.minimum_money([[2,1],[5,0],[4,2]]))
# Output: 10
IO.inspect(Solution.minimum_money([[3,0],[0,3]]))
# Output: 3
IO.inspect(Solution.minimum_money([[7, 2], [5, 0], [4, 1], [5, 8], [5, 9], [0, 10]]))
# Output: 18
