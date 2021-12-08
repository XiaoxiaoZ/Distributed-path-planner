defmodule CollisionDetectorTest do
    use ExUnit.Case
    import Collision.Detector

    test "list to list" do

        points = [0.0, 1.0, 0.0, -1.0, -0.5, 0.0, 0.0, -0.5, -1.0, 1.0, -0.5, 0.0]
        indices = [0, 1, 2, 0, 2, 3, 0, 3, 1]

        assert collision_detect(points,indices)== [ ]
    end
end