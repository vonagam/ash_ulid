defmodule AshUlid.MixProject do
  use Mix.Project

  @name :ash_ulid
  @version "0.2.1"
  @description "ULID type for Ash framework"
  @github_url "https://github.com/vonagam/ash_ulid"

  def project() do
    [
      app: @name,
      version: @version,
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      package: package(),
      deps: deps(),
      docs: docs(),
    ]
  end

  def application() do
    [extra_applications: [:logger]]
  end

  defp package() do
    [
      maintainers: ["Dmitry Maganov"],
      description: @description,
      licenses: ["MIT"],
      links: %{Github: @github_url},
      files: ~w(mix.exs lib .formatter.exs LICENSE.md  README.md),
    ]
  end

  defp deps() do
    [
      {:ash, ">= 2.14.3 and < 3.0.0"},
      {:ex_doc, "~> 0.16", only: :dev, runtime: false},
      {:dialyxir, "~> 1.3", only: :dev, runtime: false},
      {:benchfella, "~> 0.3.5", only: :dev, runtime: false},
      {:freedom_formatter, "~> 2.1", only: [:dev, :test], runtime: false},
    ]
  end

  def docs() do
    [
      homepage_url: @github_url,
      source_url: @github_url,
      source_ref: "v#{@version}",
      extras: [
        "README.md": [title: "Guide"],
        "LICENSE.md": [title: "License"],
      ],
      main: "readme",
    ]
  end
end
