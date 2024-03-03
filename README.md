# AshUlid

[![Module Version](https://img.shields.io/hexpm/v/ash_ulid)](https://hex.pm/packages/ash_ulid)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen)](https://hexdocs.pm/ash_ulid/)
[![License](https://img.shields.io/hexpm/l/ash_ulid)](https://github.com/vonagam/ash_ulid/blob/master/LICENSE.md)

`Ash.Type` implementation for [ULID](https://github.com/ulid/spec).

Consists of three modules:

- `AshUlid` - utility functions to generate ULIDs.
- `AshUlid.Type` - `Ash.Type` implementation.
- `AshUlid.Extension` - `ulid_primary_key` shortcut.

## Installation

Add to the deps, get deps (`mix deps.get`), compile them (`mix deps.compile`).

```elixir
def deps do
  [
    {:ash_ulid, "~> 0.2.0"},
  ]
end
```

## Usage

### Primary key

To use as a primary key in `Ash.Resource` it is recommended to add `AshUlid.Extension` that provides `ulid_primary_key`:

```elixir
defmodule Example.Resource do
  use Ash.Resource,
    extensions: [AshUlid.Extension]

  attributes do
    ulid_primary_key :id
  end
end
```

Which is a shortcut for this:

```elixir
uuid_primary_key :id, type: AshUlid.Type, default: &AshUlid.generate/0
```

To prevent formatter from adding parens to `ulid_primary_key` add `:ash_ulid` to `import_deps` in `.formatter.exs`.

If you plan to use ULID as a main type for primary keys it makes sense to set it as `default_belongs_to_type` in a config:

```elixir
config :ash, default_belongs_to_type: AshUlid.Type
```

### Attribute type

`AshUlid.Type` can be registered under `ulid` name in a config:
```elixir
config :ash, custom_types: [ulid: AshUlid.Type]
```

And then used like this:
```elixir
defmodule Example.Another do
  use Ash.Resource

  attributes do
    attribute :key, :ulid
  end

  relationships do
    belongs_to :resource, Example.Resource, attribute_type: :ulid
  end
end
```

Without an alias it is the same, just replace `:ulid` with `AshUlid.Type`.

If `default_belongs_to_type` is set then `attribute_type: :ulid` in this example is not needed.

### Generate

To generate ULID call `AshUlid.generate/0` or `AshUlid.generate/1` with a specific timestamp.

## References

ULID spec can be found [here](https://github.com/ulid/spec).

The work is mostly based on [`Ecto.ULID`](https://github.com/TheRealReal/ecto-ulid).
