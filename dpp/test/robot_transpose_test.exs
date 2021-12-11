defmodule RobotTransposeTest do
    
    use ExUnit.Case
    import COLLADA
    import SweetXml
    import ROBOT.LINKS    
    import ROBOT.UTILS
    import Collision.Detector

    test "transform type conver" do
        matrix = matrixFromAxisAngle([0.0,1.0,0.0,60], [10.0,22.0,22.0]) 
        axisangle = axisAngleFromMatrix(matrix)
        #assert matrix==[[1.0, 0.0, 0.0, 10.0], [0.0, 0.5000000000000001, -0.8660254037844386, 22.0], [0.0, 0.8660254037844386, 0.5000000000000001, 22.0], [0.0, 0.0, 0.0, 1.0]]
        assert axisangle==[]
    end


end