defmodule ElixirJob.Util do

  @doc """
    Promts user for input and returns it without trailing whitespaces
  """
  def userinput(prompt) do
    (IO.gets prompt) |> String.trim_trailing
  end

end
