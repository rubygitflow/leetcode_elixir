# https://hexdocs.pm/ex_unit/1.17/ExUnit.html#functions
# https://hexdocs.pm/ex_unit/1.17/ExUnit.Assertions.html

ExUnit.start(autorun: false, capture_log: true)
# ExUnit.configure(exclude: :pending, trace: true)

import ExUnit.CaptureIO

# Read all the solutions at once
# {:ok, files} = File.ls()
# # files |> IO.inspect()
# Enum.each(files, fn file ->
#   unless File.dir?(file) do
#     if String.match?(file, ~r/.\.exs$/) do
#       capture_io(fn ->
#         Code.require_file("../#{file}", __DIR__)
#       end)
#     end
#   end
# end)

# Read only the prepared solutions
[
  "collect_all_apples_in_tree.exs",
  "single_number.exs",
  "top_k_frequent_words.exs",
  "delete_characters_to_make_fancy_string.exs",
]
|> Enum.each(fn file ->
    capture_io(fn ->
      Code.require_file("../#{file}", __DIR__)
    end)
end)


defmodule FullTest do
  use ExUnit.Case

  test "Delete Characters to Make Fancy String (FOR-loop)" do
    assert Solution1957.make_fancy_string("leeetcode") == "leetcode"
    assert Solution1957.make_fancy_string("aaabaaaa") == "aabaa"
    assert Solution1957.make_fancy_string("aab") == "aab"
  end

  test "Delete Characters to Make Fancy String (reduce)" do
    assert Solution1957.make_fancy_string_ii("leeetcode") == "leetcode"
    assert Solution1957.make_fancy_string_ii("aaabaaaa") == "aabaa"
    assert Solution1957.make_fancy_string_ii("aab") == "aab"
  end


  test "Top K Frequent Words" do
    assert Solution347_692.top_k_frequent_words(["i","love","leetcode","i","love","coding"], 2) == ["i","love"]
    assert Solution347_692.top_k_frequent_words(["the","day","is","sunny","the","the","the","sunny","is","is"], 4) == ["the","is","sunny","day"]
    assert Solution347_692.top_k_frequent_words(["the","the","the","day","sunny","sunny","is","is","is"], 2) == ["is", "the"]
    assert Solution347_692.top_k_frequent_words(["the","the","the","day","sunny","sunny","is","is","is"], 6) == ["is", "the", "sunny", "day"]
  end

  test "Top K Frequent Elements" do
    assert Solution347_692.top_k_frequent_elements([1,1,1,2,2,3], 2) == [1,2]
    assert Solution347_692.top_k_frequent_elements([1], 1) == [1]
    assert Solution347_692.top_k_frequent_elements([10,11,13,25,22,30,42,10], 2) == [10, 11]
    assert Solution347_692.top_k_frequent_elements([10,11,13,25,22,30,42,10], 3) == [10, 11, 13]
    assert Solution347_692.top_k_frequent_elements([10,11,13,25,22,30,42,10], 0) == [10, 11, 13, 22, 25, 30, 42]
    assert Solution347_692.top_k_frequent_elements([10,11,13,25,22,30,42,10], -2) == [10, 11]
    assert Solution347_692.top_k_frequent_elements([1,1,1,2,2,3,0,0,0,5,5,5], 2) == [0, 1]
    assert Solution347_692.top_k_frequent_elements([1,1,1,2,2,3,5,5,5,0,0,0], 2) == [0, 1]
  end


  test "Single Number" do
    assert Solution136_137.single_number([2,2,1,1,1]) == 1
    assert Solution136_137.single_number([2,2,1]) == 1
    assert Solution136_137.single_number([4,1,2,1,2]) == 4
    assert Solution136_137.single_number([1]) == 1
  end

  test "Single Number II" do
    assert Solution136_137.single_number_ii([2,2,3,2]) == 3
    assert Solution136_137.single_number_ii([0,1,0,1,0,1,99]) == 99
    assert Solution136_137.single_number_ii([0,1,0,1,0,1]) == 0
  end


  test "Minimum Time to Collect All Apples in a Tree" do
    assert Solution1443.min_time(7,[[0,1],[0,2],[1,4],[1,5],[2,3],[2,6]],[false,false,true,false,true,true,false]) == 8
    assert Solution1443.min_time(7,[[0,1],[0,2],[1,4],[1,5],[2,3],[2,6]],[false,false,true,false,false,true,false]) == 6
    assert Solution1443.min_time(7,[[0,1],[0,2],[1,4],[1,5],[2,3],[2,6]],[false,false,false,false,false,false,false]) == 0
    assert Solution1443.min_time(7,[[0,1],[0,2],[1,4],[1,5],[2,3],[2,6]],[true,false,false,false,false,false,false]) == 0
    assert Solution1443.min_time(9,[[0,1],[0,2],[1,4],[1,5],[2,3],[2,6],[4,7],[4,8]],[false,false,false,false,false,false,false,false,true]) == 6
    assert Solution1443.min_time(9,[[0,1],[0,2],[1,4],[1,5],[2,3],[2,6],[4,7],[4,8]],[false,true,false,false,true,false,false,false,true]) == 6
  end
end

ExUnit.run()
