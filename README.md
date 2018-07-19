# ElixirJob

This is a toy Elixir application implementing a somewhat contrived use case
of applying for a job via the command line interface.

It is actually an umbrella project which includes 2 applications:
1. [elixirjob_apply](/apps/elixirjob_apply) - used to send job applications
2. [elixirjob_hire](/apps/elixirjob_hire) - used to received job applications and send confirmation emails

Some of the things I wanted to try:
* learn basics of the language syntax
* protocol implementation (see [jobapp.ex](/apps/elixirjob_common/lib/jobapp.ex))
* create an umbrella project in Mix
* retrieve application settings from a `config.exs` file
* encode/decode BSON data (using [cyanide](https://hex.pm/packages/cyanide))
* send and receive messages using RabbitMQ (using [amqp](https://hex.pm/packages/amqp))
* send emails (using [mailer](https://hex.pm/packages/mailer))



## Building & running

This project was last compiled using Elixir 1.6.6. However, due to the dependency **:ranch_proxy_protocol**
using the function `ssl:ssl_accept/3`, which was deprecated in the latest Erlang/OTP 21, you will need
to use Erlang/OTP 20 in order for the app to compile.

To build everything, do `mix deps.get && mix deps.compile --all && mix compile`

To run the individual application, do either `cd apps/elixirjob_apply && mix run` or `cd apps/elixirjob_hire && mix run`.



## Runtime dependencies

1. **RabbitMQ**

The applications need running a RabbitMQ instance with a specific binding.
The instance itself is configured in the
[/apps/elixirjob_apply/config/config.exs](/apps/elixirjob_apply/config/config.exs)
and [/apps/elixirjob_hire/config/config.exs](/apps/elixirjob_hire/config/config.exs). Currently the files
use the default `localhost` configuration.

To create the binding, you can run the `rabbitmq_binding.sh` script (`rabbitmqadmin` must be in yout PATH).


2. **SMTP server**

In order to send emails using the [mailer](https://hex.pm/packages/mailer) packag,
SMTP parameters must be provided in the file [/apps/elixirjob_hire/config/config.exs](/apps/elixirjob_hire/config/config.exs).
There is currently an example configuration for Gmail.
