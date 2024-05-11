defmodule AshUlid.Resource do
  @moduledoc """
  Ash resource extension which adds `ulid_primary_key` to `attributes` section.
  """

  @ulid_primary_key_schema Ash.Resource.Attribute.uuid_primary_key_schema()
                           |> Spark.Options.Helpers.set_default!(:type, AshUlid.Type)
                           |> Spark.Options.Helpers.set_default!(:default, &AshUlid.generate/0)

  @ulid_primary_key %Spark.Dsl.Entity{
    name: :ulid_primary_key,
    describe: """
    Declares a non writable, non-nil, primary key column of type ulid, which defaults to `AshUlid.generate/0`.

    Accepts all the same options as `d:Ash.Resource.Dsl.attributes.attribute`, except for `allow_nil?`, but it sets
    the following different defaults:

    ```elixir
      writable? false
      public? true
      default &AshUlid.generate/0
      primary_key? true
      type AshUlid.Type
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
