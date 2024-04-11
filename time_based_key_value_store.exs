# https://leetcode.com/problems/time-based-key-value-store/
# 981. Time Based Key-Value Store
# Look at binary_search.exs

defmodule TimeMap do
  @spec init_() :: any
  def init_() do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  @spec set(key :: String.t, value :: String.t, timestamp :: integer) :: any
  def set(key, value, timestamp) do
    Agent.update(__MODULE__, fn state ->
      sourse = Map.get(state, key)
      Map.put(
        state,
        key,
        (if is_nil(sourse), do: [], else: sourse) ++ [{timestamp, value}]
      )
    end)
  end

  @spec get(key :: String.t, timestamp :: integer) :: String.t
  def get(key, timestamp) do
    Agent.get(__MODULE__, fn state -> search(Map.get(state, key), timestamp) end)
  end

  defp search(cont, _target) when cont == nil, do: "" 
  defp search(cont, target) do
    tuple = List.to_tuple(cont)
    binary_search(tuple, 0, tuple_size(tuple) - 1, target, "")
  end

  defp binary_search(tuple, left, right, target, output) when is_tuple(tuple) and left <= right do
    mid = floor((left + right) / 2)
    {timestamp, value} = elem(tuple, mid)
    cond do
      timestamp == target -> value
      #left direction
      timestamp > target -> binary_search(tuple, left, mid - 1, target, output)
      #right direction
      timestamp < target -> binary_search(tuple, mid + 1, right, target, value)
    end
  end
  defp binary_search(tuple, _left, _right, _target, output) when is_tuple(tuple), do: output
end

# Your functions will be called as such:
TimeMap.init_()
# TimeMap.set(key, value, timestamp)
# param_2 = TimeMap.get(key, timestamp)

# TimeMap.init_ will be called before every test case, in which you can do some necessary initializations.

commands = ["get", "set", "get", "get", "set", "get", "get", "get", "get"]
resources = [["foo", 1], ["foo", "bar", 1], ["foo", 1], ["foo", 3], ["foo", "bar2", 4], ["foo", 4], ["foo", 5], ["foo", 2], ["too", 1]]
# Output
# ["", nil, "bar", "bar", nil, "bar2", "bar2", "bar", ""]

Enum.zip(commands, resources) |> Enum.each(fn {com, inp} ->
  if com == "set" do
    {key, value, time} = List.to_tuple(inp)
    TimeMap.set(key, value, time)
    IO.inspect(nil)
  else
    {key, time} = List.to_tuple(inp)
    param_2 = TimeMap.get(key, time)
    IO.inspect(param_2)
  end 
end)
