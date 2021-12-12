defmodule CollisionDetectionRobot do
    
    @moduledoc """
    Test build a robot and test
    """

    use ExUnit.Case
    import COLLADA
    import SweetXml
    import Robot.Links   
    import Collision.Detector
    import Robot.Joints
    
    

    test "Robot test" do

        joints = %Robot.Joints{joint1: :math.pi/2, joint2: :math.pi/6, joint3: :math.pi/6, joint4: :math.pi/6, joint5: -:math.pi/6, joint6: :math.pi/6}
        
        robot_model = get_robot_model_based_on_joint_value(joints)
        
        points = robot_model.points
        indices = robot_model.indices
        translates = robot_model.translates
        rotates = robot_model.rotates

        assert length(points)==7
        assert length(indices)==7
        assert length(translates)==7
        assert length(rotates)==7
        #assert translates==[]
        #assert indices==[]
        IO.inspect translates 
        IO.inspect rotates

        draw(points,indices,translates,rotates)
        
    end
    
end