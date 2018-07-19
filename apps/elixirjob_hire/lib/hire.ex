defmodule ElixirJob.Hire do
  @moduledoc """
  Job hiring client. Use it to receive CVs and send mail to applicants.
  """

  use Application
  use AMQP
  alias Mailer.Email.Plain
  
  import ElixirJob.Util

  @app :elixirjob_hire

  def start(_type, _args) do
    IO.puts "Welcome to Elixir job hiring client!\n"

    Task.start(hire())
  end


  @doc """
    Process a job application
  """
  def process_application(payload, _props) do
    job_app = struct(JobApplication, Bson.decode(payload))

    IO.puts "New job application received:\n"
            <> "#{job_app}"

    if byte_size(job_app.file) > 0 do
      filename = "#{File.cwd!}/received_files/#{job_app.filename}"
      File.write filename, job_app.file
      IO.puts "CV file saved: #{filename}"
    end

    send_confirmation(job_app.email)
  end

  @doc """
    Send confirmation email to application
  """
  def send_confirmation(email) do
    from_address = Application.get_env(:mailer, :username)
    email = Mailer.compose_email(from: from_address,
      to:       email,
      subject:  "Job application confirmation",
      template: "welcome",
      data:     "hi")
    response = Mailer.send(email)
  end

  @doc """
    Main function - receive CV
  """
  def hire do

    IO.puts Application.get_env(:smtp_client, :server)

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

    # subcribe to queue
    IO.write "Subscribing to queue '#{queue}'... "
    Queue.subscribe chan, queue,
                    fn(payload,_props) ->
                      process_application(payload,_props)
                    end
    IO.puts "Done."

    Channel.close    chan
    Connection.close conn

    name  = userinput "\nWaiting for job applications. Hit Enter to exit\n"


  end

end
