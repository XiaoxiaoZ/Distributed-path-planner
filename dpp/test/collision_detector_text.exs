defmodule CollisionDetectorTest do
    use ExUnit.Case
    import Collision.Detector

    test "two mesh collision test visulization" do

        points = [[0.0, 1.0, 0.0, -1.0, -0.5, 0.0, 0.0, -0.5, -1.0, 1.0, -0.5, 0.0], 
                  [0.0, 2.0, 0.0, -2.0, -1.0, 0.0, 0.0, -1.0, -2.0, 2.0, -1.0, 0.0]]
        indices = [[0, 1, 2, 0, 2, 3, 0, 3, 1],
                   [0, 1, 2, 0, 2, 3, 0, 3, 1]]
        translates = [[2.0, 2.0, 0.2],
                     [0.0, 0.0, 0.0]]
        rotates = [[0.0, 1.0, 0.0, 0.0],
                  [1.0, 0.0, 0.0, 0.0]]
        [point1 | [point2]] = points
        [indice1 | [indice2]] = indices
        [translate1 | [translate2]] = translates
        [rotate1 | [rotate2]] = rotates
        #assert collision_detect(point1,indice1, translate1, rotate1,point2,indice2, translate2, rotate2, 0.001) == 2
        draw(points,indices,translates,rotates)
    end
end