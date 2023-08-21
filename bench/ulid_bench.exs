defmodule Ash.ULID.Bench do
  use Benchfella

  bench "generate/0" do
    Ash.ULID.generate()
    nil
  end

  bench "generate_binary/0" do
    Ash.ULID.generate_binary()
    nil
  end

  bench "cast_input/2" do
    Ash.Type.ULID.cast_input("01C0M0Y7BG2NMB15VVVJH807F3", nil)
  end

  bench "dump_to_native/2" do
    Ash.Type.ULID.dump_to_native("01C0M0Y7BG2NMB15VVVJH807F3", 2)
  end

  bench "cast_stored/2" do
    Ash.Type.ULID.cast_stored(<<1, 96, 40, 15, 29, 112, 21, 104, 176, 151, 123, 220, 162, 128, 29, 227>>, 2)
  end
end
