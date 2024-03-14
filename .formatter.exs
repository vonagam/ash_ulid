locals_without_parens = [
  ulid_primary_key: 1,
  ulid_primary_key: 2,
]

[
  import_deps: [:ash],
  plugins: [Spark.Formatter, FreedomFormatter],
  inputs: ["*.{heex,ex,exs}", "{config,lib,test,bench}/**/*.{heex,ex,exs}"],
  line_length: 120,
  # freedom
  trailing_comma: true,
  local_pipe_with_parens: true,
  single_clause_on_do: true,
  # locals
  locals_without_parens: locals_without_parens,
  export: [locals_without_parens: locals_without_parens],
]
