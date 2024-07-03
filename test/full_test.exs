ExUnit.start(autorun: false)
# ExUnit.configure(exclude: :pending, trace: true)

Code.require_file("../collect_all_apples_in_tree.exs", __DIR__)

defmodule FullTest do
  use ExUnit.Case

  test "Minimum Time to Collect All Apples in a Tree" do
    assert Solution.min_time(7,[[0,1],[0,2],[1,4],[1,5],[2,3],[2,6]],[false,false,true,false,true,true,false]) == 8
    assert Solution.min_time(7,[[0,1],[0,2],[1,4],[1,5],[2,3],[2,6]],[false,false,true,false,false,true,false]) == 6
    assert Solution.min_time(7,[[0,1],[0,2],[1,4],[1,5],[2,3],[2,6]],[false,false,false,false,false,false,false]) == 0
    assert Solution.min_time(7,[[0,1],[0,2],[1,4],[1,5],[2,3],[2,6]],[true,false,false,false,false,false,false]) == 0
    assert Solution.min_time(9,[[0,1],[0,2],[1,4],[1,5],[2,3],[2,6],[4,7],[4,8]],[false,false,false,false,false,false,false,false,true]) == 6
    assert Solution.min_time(9,[[0,1],[0,2],[1,4],[1,5],[2,3],[2,6],[4,7],[4,8]],[false,true,false,false,true,false,false,false,true]) == 6
  end
end

ExUnit.run()
