defmodule Oalfred.Mixfile do
  use Mix.Project

  def project do
    [app: :oalfred,
     version: "0.0.1",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [applications: [:logger, :cowboy, :plug]]
  end

  defp deps do
    [ {:poison, "~> 2.2"},
      {:cowboy, "~> 1.0"},
      {:plug, "~> 1.2"}]
  end
end
