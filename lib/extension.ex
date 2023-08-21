defmodule Ash.ULID.Extension do
  @moduledoc """
  `Spark.Dsl.Extension` which adds `ulid_primary_key` to `attributes` section of `Ash.Resource`.
  """

  @ulid_primary_key_schema Ash.Resource.Attribute.uuid_primary_key_schema()
                           |> Spark.OptionsHelpers.set_default!(:type, Ash.Type.ULID)
                           |> Spark.OptionsHelpers.set_default!(:default, &Ash.ULID.generate/0)

  @ulid_primary_key %Spark.Dsl.Entity{
    name: :ulid_primary_key,
    describe: """
    Declares a non writable, non-nil, primary key column of type ulid, which defaults to `Ash.ULID.generate/0`.

    Accepts all the same options as `d:Ash.Resource.Dsl.attributes.attribute`, except for `allow_nil?`, but it sets
    the following different defaults:

    ```elixir
      writable? false
      default &Ash.ULID.generate/0
      primary_key? true
      generated? true
      type Ash.Type.ULID
    ```
    """,
    examples: [
      "ulid_primary_key :id",
    ],
    args: [:name],
    target: Ash.Resource.Attribute,
    schema: @ulid_primary_key_schema,
    auto_set_fields: [allow_nil?: false],
    transform: {Ash.Resource.Attribute, :transform, []},
  }

  @attributes_patch %Spark.Dsl.Patch.AddEntity{section_path: [:attributes], entity: @ulid_primary_key}

  use Spark.Dsl.Extension, dsl_patches: [@attributes_patch]
end
