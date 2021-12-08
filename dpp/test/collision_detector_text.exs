defmodule CollisionDetectorTest do
    use ExUnit.Case
    import Rust.Test

    test "greets the world" do
        assert add([1.23,2.2,3.0],[5.02,23.4,23.1])== []
    end
end