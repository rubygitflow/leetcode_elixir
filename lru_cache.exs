# https://leetcode.com/problems/lru-cache/description/
# 146. LRU Cache
# Least Recently Used (LRU) cache

defmodule LRUCache do
  @spec init_(capacity :: integer) :: any
  def init_(capacity) do
    Agent.start_link(fn -> %{lru: [], cap: capacity} end, name: __MODULE__)
  end

  @spec get(key :: integer) :: integer
  def get(key) do
    Agent.get_and_update(__MODULE__, fn %{lru: lru, cap: _capacity} = state ->
      case List.keyfind(lru, key, 0) do
        nil -> 
          {-1, state}
        {key, value} -> 
          new_lru = [{key, value} | List.keydelete(lru, key, 0)]
          {value, %{state | lru: new_lru}}
      end
    end)
  end

  @spec put(key :: integer, value :: integer) :: any
  def put(key, value) do
    Agent.update(__MODULE__, fn state ->
      new_lru = [{key, value} | state.lru]
      if length(new_lru) > state.cap do
        %{state | lru: remove_last(new_lru)}
      else
        %{state | lru: new_lru}
      end
    end)
  end
      
  defp remove_last(list), do: list |> Enum.reverse |> tl() |> Enum.reverse
end

# Your functions will be called as such:
# LRUCache.init_(capacity)
# param_1 = LRUCache.get(key)
# LRUCache.put(key, value)

# LRUCache.init_ will be called before every test case, in which you can do some necessary initializations.

LRUCache.init_(2)
commands = ["put", "put", "get", "put", "get", "put", "get", "get", "get"]
resources = [[1, 1], [2, 2], [1], [3, 3], [2], [4, 4], [1], [3], [4]]
# Output
# [nil, nil, 1, nil, -1, nil, -1, 3, 4]

Enum.zip(commands, resources) |> Enum.each(fn {com, inp} ->
  if com == "put" do
    {key, value} = List.to_tuple(inp)
    LRUCache.put(key, value)
    IO.inspect(nil)
  else
    {key} = List.to_tuple(inp)
    param_1 = LRUCache.get(key)
    IO.inspect(param_1)
  end 
end)
