defmodule Elixir.Mixfile do
  use Mix.Project

  def project do
    [
      app: :elixir,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      preferred_cli_env: [espec: :test],
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:mix_test_watch, "~> 0.8", only: :dev, runtime: false}
      # {:espec, "~> 1.4.4", only: :test},
    ]
  end
end
