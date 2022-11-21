defmodule Terms.TermFormatter do
  @doc """
   {items: [item, item]}
   item -> {prompt": "a full body illustration of sexy female soldier holding a gun, at desert background, symmetrical facial feature, by artgerm, elegant, beautiful face, realistic body proportion",}
  """
  alias Terms.TermExtractor

  def get_terms() do
    case TermExtractor.fetch_open_art_info() do
      {:ok, response} -> parse_response(response)
      other -> other
    end
  end

  defp parse_response({:ok, %{"items" => items}}) do
    stream = Task.async_stream(items, fn item -> parse_terms(item) end)

    data = Enum.reduce(stream, %{}, fn {:ok, data}, acc ->
      concatenate_data(data, acc)
    end)

    data
    |> Map.put("words", Enum.uniq(data["words"]))
    |> Map.put("comma", Enum.uniq(data["comma"]))
  end

  defp parse_response(_), do: {:error, :format_error}

  defp parse_terms(%{"prompt" => terms}) do
    comma_task = Task.async(fn -> process_comma_terms(terms) end)
    word_task = Task.async(fn -> process_word_terms(terms) end)

    comma_terms = Task.await(comma_task)
    word_terms = Task.await(word_task)

    %{"comma" => Enum.uniq(comma_terms), "words" => Enum.uniq(word_terms), "original" => terms}
  end

  defp parse_terms(_), do: %{}

  defp concatenate_data(data, acc) when acc == %{} do
    %{
      "comma" => data["comma"],
      "words" => data["words"],
      "original" => [data["original"]],
    }
  end

  defp concatenate_data(data, acc) do
    new_words = data["words"] ++ acc["words"]
    new_comma = data["comma"] ++ acc["comma"]
    new_original =  [data["original"] | acc["original"]]

    acc
    |> Map.put("words", new_words)
    |> Map.put("comma", new_comma)
    |> Map.put("original", new_original)
  end

  defp process_comma_terms(terms), do: String.split(terms, ",")

  defp process_word_terms(terms) do
    terms
    |> String.replace(",", "")
    |> String.replace("\"", "")
    |> String.replace("\”", "")
    |> String.split()
  end
end
