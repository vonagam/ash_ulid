# Ash.ULID

[![Module Version](https://img.shields.io/hexpm/v/ash_ulid)](https://hex.pm/packages/ash_ulid)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen)](https://hexdocs.pm/ash_ulid/)
[![License](https://img.shields.io/hexpm/l/ash_ulid)](https://github.com/vonagam/ash_ulid/blob/master/LICENSE.md)

`Ash.Type` implementation for [ULID](https://github.com/ulid/spec).

Consists of three modules:

- `Ash.ULID` - utility functions to generate ULIDs.
- `Ash.Type.ULID` - `Ash.Type` implementation.
- `Ash.ULID.Extension` - `ulid_primary_key` shortcut.

## Installation

Add to the deps, get deps (`mix deps.get`), compile them (`mix deps.compile`).

```elixir
def deps do
  [
    {:ash_uuid, "~> 0.1"},
  ]
end
```

## Usage

### Primary key

To use as a primary key in `Ash.Resource` it is recommended to add `Ash.ULID.Extension`:

```elixir
defmodule Example.Resource do
  use Ash.Resource,
    extensions: [Ash.ULID.Extension]

  attributes do
    ulid_primary_key :id
  end
end
```

Which is a shortcut for this:

```elixir
uuid_primary_key :id, type: Ash.Type.ULID, default: &Ash.ULID.generate/0
```

### Attribute type

`Ash.Type.ULID` can be registered under `ulid` name in a config:
```elixir
config :ash, custom_types: [ulid: Ash.Type.ULID]
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

Without an alias it is the same, just replace `:ulid` with `Ash.Type.ULID`.

### Generate

To generate ULID call `Ash.ULID.generate/0` or `Ash.ULID.generate/1` with a specific timestamp.

## References

ULID spec can be found [here](https://github.com/ulid/spec).

The work is mostly based on [`Ecto.ULID`](https://github.com/TheRealReal/ecto-ulid).
