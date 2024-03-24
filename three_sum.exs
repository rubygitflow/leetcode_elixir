# https://leetcode.com/problems/3sum/description/
# 15. 3Sum

defmodule Solution do
  @spec three_sum(nums :: [integer]) :: [[integer]]
  def three_sum(nums) do
    nums = Enum.sort(nums)
    # левый индекс
    nums_widx = Enum.with_index(nums)
    # IO.inspect(nums_widx)
    # правый индекс
    rnums_widx = Enum.reverse(nums_widx)
    # IO.inspect(rnums_widx)
    # результат
    output = MapSet.new()
    
    iter_i(nums_widx, rnums_widx, output)
    |> MapSet.to_list()
  end

  def iter_i([_i_head_idx | []], _rnums_widx, output) do
    # прерываем рекурсию при пустом хвосте левого индекса
    output
  end

  def iter_i([head_idx | tail], rnums_widx, output) do
    # отщипываем первое значение из левого индекса и
    # переходим к вычислению пары чисел из хвоста левого индекса и правого индекса
    output = iter_jk(head_idx , tail, rnums_widx, output)
    # заходим в рекурсию за новым набором триплета для
    # хвоста левого индекса
    iter_i(tail, rnums_widx, output)
  end

  def iter_jk(
    _i_head_idx,
    [{_j_head, j_idx} | _j_tail],
    [{_k_head, k_idx} | _k_tail],
    output
    ) when j_idx >= k_idx do
    # перехватываем пересечение левого индекса с правым
    output
  end

  def iter_jk(
    i_head_idx, 
    [j_head_idx | j_tail] = j_list,
    [k_head_idx | k_tail] = k_list,
    output
    ) do
    # достаём значения триплета
    {i_head, _i_idx} = i_head_idx
    {j_head, _j_idx} = j_head_idx
    {k_head, _k_idx} = k_head_idx
    # составляем триплет
    heads = [i_head, j_head, k_head]
    # вычисляем сумму триплета
    sum = Enum.sum(heads)

    cond do
      # проверяем условия для суммы триплета
      sum == 0 ->
        # дополняем множество результатов
        output = MapSet.put(output, heads)
        # заходим в рекурсию поиска пар из хвостов левого и правого индекса
        iter_jk(i_head_idx, j_tail, k_tail, output)
      sum > 0 ->
        # заходим в рекурсию поиска пар из левого индекса и хвоста правого индекса
        iter_jk(i_head_idx, j_list, k_tail, output)
      sum < 0 ->
        # заходим в рекурсию поиска пар из хвоста левого индекса и правого индекса
        iter_jk(i_head_idx, j_tail, k_list, output)
    end
  end
end

[-1,0,1,2,-1,-4] |> Solution.three_sum() |> IO.inspect()
# Output: [[-1,-1,2],[-1,0,1]]
[0,1,1] |> Solution.three_sum() |> IO.inspect()
# Output: []
[0,0,0] |> Solution.three_sum() |> IO.inspect()
# Output: [[0,0,0]]
