defmodule AshUlid.MixProject do
  use Mix.Project

  @name :ash_ulid
  @version "1.0.0"
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
      aliases: aliases(),
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
      {:ash, "~> 3.0"},
      {:ex_doc, "~> 0.32", only: :dev, runtime: false},
      {:dialyxir, "~> 1.4", only: :dev, runtime: false},
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
        "documentation/dsls/DSL:-AshUlid.Resource.md": [title: "DSL: AshUlid.Resource"],
        "LICENSE.md": [title: "License"],
      ],
      main: "readme",
    ]
  end

  defp aliases() do
    [
      docs: ["spark.cheat_sheets", "docs", "spark.replace_doc_links", "spark.cheat_sheets_in_search"],
      "spark.cheat_sheets": "spark.cheat_sheets --extensions AshUlid.Resource",
      "spark.cheat_sheets_in_search": "spark.cheat_sheets_in_search --extensions AshUlid.Resource",
      "spark.formatter": ["spark.formatter --extensions AshUlid.Resource", "format .formatter.exs"],
    ]
  end
end
