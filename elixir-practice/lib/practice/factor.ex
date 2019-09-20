defmodule Practice.Factor do
  
  def parse_int(x) when is_integer(x) do
    x
  end

  def parse_int(text) do
    case Integer.parse(text) do
      {num, _} -> num
      _ -> 0
    end
  end
  
  def factor(x) do
    if x == "" do
      "Please enter a number"
    else 
      x = parse_int(x)
      if x <= 1 do
        "Enter a number > 1"
      else
        factor(parse_int(x), [])
      end
    end
  end

  def factor(x, lst) do
    if x == 1 do
      lst
    else
      y = factor_one(x, 2)
      factor(div(x, y), lst ++ [Integer.to_string(y)])
    end
  end

  def factor_one(x, div) do
    if div == x do
      x
    else
      if rem(x, div) == 0 do
        div
      else
        factor_one(x, div + 1)
      end
    end
  end
end
