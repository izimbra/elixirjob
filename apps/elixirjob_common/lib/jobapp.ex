defmodule JobApplication do

  defstruct [:name, :email, :filename, :file] 

  defimpl Inspect, for: JobApplication do
    def inspect(job_app, _) do
      "---------------------------------------------" <>
      "\nJob application:" <>
      "\nFrom: " <> job_app.name <>
      "\nEmail: " <> job_app.email <>
      "\nEnclosed CV file: " <> job_app.filename <> 
      "\n---------------------------------------------\n"
    end
  end

  defimpl String.Chars, for: JobApplication do
    def to_string(job_app) do
      inspect(job_app,[])
    end
  end

end
