defmodule AshUlid.Test do
  use ExUnit.Case, async: true

  @binary <<1, 95, 194, 60, 108, 73, 209, 114, 136, 236, 133, 115, 106, 195, 145, 22>>
  @encoded "01BZ13RV29T5S8HV45EDNC748P"

  describe "generate/0" do
    test "encodes milliseconds in first 10 characters" do
      # test case from ULID README: https://github.com/ulid/javascript#seed-time
      <<encoded::bytes-size(10), _rest::bytes-size(16)>> = AshUlid.generate(1_469_918_176_385)

      assert encoded == "01ARYZ6S41"
    end

    test "generates unique identifiers" do
      ulid1 = AshUlid.generate()
      ulid2 = AshUlid.generate()

      assert ulid1 != ulid2
    end
  end

  describe "generate_binary/0" do
    test "encodes milliseconds in first 48 bits" do
      now = System.system_time(:millisecond)
      <<time::48, _random::80>> = AshUlid.generate_binary()

      assert_in_delta now, time, 10
    end

    test "generates unique identifiers" do
      ulid1 = AshUlid.generate_binary()
      ulid2 = AshUlid.generate_binary()

      assert ulid1 != ulid2
    end
  end

  describe "cast_input/2" do
    test "returns valid ULID" do
      {:ok, ulid} = AshUlid.Type.cast_input(@encoded, nil)
      assert ulid == @encoded
    end

    test "returns ULID for encoding of correct length" do
      {:ok, ulid} = AshUlid.Type.cast_input("00000000000000000000000000", nil)
      assert ulid == "00000000000000000000000000"
    end

    test "returns error when encoding is too short" do
      assert AshUlid.Type.cast_input("0000000000000000000000000", nil) == :error
    end

    test "returns error when encoding is too long" do
      assert AshUlid.Type.cast_input("000000000000000000000000000", nil) == :error
    end

    test "returns error when encoding contains letter I" do
      assert AshUlid.Type.cast_input("I0000000000000000000000000", nil) == :error
    end

    test "returns error when encoding contains letter L" do
      assert AshUlid.Type.cast_input("L0000000000000000000000000", nil) == :error
    end

    test "returns error when encoding contains letter O" do
      assert AshUlid.Type.cast_input("O0000000000000000000000000", nil) == :error
    end

    test "returns error when encoding contains letter U" do
      assert AshUlid.Type.cast_input("U0000000000000000000000000", nil) == :error
    end

    test "returns error for invalid encoding" do
      assert AshUlid.Type.cast_input("$0000000000000000000000000", nil) == :error
    end

    test "returns error for value which is too big for uuid" do
      assert AshUlid.Type.cast_input("80000000000000000000000000", nil) == :error
    end
  end

  describe "dump_to_native/2" do
    test "dumps valid ULID to binary" do
      {:ok, bytes} = AshUlid.Type.dump_to_native(@encoded, nil)
      assert bytes == @binary
    end

    test "dumps encoding of correct length" do
      {:ok, bytes} = AshUlid.Type.dump_to_native("00000000000000000000000000", nil)
      assert bytes == <<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>>
    end

    test "returns error when encoding is too short" do
      assert AshUlid.Type.dump_to_native("0000000000000000000000000", nil) == :error
    end

    test "returns error when encoding is too long" do
      assert AshUlid.Type.dump_to_native("000000000000000000000000000", nil) == :error
    end

    test "returns error when encoding contains letter I" do
      assert AshUlid.Type.dump_to_native("I0000000000000000000000000", nil) == :error
    end

    test "returns error when encoding contains letter L" do
      assert AshUlid.Type.dump_to_native("L0000000000000000000000000", nil) == :error
    end

    test "returns error when encoding contains letter O" do
      assert AshUlid.Type.dump_to_native("O0000000000000000000000000", nil) == :error
    end

    test "returns error when encoding contains letter U" do
      assert AshUlid.Type.dump_to_native("U0000000000000000000000000", nil) == :error
    end

    test "returns error for invalid encoding" do
      assert AshUlid.Type.dump_to_native("$0000000000000000000000000", nil) == :error
    end

    test "returns error for value which is too big for uuid" do
      assert AshUlid.Type.dump_to_native("80000000000000000000000000", nil) == :error
    end
  end

  describe "cast_stored/2" do
    test "encodes binary as ULID" do
      {:ok, encoded} = AshUlid.Type.cast_stored(@binary, nil)
      assert encoded == @encoded
    end

    test "encodes binary of correct length" do
      {:ok, encoded} = AshUlid.Type.cast_stored(<<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>>, nil)
      assert encoded == "00000000000000000000000000"
    end

    test "returns error when data is too short" do
      assert AshUlid.Type.cast_stored(<<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>>, nil) == :error
    end

    test "returns error when data is too long" do
      assert AshUlid.Type.cast_stored(<<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>>, nil) == :error
    end
  end
end
