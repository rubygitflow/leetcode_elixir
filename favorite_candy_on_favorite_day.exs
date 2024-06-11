# https://leetcode.com/problems/can-you-eat-your-favorite-candy-on-your-favorite-day/description/
# 1744. Can You Eat Your Favorite Candy on Your Favorite Day?

defmodule Solution do
  @spec can_eat(candies_count :: [integer], queries :: [[integer]]) :: [boolean]
  def can_eat(candies_count, queries) do
    [0 | candies_count]
    |> Enum.scan(&+/2)
    |> List.to_tuple()
    |> then(fn t ->
      Enum.map(queries, fn [favorite_type, favorite_day, daily_cap] ->
        favorite_day < elem(t, favorite_type + 1) and elem(t, favorite_type) < (favorite_day + 1) * daily_cap
      end)
    end)
  end
end

IO.inspect(Solution.can_eat([7,4,5,3,8], [[0,2,2],[4,2,4],[2,13,1000000000]]))
# Output: [true,false,true]
IO.inspect(Solution.can_eat([5,2,6,4,1], [[3,1,2],[4,10,3],[3,10,100],[4,100,30],[1,3,1]]))
# Output: [false,true,true,false,false]
IO.inspect(Solution.can_eat([7,4,5,3], [[0, 2, 2], [1, 6, 1], [2, 5, 10]]))
# Output: [true, false, true]
