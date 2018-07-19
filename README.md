# ElixirJob

This is a toy Elixir application implementing a somewhat contrived use case
of applying for a job via the command line interface.

It is actually an umbrella project which includes 2 applications:
1. [elixirjob_apply](/apps/elixirjob_apply) - used to send job applications
2. [elixirjob_hire](/apps/elixirjob_hire) - used to received job applications and send confirmation emails

Some of the things I wanted to try:
* create an umbrella project in Mix
* created in order to learn the language's syntax,
and also try out following things:
* protocol implementation (see [jobapp.ex](/apps/elixir_common/lib/jobapp.ex))
*


## Building & running

This project was last compiled using Elixir 1.6.6. However, due to the dependency **:ranch_proxy_protocol**
using the function `ssl:ssl_accept/3`, which was deprecated in the latest Erlang/OTP 21, you will need
to use Erlang/OTP 20 in order for the app to compile.


Due to one of the dependencies

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add  to your list of dependencies in `mix.exs`:

        def deps do
          [{:, "~> 0.0.1"}]
        end

  2. Ensure  is started before your application:

        def application do
          [applications: [:]]
        end

