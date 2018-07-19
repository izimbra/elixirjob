# ElixirJob

This is a toy Elixir application implementing a somewhat contrived use case
of applying for a job via the command line interface.

It is actually an umbrella project which includes 2 applications:
1. **elixirjob_apply** - used to send job applications
2. **[elixirjob_hire](/apps/elixirjob_hire)

created in order to learn the language's syntax,
and also try out following things:
* protocol implementation ([](apps/elixir_common/lib/jobapp.ex))
*


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add  to your list of dependencies in `mix.exs`:

        def deps do
          [{:, "~> 0.0.1"}]
        end

  2. Ensure  is started before your application:

        def application do
          [applications: [:]]
        end

