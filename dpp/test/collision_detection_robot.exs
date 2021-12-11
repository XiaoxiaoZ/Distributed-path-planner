defmodule CollisionDetectionRobot do
    
    @moduledoc """
    Test build a robot and test
    """

    use ExUnit.Case
    import COLLADA
    import SweetXml
    import ROBOT.LINKS    
    import Collision.Detector
    
    

    test "Robot test" do

        

        geometries = File.read!("geometries.txt") |> :erlang.binary_to_term
        link_base = File.read!("link_base.txt") |> :erlang.binary_to_term
        link_1 = File.read!("link_1.txt") |> :erlang.binary_to_term
        link_2 = File.read!("link_2.txt") |> :erlang.binary_to_term
        link_3 = File.read!("link_3.txt") |> :erlang.binary_to_term
        link_4 = File.read!("link_4.txt") |> :erlang.binary_to_term
        link_5 = File.read!("link_5.txt") |> :erlang.binary_to_term
        link_6 = File.read!("link_6.txt") |> :erlang.binary_to_term

        robot_model = %{points: [], indices: [], translates: [], rotates: []}

        
        #points = geometries |> Enum.map(fn map -> map[:positions] end)
        #indices = geometries |> Enum.map(fn map -> map[:triangles] end)
        #translates = geometries |> Enum.map(fn map -> [:rand.uniform() * 5, :rand.uniform() * 5,:rand.uniform() * 5] end)
        #rotates = geometries |> Enum.map(fn map -> [:rand.uniform() * 5, :rand.uniform() * 5,:rand.uniform() * 5] end)
        names = geometries |> Enum.map(fn map -> map[:name] end)

        #draw([Enum.at(points,1)],[Enum.at(indices,1)],[[0.0,0.0,0.0]],[[0.0,0.0,0.0]])

        robot_model = add_link_to_robot_model_by_name(robot_model, geometries, names, link_base, 'gkmodel0_base_link_geom0', 0.0)
        robot_model = add_link_to_robot_model_by_name(robot_model, geometries, names, link_1, 'gkmodel0_link_1_geom0', :math.pi/6)
        robot_model = add_link_to_robot_model_by_name(robot_model, geometries, names, link_2, 'gkmodel0_link_2_geom0', :math.pi/6)
        robot_model = add_link_to_robot_model_by_name(robot_model, geometries, names, link_3, 'gkmodel0_link_3_geom0', :math.pi/6)
        robot_model = add_link_to_robot_model_by_name(robot_model, geometries, names, link_4, 'gkmodel0_link_4_geom0', :math.pi/6)
        robot_model = add_link_to_robot_model_by_name(robot_model, geometries, names, link_5, 'gkmodel0_link_5_geom0', :math.pi/6)
        robot_model = add_link_to_robot_model_by_name(robot_model, geometries, names, link_6, 'gkmodel0_link_6_geom0', :math.pi/6)

        points = robot_model[:points]
        indices = robot_model[:indices]
        translates = robot_model[:translates]
        rotates = robot_model[:rotates]



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