# https://hexdocs.pm/ex_unit/1.17/ExUnit.html#functions
# https://hexdocs.pm/ex_unit/1.17/ExUnit.Assertions.html

ExUnit.start(autorun: false, capture_log: true, exclude: :skip, trace: true)
# add @tag to exclude the test:
#   @tag :skip

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
  "count_number_of_special_subsequences.exs",
  "check_if_move_is_legal.exs",
  "minimum_time_to_type_word_using_special_typewriter.exs",
  "maximum_matrix_sum.exs",
  "advantage_shuffle.exs",
  "alternating_digit_sum.exs",
  "best_time_to_buy_and_sell_stock.exs",
]
|> Enum.each(fn file ->
    capture_io(fn ->
      Code.require_file("../#{file}", __DIR__)
    end)
end)


defmodule FullTest do
  use ExUnit.Case
  test "Best Time to Buy and Sell Stock" do
    assert Solution121_122_123_188_309_714.max_profit([7,1,5,3,6,4]) == 5
    assert Solution121_122_123_188_309_714.max_profit([7,6,4,3,1]) == 0
  end

  @tag :skip
  test "Best Time to Buy and Sell Stock II" do
    assert Solution121_122_123_188_309_714.max_profit_ii([7,1,5,3,6,4]) == 7
    assert Solution121_122_123_188_309_714.max_profit_ii([1,2,3,4,5]) == 4
    assert Solution121_122_123_188_309_714.max_profit_ii([7,6,4,3,1]) == 0
    assert Solution121_122_123_188_309_714.max_profit_ii([7]) == 0
    assert Solution121_122_123_188_309_714.max_profit_ii([]) == 0
  end

  test "Best Time to Buy and Sell Stock II Ex" do
    assert Solution121_122_123_188_309_714.max_profit_ii_ex([7,1,5,3,6,4]) == 7
    assert Solution121_122_123_188_309_714.max_profit_ii_ex([1,2,3,4,5]) == 4
    assert Solution121_122_123_188_309_714.max_profit_ii_ex([7,6,4,3,1]) == 0
    assert Solution121_122_123_188_309_714.max_profit_ii_ex([7]) == 0
    assert Solution121_122_123_188_309_714.max_profit_ii_ex([]) == 0
  end

  test "Best Time to Buy and Sell Stock III" do
    assert Solution121_122_123_188_309_714.max_profit_iii([3,3,5,0,0,3,1,4]) == 6
    assert Solution121_122_123_188_309_714.max_profit_iii([1,2,3,4,5]) == 4
    assert Solution121_122_123_188_309_714.max_profit_iii([7,6,4,3,1]) == 0
    assert Solution121_122_123_188_309_714.max_profit_iii([7]) == 0
    assert Solution121_122_123_188_309_714.max_profit_iii([]) == 0
  end

  test "Best Time to Buy and Sell Stock IV" do
    assert Solution121_122_123_188_309_714.max_profit_iv(2, [2,4,1]) == 2
    assert Solution121_122_123_188_309_714.max_profit_iv(2, [3,2,6,7,5,0,3]) == 8
    assert Solution121_122_123_188_309_714.max_profit_iv(2, [3,2,6,5,0,3]) == 7
  end

  test "Best Time to Buy and Sell Stock with Cooldown" do
    assert Solution121_122_123_188_309_714.max_profit_with_hold([1,2,3,0,2]) == 3
    assert Solution121_122_123_188_309_714.max_profit_with_hold([1]) == 0
  end

  test "Best Time to Buy and Sell Stock with Transaction Fee" do
    assert Solution121_122_123_188_309_714.max_profit_after_fee([1,3,2,8,4,9], 2) == 8
    assert Solution121_122_123_188_309_714.max_profit_after_fee([1,3,7,5,10,3], 3) == 6
    assert Solution121_122_123_188_309_714.max_profit_after_fee([8,9,7,6,8,8], 2) == 0
  end


  @tag :skip
  test "Add Digits (recursion)" do
    assert Solution258_2544.add_digits(38) == 2
    assert Solution258_2544.add_digits(0) == 0
    assert Solution258_2544.add_digits(886995) == 9
    assert Solution258_2544.add_digits(1) == 1
  end

  test "Add Digits (digital root - Time complexity: O(1))" do
    assert Solution258_2544.add_digits_ii(38) == 2
    assert Solution258_2544.add_digits_ii(0) == 0
    assert Solution258_2544.add_digits_ii(886995) == 9
    assert Solution258_2544.add_digits_ii(1) == 1
  end

  test "Alternating Digit Sum" do
    assert Solution258_2544.alternate_digit_sum(521) == 4
    assert Solution258_2544.alternate_digit_sum(111) == 1
    assert Solution258_2544.alternate_digit_sum(886996) == 0
    assert Solution258_2544.alternate_digit_sum(885996) == -1
    assert Solution258_2544.alternate_digit_sum(886995) == 1
  end


  test "Advantage Shuffle" do
    assert Solution870.advantage_count([2,7,11,15], [1,10,4,11]) == [2,11,7,15]
    assert Solution870.advantage_count([12,24,8,32], [13,25,32,11]) == [24,32,8,12]
    assert Solution870.advantage_count([12,24,8], [13,25,32,11]) == []
  end


  test "Maximum Matrix Sum" do
    assert Solution1975.max_matrix_sum([[1,-1],[-1,1]]) == 4
    assert Solution1975.max_matrix_sum([[1,2,3],[-1,-2,-3],[1,2,3]]) == 16
  end


  test "Minimum Time to Type Word Using Special Typewriter" do
    assert Solution1974.min_time_to_type("abc") == 5
    assert Solution1974.min_time_to_type("bza") == 7
    assert Solution1974.min_time_to_type("zjpc") == 34
  end


  test "Check if Move is Legal" do
    {board, r_move, c_move, color} = {[[".",".",".","B",".",".",".","."],[".",".",".","W",".",".",".","."],[".",".",".","W",".",".",".","."],[".",".",".","W",".",".",".","."],["W","B","B",".","W","W","W","B"],[".",".",".","B",".",".",".","."],[".",".",".","B",".",".",".","."],[".",".",".","W",".",".",".","."]], 4, 3, "B"}
    assert Solution1958.check_move(board, r_move, c_move, color) == true
    {board, r_move, c_move, color} = {[[".",".",".",".",".",".",".","."],[".","B",".",".","W",".",".","."],[".",".","W",".",".",".",".","."],[".",".",".","W","B",".",".","."],[".",".",".",".",".",".",".","."],[".",".",".",".","B","W",".","."],[".",".",".",".",".",".","W","."],[".",".",".",".",".",".",".","B"]], 4, 4, "W"}
    assert Solution1958.check_move(board, r_move, c_move, color) == false
  end


  test "Count Number of Special Subsequences" do
    assert Solution1955.count_special_subsequences([0,1,2]) == 1
    assert Solution1955.count_special_subsequences([0,1,2,0]) == 1
    assert Solution1955.count_special_subsequences([0,1,2,2]) == 3
    assert Solution1955.count_special_subsequences([2,2,0,0]) == 0
    assert Solution1955.count_special_subsequences([0,1,2,0,1,2]) == 7
  end


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
