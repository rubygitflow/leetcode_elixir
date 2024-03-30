# https://leetcode.com/problems/alert-using-same-key-card-three-or-more-times-in-a-one-hour-period/description/
# 1604. Alert Using Same Key-Card Three or More Times in a One Hour Period

defmodule Solution do
  @spec alert_names(key_name :: [String.t], key_time :: [String.t]) :: [String.t]
  def alert_names(key_name, key_time) do
    key_name
    |> Enum.zip(
      Enum.map(key_time, fn x -> 
        [hour, min] = String.split(x, ":")
        String.to_integer(hour) * 60 + String.to_integer(min)
      end))
    |> Enum.group_by(&elem(&1, 0), &elem(&1, 1))
    |> Map.filter(fn {_key, val} ->
          closest_times(Enum.sort(val), 0, length(val)-2-1, 60)
       end)
    |> Map.keys
  end

  defp closest_times(_times, from, to, _total_time) when from > to, do: false
  defp closest_times([times_0| tail], from, to, total_time) do
    times_2 = tail |> tl() |> hd()
    if (times_2 - times_0) > total_time do
      closest_times(tail, from+1, to, total_time)
    else
      true
    end
  end
end

["daniel","daniel","daniel","luis","luis","luis","luis"] |> Solution.alert_names(["10:00","10:40","11:00","09:00","11:00","13:00","15:00"]) |> IO.inspect()
# Output: ["daniel"]
["alice","alice","alice","bob","bob","bob","bob"] |> Solution.alert_names(["12:01","12:00","18:00","21:00","21:20","21:30","23:00"]) |> IO.inspect()
# Output: ["bob"]
