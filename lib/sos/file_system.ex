defmodule FileSystem do

  def file_map(glob) do
    Path.wildcard(glob)
    |> Enum.reduce(%{}, fn(file, memo) -> Map.put(memo, file, File.stat!(file).mtime) end)
  end


end