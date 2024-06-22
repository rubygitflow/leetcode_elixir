# https://leetcode.com/problems/best-time-to-buy-and-sell-stock/description/
# 121. Best Time to Buy and Sell Stock


#######################
# https://leetcode.com/problems/best-time-to-buy-and-sell-stock-ii/description/
# 122. Best Time to Buy and Sell Stock II


#######################
# https://leetcode.com/problems/best-time-to-buy-and-sell-stock-iii/description/
# 123. Best Time to Buy and Sell Stock III



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

  @spec max_profit_ii(prices :: [integer]) :: integer
  def max_profit_ii(prices) do
    if length(prices) < 2 do
      0
    else
      prices
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.reduce(0, fn [prev, curr], profit ->
        profit + max(curr - prev, 0)
      end)
    end
  end

  @spec max_profit_ii_ex(prices :: [integer]) :: integer
  def max_profit_ii_ex(prices) do
    if length(prices) < 2 do
      0
    else
      prices
      |> Enum.reduce({0, hd(prices)}, fn price, {profit, buy} ->
        {profit + max(price - buy, 0), price}
      end)
      |> elem(0)
    end
  end

  @spec max_profit_iii(prices :: [integer]) :: integer
  def max_profit_iii(prices) do
    if length(prices) < 2 do
      0
    else
      prices
      |> Enum.reduce({[0], hd(prices)}, fn price, {[hd_prof| tl_prof], buy} ->
        cond do
          price > buy ->
            {[hd_prof + price - buy| tl_prof] , price}
          price < buy ->
            {[ 0 | [hd_prof| tl_prof]] , price}
          true ->
            {[hd_prof| tl_prof], buy}
        end
      end)
      |> elem(0)
      |> Enum.sort(&(&1 >= &2))
      |> Enum.take(2)
      |> Enum.sum()
    end
  end
end


IO.inspect("Best Time to Buy and Sell Stock")
IO.inspect(Solution.max_profit([7,1,5,3,6,4]))
# Output: 5
IO.inspect(Solution.max_profit([7,6,4,3,1]))
# Output: 0


IO.inspect("Best Time to Buy and Sell Stock II")
IO.inspect(Solution.max_profit_ii([7,1,5,3,6,4]))
# Output: 7
IO.inspect(Solution.max_profit_ii([1,2,3,4,5]))
# Output: 4
IO.inspect(Solution.max_profit_ii([7,6,4,3,1]))
# Output: 0
IO.inspect(Solution.max_profit_ii([7]))
# Output: 0
IO.inspect(Solution.max_profit_ii([]))
# Output: 0

IO.inspect(Solution.max_profit_ii_ex([7,1,5,3,6,4]))
# Output: 7
IO.inspect(Solution.max_profit_ii_ex([1,2,3,4,5]))
# Output: 4
IO.inspect(Solution.max_profit_ii_ex([7,6,4,3,1]))
# Output: 0
IO.inspect(Solution.max_profit_ii_ex([7]))
# Output: 0
IO.inspect(Solution.max_profit_ii_ex([]))
# Output: 0


IO.inspect("Best Time to Buy and Sell Stock III")
IO.inspect(Solution.max_profit_iii([3,3,5,0,0,3,1,4]))
# Output: 6
IO.inspect(Solution.max_profit_iii([1,2,3,4,5]))
# Output: 4
IO.inspect(Solution.max_profit_iii([7,6,4,3,1]))
# Output: 0
IO.inspect(Solution.max_profit_iii([7]))
# Output: 0
IO.inspect(Solution.max_profit_iii([]))
# Output: 0
