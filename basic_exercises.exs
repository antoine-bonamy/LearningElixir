defmodule Each do
  def forEach([head | tail], fun) do
    fun.(head)
    forEach(tail, fun)
  end

  def forEach([], _fun) do
    :ok
  end

  def test() do
    IO.puts("Test Module Each")
    forEach([], &IO.puts/1)
    forEach([1, 2, 3], &IO.puts/1)
    forEach([1, 2, 3], fn x -> IO.puts(x * x) end)
  end
end

defmodule Mapping do
  def map([head | tail], fun) do
    [fun.(head) | map(tail, fun)]
  end

  def map([], _fun) do
    []
  end

  def test() do
    IO.puts("Test module Mapping")
    IO.inspect(Mapping.map([1, 2, 3], &(&1 * &1)))
    IO.inspect(Mapping.map(["Salut", "Bonjour", "Bonsoir"], &String.upcase/1))
  end
end



defmodule Reduce do
  def reduce([head | tail], accumulator, fun) do
    reduce(tail, fun.(head, accumulator), fun)
  end

  def reduce([], accumulator, _fun) do
    accumulator
  end

  def test() do
    IO.puts("Test Module Reduce")
    IO.puts(reduce([1, 2, 3, 4], 0, &+/2))
    IO.puts(reduce([1, 2, 3, 4], 1, &*/2))
    IO.puts(reduce([], 0, &*/2))
  end
end

defmodule Search do
  def first_occurence([], _x) do
    nil
  end

  def first_occurence([head | tail], x) do
    first_occurence([head | tail], x, 0)
  end

  defp first_occurence([head | _tail], x, index) when head == x do
    index
  end

  defp first_occurence([_head | tail], x, index) do
    first_occurence(tail, x, index + 1)
  end

  defp first_occurence([], _x, _index) do
    nil
  end

  def test() do
    list = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
    IO.puts(first_occurence(list, 4))
    IO.puts(first_occurence(list, 1))
  end
end

defmodule Filter do
  def filter([head | tail], predicate) do
    if predicate.(head) do
      [head | filter(tail, predicate)]
    else
      filter(tail, predicate)
    end
  end

  def filter([], _predicate) do
    []
  end

  def test() do
    IO.puts("Test Module Filter")
    IO.inspect(filter([1, 2, 3, 4, 5], fn x -> rem(x, 2) == 0 end))
    IO.inspect(filter([], fn x -> rem(x, 2) == 0 end))

  end
end

defmodule MergeArray do
  def merge(list1 = [head1 | tail1], list2 =[head2 | tail2]) do
    if (head1 < head2) do
      [head1 | merge(tail1, list2)]
    else
      [head2 | merge(list1, tail2)]
    end
  end

  def merge([], list) do
    list
  end

  def merge(list, []) do
    list
  end

  def merge([], []) do
    []
  end

  def test() do
    IO.inspect(merge([1, 2, 3], [4, 5, 6]))
    IO.inspect(merge([1, 6, 7], [2, 4, 9]))
    IO.inspect(merge([1, 2, 3], [1, 2, 3]))
    IO.inspect(merge([1, 2, 3], [4, 5, 6, 7, 8]))
    IO.inspect(merge([1, 2, 3], []))
    IO.inspect(merge([], [4, 5, 6]))
    IO.inspect(merge([], []))
  end
end

defmodule Main do
  def main() do
    # Search.test()
    # Mapping.test()
    # Each.test()
    # Reduce.test()
    # Filter.test()
    MergeArray.test()
  end
end

Main.main()
