# https://leetcode.com/problems/minimum-cost-to-convert-string-i/description/
# 2976. Minimum Cost to Convert String I

defmodule Solution do
  @spec minimum_cost(source :: String.t, target :: String.t, original :: [char], changed :: [char], cost :: [integer]) :: integer
  def minimum_cost(source, target, original, changed, cost) do
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
    output = [original, changed, cost]
      |> Enum.zip_reduce(%{}, fn [inp, out, cos], acc ->
        Map.put( acc, inp, Map.put(%{}, out, Enum.max([acc[inp][out]||0, cos])))
      end)

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
end

Solution.minimum_cost("abcd","acbe",["a","b","c","c","e","d","d"],["b","c","b","e","b","e","e"],[2,5,5,1,2,20,19]) |> IO.inspect()
# Output: 28 (5 > 1+2)
Solution.minimum_cost("abcd","acbe",["a","b","c","c","f","e","d"],["b","c","b","f","e","b","e"],[2,5,5,1,2,1,20]) |> IO.inspect()
# Output: 29 (5 > 1+2+1)
Solution.minimum_cost("aaaa","bbbb",["a","c"],["c","b"],[1,2]) |> IO.inspect()
# Output: 12
Solution.minimum_cost("aaaa","bbbb",["a","c"],["d","b"],[1,2]) |> IO.inspect()
# Output: -1
Solution.minimum_cost("aaaa","bbbb",["a","c","a","d","e"],["c","b","d","e","b"],[3,2,1,1,1]) |> IO.inspect()
# Output: 12
Solution.minimum_cost("abcd","abce",["a"],["e"],[10000]) |> IO.inspect()
# Output: -1
Solution.minimum_cost("aaa","aaa",["a"],["e"],[10000]) |> IO.inspect()
# Output: 0
