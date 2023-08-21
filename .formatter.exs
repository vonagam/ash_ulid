locals_without_parens = [
  ulid_primary_key: 1,
  ulid_primary_key: 2,
]

[
  import_deps: [:ecto, :ecto_sql, :ash, :ash_postgres],
  subdirectories: ["priv/*/migrations"],
  plugins: [Spark.Formatter, FreedomFormatter],
  inputs: ["*.{heex,ex,exs}", "{config,lib,test}/**/*.{heex,ex,exs}", "priv/*/seeds.exs"],
  line_length: 120,
  trailing_comma: true,
  locals_without_parens: locals_without_parens,
  export: [locals_without_parens: locals_without_parens],
]
