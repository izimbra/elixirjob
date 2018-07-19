defmodule ElixirJob.Apply.Mixfile do
  use Mix.Project

  def project do
    [app: :elixirjob_apply,
     version: "0.1.0",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.6",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:amqp, :asn1, :public_key, :ssl],
      mod: {ElixirJob.Apply, []}]
    #     [applications: [:logger]]
    #
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # To depend on another app inside the umbrella:
  #
  #   {:myapp, in_umbrella: true}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:elixirjob_common, in_umbrella: true},
      {:amqp,    "1.0.3"},
      {:cyanide, "0.5.0"}]
  end
end
