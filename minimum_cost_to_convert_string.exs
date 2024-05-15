# https://leetcode.com/problems/minimum-cost-to-convert-string-i/description/
# 2976. Minimum Cost to Convert String I

#######################
# https://leetcode.com/problems/minimum-cost-to-convert-string-ii/description/
# 2977. Minimum Cost to Convert String II

defmodule Solution do
  @spec minimum_cost_I(source :: String.t, target :: String.t, original :: [char], changed :: [char], cost :: [integer]) :: integer
  def minimum_cost_I(source, target, original, changed, cost) do
    # Step _: Initialize necessary data structures and variables
    original_set = MapSet.new(original)
    changed_set = MapSet.new(changed)
    {actioned_inp, actioned_out} = inp_out_to_unique_arrays(
      String.split(source, "", trim: true),
      String.split(target, "", trim: true),
      [],
      []
    )
    actioned_inp_set = MapSet.new(actioned_inp)
    actioned_out_set = MapSet.new(actioned_out)
    cond do
      # Step _:  proactive exit
      Enum.any?(MapSet.difference(actioned_inp_set, original_set)) ->
        -1
      Enum.any?(MapSet.difference(actioned_out_set, changed_set)) ->
        -1
      true ->
        graph = floyd_warshall(
          original,
          changed,
          original_set,
          changed_set,
          cost
        )
        # Step _: "Dynamic programming" to find minimum cost
        evaluate(actioned_inp, actioned_out, graph, 0)
    end
  end

  defp inp_out_to_unique_arrays([],[], coll_inp, coll_out), do: {coll_inp, coll_out}
  defp inp_out_to_unique_arrays([inp_h | inp_t],[out_h | out_t], coll_inp, coll_out) when inp_h == out_h do
    inp_out_to_unique_arrays(inp_t, out_t, coll_inp, coll_out)
  end
  defp inp_out_to_unique_arrays([inp_h | inp_t],[out_h | out_t], coll_inp, coll_out) when inp_h != out_h do
    inp_out_to_unique_arrays(inp_t, out_t, [inp_h | coll_inp], [out_h | coll_out])
  end

  defp floyd_warshall(original, changed, original_set, changed_set, cost) do
    # Step _: Populate substring distances matrix
    output = [original, changed, cost]
      |> Enum.zip_reduce(%{}, fn [inp, out, cos], acc ->
        # Important! Remember the value for the old "acc[inp]" key.
        Map.put( acc, inp, Map.put(acc[inp]||%{}, out, Enum.max([acc[inp][out]||0, cos])))
      end)

    # Step _: Floyd-Warshall algorithm to calculate minimum distances between substrings
    for k <- MapSet.union(original_set, changed_set), reduce: output do
      acc_k ->
        for i <- original_set, reduce: acc_k do
          acc_i -> 
            for j <- changed_set, reduce: acc_i do
              acc_j ->
                Map.update( acc_j, i, %{}, 
                  fn current_i ->
                    Map.update(current_i, j, :infinity, 
                      fn current_j ->
                        Enum.min([
                          current_j||:infinity,
                          (
                            if acc_j[i][k]
                              && acc_j[k][j]
                              && acc_j[i][k] < :infinity
                              && acc_j[k][j] < :infinity,
                            do: acc_j[i][k] + acc_j[k][j],
                            else: :infinity
                          )
                        ])
                      end) 
                  end)
            end
        end
    end    
  end

  defp evaluate([],[], _, res), do: res 
  defp evaluate([inp_h | inp_t],[out_h | out_t], graph, res) do
    if graph[inp_h][out_h] == :infinity do
      -1
    else
      evaluate(inp_t, out_t, graph, res + graph[inp_h][out_h])
    end
  end

  @spec minimum_cost_II(source :: String.t, target :: String.t, original :: [String.t], changed :: [String.t], cost :: [integer]) :: integer
  def minimum_cost_II(source, target, original, changed, cost) do
    # Step _: Initialize necessary data structures and variables
    original_set = MapSet.new(original)
    original_len_set = Enum.to_list( MapSet.new( Enum.map(original, & String.length(&1)) ) )
    changed_set = MapSet.new(changed)
    last_ind = String.length(source)
    dp = Tuple.duplicate(:infinity, last_ind + 1)

    graph = floyd_warshall(
      original,
      changed,
      original_set,
      changed_set,
      cost
    )
    # IO.inspect("graph")
    # IO.inspect(graph)

    # Step _: "Dynamic programming" to find minimum cost
    evaluate_dp(0, source, target, put_elem(dp, 0, 0), graph, original_len_set, original_set, changed_set, last_ind)
  end

  defp evaluate_dp(i, _, _, dp, _, _, _, _, last_ind) when i == last_ind do
    last = elem(dp, last_ind)
    if last < :infinity do
      last
    else
      -1
    end
  end
  defp evaluate_dp(i, source, target, dp, graph, original_len_set, original_set, changed_set, last_ind) do
    current = elem(dp, i)
    # IO.inspect(i)
    # IO.inspect(dp)
    upd_dp = if current != :infinity do
      source_char = String.slice(source, i, 1)
      target_char = String.slice(target, i, 1)
      # IO.inspect(source_char)
      # IO.inspect(target_char)
      new_dp = if source_char == target_char do
        next = elem(dp, i + 1)
        put_elem(dp, i + 1, Enum.min([current, next]))
      else
        dp
      end
      iterate_original(i, source, target, new_dp, graph, original_set, changed_set, original_len_set, last_ind)
    else
      dp
    end
    # IO.inspect(upd_dp)
    evaluate_dp(i+1, source, target, upd_dp, graph, original_len_set, original_set, changed_set, last_ind)
  end

  # defp iterate_original(i, source, target, dp, graph, original_set, changed_set, {}, last_ind), do: {'ok'}
  defp iterate_original(_, _, _, dp, _, _, _, [], _), do: dp
  defp iterate_original(i, source, target, dp, graph, original_set, changed_set, [h_len | t_len_set], last_ind) do
    # IO.inspect("iterate_original")
    # IO.inspect(i)
    # IO.inspect(dp)
    upd_dp = if i + h_len <= last_ind do
      sub_source = String.slice(source, i, h_len)
      sub_target = String.slice(target, i, h_len)
      if Enum.member?(original_set, sub_source) and Enum.member?(changed_set, sub_target) do
        if graph[sub_source][sub_target] != :infinity do
          current = elem(dp, i)
          next = elem(dp, i + h_len)
          put_elem(dp, i + h_len, Enum.min([current + graph[sub_source][sub_target], next]))
        else
          dp
        end
      else
        dp
      end
    else
      dp
    end
    # IO.inspect(upd_dp)
    iterate_original(i, source, target, upd_dp, graph, original_set, changed_set, t_len_set, last_ind)
  end
