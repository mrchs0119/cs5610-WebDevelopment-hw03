defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end


  def calc(expr) do
    expr
    |>String.split(~r/\s+/)
    |>convert([],[])
    |>eval([])
  end

  
  def isOperator(tok) do
    if (tok == "*" ||tok == "/" ||tok == "+" ||tok == "-") do
      true
    else
      false
    end
  end
 
  def operator_prec(tok) do
    cond do
      tok == "/" -> 2
      tok == "*" -> 2
      tok == "+" -> 1
      tok == "-" -> 1
      true -> 0 
    end
  end

  def checkElement(tok) do
    if (!isOperator(tok)) do
      parse_float(tok)
    else
      tok
    end
  end  

  def tag_tokens(list) do
    Enum.map(list, &checkElement/1)
  end

  def convert([lst_hd|lst_tl],result,temp) do
    if (!isOperator(lst_hd)) do
      convert(lst_tl,result ++ [lst_hd],temp)
    else
      if (length(temp) == 0 || operator_prec(hd(temp)) < operator_prec(lst_hd)) do
          convert(lst_tl,result,[lst_hd|temp])
      else
          convert([lst_hd|lst_tl],result ++ [hd(temp)],tl(temp))
      end
    end
  end


  def convert([],result,temp) do
    if(length(temp) == 0) do
      result
    else
      convert([],result ++ [hd(temp)],tl(temp))
    end
  end 


  def eval([lst_hd|lst_tl],result) do
    if(isOperator(lst_hd)) do
      x = hd(result)
      y = hd(tl(result))
      r = tl(tl(result))

      cond do
        lst_hd == "+" -> eval(lst_tl,[y + x |r])
	lst_hd == "-" -> eval(lst_tl,[y - x |r])
        lst_hd == "*" -> eval(lst_tl,[y * x |r])
        lst_hd == "/" -> eval(lst_tl,[y / x |r])
      end
    else
      eval(lst_tl,[parse_float(lst_hd)]++result)
    end
  end
  
  def eval([],result) do
    hd(result)
  end
end
