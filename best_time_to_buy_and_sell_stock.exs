# https://leetcode.com/problems/best-time-to-buy-and-sell-stock/description/
# 121. Best Time to Buy and Sell Stock


#######################
# https://leetcode.com/problems/best-time-to-buy-and-sell-stock-ii/description/
# 122. Best Time to Buy and Sell Stock II


#######################
# https://leetcode.com/problems/best-time-to-buy-and-sell-stock-iii/description/
# 123. Best Time to Buy and Sell Stock III


# ######################
# https://leetcode.com/problems/best-time-to-buy-and-sell-stock-iv/description/
# 188. Best Time to Buy and Sell Stock IV


#######################
# https://leetcode.com/problems/best-time-to-buy-and-sell-stock-with-cooldown/description/
# 309. Best Time to Buy and Sell Stock with Cooldown
# Explanation: https://algo.monster/liteproblems/309


#######################
# https://leetcode.com/problems/best-time-to-buy-and-sell-stock-with-transaction-fee/description/
# 714. Best Time to Buy and Sell Stock with Transaction Fee


defmodule Solution121_122_123_188_309_714 do
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

  @spec max_profit_iv(k :: integer, prices :: [integer]) :: integer
  def max_profit_iv(k, prices) do
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
      |> Enum.take(k)
      |> Enum.sum()
    end
  end

  @spec max_profit_with_hold(prices :: [integer]) :: integer
  def max_profit_with_hold(prices) do
    Enum.reduce(prices, {0, 0, 5000, 0}, &do_max_profit_with_hold/2)
    |> elem(0)
  end

  defp do_max_profit_with_hold(x, {a1, a2, cost, acc}) do
    sell = acc + x - cost
    ans = max(sell, a1)
    if sell < a2 do
      {ans, a1, x, a2}
    else
      {ans, a1, cost, acc}
    end
  end

  @spec max_profit_after_fee(prices :: [integer], fee :: integer) :: integer
  def max_profit_after_fee(prices, fee) do
    if length(prices) < 2 do
      0
    else
      transactions = prices
        |> Enum.chunk_every(2, 1, :discard)
        |> Enum.reduce([], fn [prev, curr], transactions ->
          cond do
            prev < curr -> [{prev, curr} | transactions]
            true -> transactions
          end
        end)
        |> Enum.reverse()

      # merged_deals =
      tl(transactions)
        |> Enum.reduce([hd(transactions)], fn {prev, curr}, [hd_merged | tl_merged] ->
          {a, b} = hd_merged
          cond do
            b == prev || b <  prev + fee -> [{a, curr} | tl_merged]
            true -> [{prev, curr} | [hd_merged | tl_merged]]
          end
        end)
        |> Enum.reverse()
      # merged_deals
        |> Enum.reduce(0, fn {prev, curr}, sum ->
          if curr - prev > fee do
            sum + curr - prev - fee
          else
            sum
          end
        end)
    end
  end
end


IO.inspect("Best Time to Buy and Sell Stock")
IO.inspect(Solution121_122_123_188_309_714.max_profit([7,1,5,3,6,4]))
# Output: 5
IO.inspect(Solution121_122_123_188_309_714.max_profit([7,6,4,3,1]))
# Output: 0


IO.inspect("Best Time to Buy and Sell Stock II")
IO.inspect(Solution121_122_123_188_309_714.max_profit_ii([7,1,5,3,6,4]))
# Output: 7
IO.inspect(Solution121_122_123_188_309_714.max_profit_ii([1,2,3,4,5]))
# Output: 4
IO.inspect(Solution121_122_123_188_309_714.max_profit_ii([7,6,4,3,1]))
# Output: 0
IO.inspect(Solution121_122_123_188_309_714.max_profit_ii([7]))
# Output: 0
IO.inspect(Solution121_122_123_188_309_714.max_profit_ii([]))
# Output: 0

IO.inspect(Solution121_122_123_188_309_714.max_profit_ii_ex([7,1,5,3,6,4]))
# Output: 7
IO.inspect(Solution121_122_123_188_309_714.max_profit_ii_ex([1,2,3,4,5]))
# Output: 4
IO.inspect(Solution121_122_123_188_309_714.max_profit_ii_ex([7,6,4,3,1]))
# Output: 0
IO.inspect(Solution121_122_123_188_309_714.max_profit_ii_ex([7]))
# Output: 0
IO.inspect(Solution121_122_123_188_309_714.max_profit_ii_ex([]))
# Output: 0


IO.inspect("Best Time to Buy and Sell Stock III")
IO.inspect(Solution121_122_123_188_309_714.max_profit_iii([3,3,5,0,0,3,1,4]))
# Output: 6
IO.inspect(Solution121_122_123_188_309_714.max_profit_iii([1,2,3,4,5]))
# Output: 4
IO.inspect(Solution121_122_123_188_309_714.max_profit_iii([7,6,4,3,1]))
# Output: 0
IO.inspect(Solution121_122_123_188_309_714.max_profit_iii([7]))
# Output: 0
IO.inspect(Solution121_122_123_188_309_714.max_profit_iii([]))
# Output: 0


IO.inspect("Best Time to Buy and Sell Stock IV")
IO.inspect(Solution121_122_123_188_309_714.max_profit_iv(2, [2,4,1]))
# Output: 2
IO.inspect(Solution121_122_123_188_309_714.max_profit_iv(2, [3,2,6,7,5,0,3]))
# Output: 8
IO.inspect(Solution121_122_123_188_309_714.max_profit_iv(2, [3,2,6,5,0,3]))
# Output: 7


IO.inspect("Best Time to Buy and Sell Stock with Cooldown")
IO.inspect(Solution121_122_123_188_309_714.max_profit_with_hold([1,2,3,0,2]))
# Output: 3
IO.inspect(Solution121_122_123_188_309_714.max_profit_with_hold([1]))
# Output: 0


IO.inspect("Best Time to Buy and Sell Stock with Transaction Fee")
IO.inspect(Solution121_122_123_188_309_714.max_profit_after_fee([1,3,2,8,4,9], 2))
# Output: 8
IO.inspect(Solution121_122_123_188_309_714.max_profit_after_fee([1,3,7,5,10,3], 3))
# Output: 6
IO.inspect(Solution121_122_123_188_309_714.max_profit_after_fee([8,9,7,6,8,8], 2))
# Output: 0
