defmodule Rocketpay.Numbers do
  def sum_from_file(filename) do
    # file = File.read("#{filename}.csv")

    # Isso abaixo é o pattern matching
    # O conteúdo do arquivo ficará gravado no file (se :ok)
    # = é operador de MATCH, não de ATRIBUIÇÃO
    # {:ok, file} = File.read("#{filename}.csv")
    "#{filename}.csv"
    |> File.read()
    |> handle_file()

    # Sem pipe operator
    # file = File.read("#{filename}.csv")
    # handle_file(file)
  end

  defp handle_file({:ok, result}) do
    # Com pipe operators
    result =
      result
      |> String.split(",")
      |> Stream.map(fn number -> String.to_integer(number) end)
      |> Enum.sum()

    # Sem pipe operator
    # result = String.split(result, ",")
    # result = Enum.map(result, fn number -> String.to_integer(number) end)
    # result = Enum.sum(result)

    {:ok, %{result: result}}
  end

  # O reason não importa para este match
  # Testar no IEX > Rocketpay.Numbers.sum_from_file("aaa")
  defp handle_file({:error, _reason}), do: {:error, %{message: "Invalid File"}}
end
