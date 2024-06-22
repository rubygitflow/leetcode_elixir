# https://leetcode.com/problems/best-time-to-buy-and-sell-stock/description/
# 121. Best Time to Buy and Sell Stock

defmodule Solution do
  @spec max_profit(prices :: [integer]) :: integer
  def max_profit(prices) do
    if length(prices) < 2 do
      0
    else
      Enum.reduce(prices, {0, hd(prices)}, fn price, {max_price, buy} ->
        {max(max_price, price - buy), min(buy, price)}
      end)
      |> elem(0)
    end
  end
end


IO.inspect("Best Time to Buy and Sell Stock")
IO.inspect(Solution.max_profit([7,1,5,3,6,4]))
# Output: 5
IO.inspect(Solution.max_profit([7,6,4,3,1]))
# Output: 0
