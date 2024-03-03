defmodule AshUlid do
  @moduledoc """
  Helpers for working with ULIDs.
  """

  @typedoc """
  A Crockford Base32 encoded ULID string.
  """
  @type t :: <<_::208>>

  @typedoc """
  A raw binary representation of a ULID.
  """
  @type raw :: <<_::128>>

  @doc """
  Generate a Crockford Base32 encoded ULID string with current time.
  """
  @spec generate() :: t
  def generate() do
    {:ok, ulid} = AshUlid.Type.cast_stored(generate_binary(), nil)
    ulid
  end

  @doc """
  Generate a Crockford Base32 encoded ULID string with a provided Unix timestamp.
  """
  @spec generate(time :: non_neg_integer) :: t
  def generate(time) when is_integer(time) and time > -1 and time < 281_474_976_710_656 do
    {:ok, ulid} = AshUlid.Type.cast_stored(generate_binary(time), nil)
    ulid
  end

  @doc """
  Generate a binary ULID with current time.
  """
  @spec generate_binary() :: raw
  def generate_binary() do
    <<System.system_time(:millisecond)::unsigned-size(48), :crypto.strong_rand_bytes(10)::binary>>
  end

  @doc """
  Generate a binary ULID with a provided Unix timestamp.
  """
  @spec generate_binary(time :: non_neg_integer) :: raw
  def generate_binary(time) when is_integer(time) and time > -1 and time < 281_474_976_710_656 do
    <<time::unsigned-size(48), :crypto.strong_rand_bytes(10)::binary>>
  end
end
