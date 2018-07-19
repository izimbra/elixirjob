defmodule ElixirJob.Apply do
  @moduledoc """
  Job application client. Use it to apply for job.
  """

  use Application
  use AMQP

  import ElixirJob.Util

  @app :elixirjob_apply

#  def start(_type, _args) do
#    Task.start(hello())
#  end
#
#  def hello do
#    ["Hello, ", :red, :bright, "world!"]
#    |> IO.ANSI.format
#    |> IO.puts
#
#    # connection parameters
#    [host, user, pwd, queue, xchg] = Enum.map(
#      [:host, :username, :password, :queue, :exchange],
#      fn(key) -> Application.get_env(@app, key) end)
#
#    # connect to RabbitMQ
#    conn_string = "amqp://#{user}:#{pwd}@#{host}"
#    IO.write "Connecting to RabbitMQ instance: #{conn_string}... "
#    {:ok, conn} = Connection.open conn_string
#    {:ok, chan} = Channel.open conn
#    IO.puts "Done.\n"
#
#    IO.write "Subscribing to queue '#{queue}'... "
#    Queue.subscribe chan, queue,
#                    fn(payload,_meta) ->
#                      job_app = struct(JobApplication, Bson.decode(payload))
#                      IO.puts "New message on the '#{queue}'! Received:\n"
#                              <> "#{job_app}"
#                      if byte_size(job_app.file) > 0 do
#                        File.write "#{File.cwd!}/files2/_#{job_app.filename}",
#                                   job_app.file
#                      end
#                    end
#    IO.puts "Done."
#
#  end

  def start(_type, _args) do
    IO.puts "Welcome to Elixir job application client!\n"

    Task.start(apply())
  end


  @doc """
    Main function - apply for a job
  """
  def apply do

    # connection parameters
    [host, user, pwd, queue, xchg] = Enum.map(
      [:host, :username, :password, :queue, :exchange],
      fn(key) -> Application.get_env(@app, key) end)

    # connect to RabbitMQ
    conn_string = "amqp://#{user}:#{pwd}@#{host}"
    IO.write "Connecting to RabbitMQ instance: #{conn_string}... "
    {:ok, conn} = Connection.open conn_string
    {:ok, chan} = Channel.open conn
    IO.puts "Done.\n"

    # get user input for job application
    name  = userinput "\nPlease enter your name:\n"
    email = userinput "\nPlease enter your email:\n"

    filename = "#{File.cwd!}/"
    <> (userinput "\nPlease enter relative path to your CV file\n" <>
                  "(current folder is '#{File.cwd!}'):\n")

    IO.write "Reading file '#{filename}'... "
    file = File.read! filename #"#{File.cwd!}/" <> String.rstrip(filename)
    IO.puts "Done."

    # create structure and parse
    job_app = %JobApplication{name: name, email: email,
      filename: Path.basename(filename), file: file}

    job_app_bson = Bson.encode(Map.from_struct(job_app))

    # publish to exchange
    IO.puts "\nPublishing to exchange '#{xchg}':\n#{job_app}"
    Basic.publish chan, xchg, "", job_app_bson

    Channel.close    chan
    Connection.close conn

  end

end
