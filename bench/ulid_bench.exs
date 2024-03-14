defmodule AshUlid.Bench do
  use Benchfella

  bench "generate/0" do
    AshUlid.generate()
    nil
  end

  bench "generate_binary/0" do
    AshUlid.generate_binary()
    nil
  end

  bench "cast_input/2" do
    AshUlid.Type.cast_input("01C0M0Y7BG2NMB15VVVJH807F3", nil)
  end

  bench "dump_to_native/2" do
    AshUlid.Type.dump_to_native("01C0M0Y7BG2NMB15VVVJH807F3", nil)
  end

  bench "cast_stored/2" do
    AshUlid.Type.cast_stored(<<1, 96, 40, 15, 29, 112, 21, 104, 176, 151, 123, 220, 162, 128, 29, 227>>, nil)
  end
end