end

IO.inspect("Minimum Cost to Convert String I")

Solution.minimum_cost_I("abcd","acbe",["a","b","c","c","e","d","d"],["b","c","b","e","b","e","e"],[2,5,5,1,2,20,19]) |> IO.inspect()
# Output: 28 (5 > 1+2)
Solution.minimum_cost_I("abcd","acbe",["a","b","c","c","f","e","d"],["b","c","b","f","e","b","e"],[2,5,5,1,2,1,20]) |> IO.inspect()
# Output: 29 (5 > 1+2+1)
Solution.minimum_cost_I("aaaa","bbbb",["a","c"],["c","b"],[1,2]) |> IO.inspect()
# Output: 12
Solution.minimum_cost_I("aaaa","bbbb",["a","c"],["d","b"],[1,2]) |> IO.inspect()
# Output: -1
Solution.minimum_cost_I("aaaa","bbbb",["a","c","a","d","e"],["c","b","d","e","b"],[3,2,1,1,1]) |> IO.inspect()
# Output: 12
Solution.minimum_cost_I("abcd","abce",["a"],["e"],[10000]) |> IO.inspect()
# Output: -1
Solution.minimum_cost_I("aaa","aaa",["a"],["e"],[10000]) |> IO.inspect()
# Output: 0

IO.inspect("Minimum Cost to Convert String II")

Solution.minimum_cost_II("abcd","acbe",["a","b","c","c","e","d"],["b","c","b","e","b","e"],[2,5,5,1,2,20]) |> IO.inspect()
# Output: 28
Solution.minimum_cost_II("fgh","ghh",["bcd","fgh","thh"],["cde","thh","ghh"],[1,3,5]) |> IO.inspect()
# Output: 8
Solution.minimum_cost_II("fgh","ghh",["fgh","f","g","thh"],["thh","g","h","ghh"],[3,1,1,5]) |> IO.inspect()
# Output: 2 (1+1 < 3+5)
Solution.minimum_cost_II("fgh","f&&",["fgh","fgh"],["f&&","f&"],[11,1]) |> IO.inspect()
# Output: 11   # source, target consist only of lowercase English characters.
Solution.minimum_cost_II("abcdefgh","acdeeghh",["bcd","fgh","thh"],["cde","thh","ghh"],[1,3,5]) |> IO.inspect()
# Output: 9
Solution.minimum_cost_II("abcdefgh","addddddd",["bcd","defgh"],["ddd","ddddd"],[100,1578]) |> IO.inspect()
# Output: -1
Solution.minimum_cost_II("aaa","aaa",["a"],["e"],[10000]) |> IO.inspect()
# Output: 0
