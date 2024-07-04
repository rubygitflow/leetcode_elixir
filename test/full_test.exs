ExUnit.start(autorun: false, capture_log: true)
# ExUnit.configure(exclude: :pending, trace: true)

import ExUnit.CaptureIO

capture_io(fn ->
  Code.require_file("../collect_all_apples_in_tree.exs", __DIR__)
end)
capture_io(fn ->
  Code.require_file("../single_number.exs", __DIR__)
end)
capture_io(fn ->
  Code.require_file("../top_k_frequent_words.exs", __DIR__)
end)


defmodule FullTest do
  use ExUnit.Case

  test "Top K Frequent Words" do
    assert ["i","love"] == Solution347_692.top_k_frequent_words(["i","love","leetcode","i","love","coding"], 2)
    assert ["the","is","sunny","day"] == Solution347_692.top_k_frequent_words(["the","day","is","sunny","the","the","the","sunny","is","is"], 4)
    assert ["is", "the"] == Solution347_692.top_k_frequent_words(["the","the","the","day","sunny","sunny","is","is","is"], 2)
    assert ["is", "the", "sunny", "day"] == Solution347_692.top_k_frequent_words(["the","the","the","day","sunny","sunny","is","is","is"], 6)
  end

  test "Top K Frequent Elements" do
    assert [1,2] == Solution347_692.top_k_frequent_elements([1,1,1,2,2,3], 2)
    assert [1] == Solution347_692.top_k_frequent_elements([1], 1)
    assert [10, 11] == Solution347_692.top_k_frequent_elements([10,11,13,25,22,30,42,10], 2)
    assert [10, 11, 13] == Solution347_692.top_k_frequent_elements([10,11,13,25,22,30,42,10], 3)
    assert [10, 11, 13, 22, 25, 30, 42] == Solution347_692.top_k_frequent_elements([10,11,13,25,22,30,42,10], 0)
    assert [10, 11] == Solution347_692.top_k_frequent_elements([10,11,13,25,22,30,42,10], -2)
    assert [0, 1] == Solution347_692.top_k_frequent_elements([1,1,1,2,2,3,0,0,0,5,5,5], 2)
    assert [0, 1] == Solution347_692.top_k_frequent_elements([1,1,1,2,2,3,5,5,5,0,0,0], 2)
  end


  test "Single Number" do
    assert 1 == Solution136_137.single_number([2,2,1,1,1])
    assert 1 == Solution136_137.single_number([2,2,1])
    assert 4 == Solution136_137.single_number([4,1,2,1,2])
    assert 1 == Solution136_137.single_number([1])
  end

  test "Single Number II" do
    assert 3 == Solution136_137.single_number_ii([2,2,3,2])
    assert 99 == Solution136_137.single_number_ii([0,1,0,1,0,1,99])
    assert 0 == Solution136_137.single_number_ii([0,1,0,1,0,1])
  end


  test "Minimum Time to Collect All Apples in a Tree" do
    assert 8 == Solution1443.min_time(7,[[0,1],[0,2],[1,4],[1,5],[2,3],[2,6]],[false,false,true,false,true,true,false])
    assert 6 == Solution1443.min_time(7,[[0,1],[0,2],[1,4],[1,5],[2,3],[2,6]],[false,false,true,false,false,true,false])
    assert 0 == Solution1443.min_time(7,[[0,1],[0,2],[1,4],[1,5],[2,3],[2,6]],[false,false,false,false,false,false,false])
    assert 0 == Solution1443.min_time(7,[[0,1],[0,2],[1,4],[1,5],[2,3],[2,6]],[true,false,false,false,false,false,false])
    assert 6 == Solution1443.min_time(9,[[0,1],[0,2],[1,4],[1,5],[2,3],[2,6],[4,7],[4,8]],[false,false,false,false,false,false,false,false,true])
    assert 6 == Solution1443.min_time(9,[[0,1],[0,2],[1,4],[1,5],[2,3],[2,6],[4,7],[4,8]],[false,true,false,false,true,false,false,false,true])
  end
end

ExUnit.run()
