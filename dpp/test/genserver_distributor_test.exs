defmodule GenServerDistributorTest do
    use ExUnit.Case
    test "GenServer test distributor" do

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

        margin = 0.001

        obj_points = points
        obj_indices = indices
        obj_translates = translates
        obj_rotates = rotates

        {:ok, pid} =Robot.Links.Server.start_link([])   
        joints = %Robot.Joints{joint1: :math.pi/2, joint2: 0.0, joint3: 0.0, joint4: :math.pi/2, joint5: 0.0, joint6: 0.0}
        robot_model = Robot.Links.Server.get_mesh_with_joints(pid, joints)
        
        rob_points = robot_model.points
        rob_indices = robot_model.indices
        rob_translates = robot_model.translates
        rob_rotates = robot_model.rotates


        data_temp = Enum.with_index(obj_points, fn obj, index -> %{point1: Enum.at(obj_points,index), indice1: Enum.at(obj_indices,index), translate1: Enum.at(obj_translates,index), rotate1: Enum.at(obj_rotates,index), point2: Enum.at(rob_points,0), indice2: Enum.at(rob_indices,0), translate2: Enum.at(rob_translates,0), rotate2: Enum.at(rob_rotates,0), margin: margin} end)
        data1 = [data_temp]
        data_temp = Enum.with_index(obj_points, fn obj, index -> %{point1: Enum.at(obj_points,index), indice1: Enum.at(obj_indices,index), translate1: Enum.at(obj_translates,index), rotate1: Enum.at(obj_rotates,index), point2: Enum.at(rob_points,1), indice2: Enum.at(rob_indices,1), translate2: Enum.at(rob_translates,1), rotate2: Enum.at(rob_rotates,1), margin: margin} end)
        data1 = [data_temp | data1]
        data_temp = Enum.with_index(obj_points, fn obj, index -> %{point1: Enum.at(obj_points,index), indice1: Enum.at(obj_indices,index), translate1: Enum.at(obj_translates,index), rotate1: Enum.at(obj_rotates,index), point2: Enum.at(rob_points,2), indice2: Enum.at(rob_indices,2), translate2: Enum.at(rob_translates,2), rotate2: Enum.at(rob_rotates,2), margin: margin} end)
        data1 = [data_temp | data1]
        data_temp = Enum.with_index(obj_points, fn obj, index -> %{point1: Enum.at(obj_points,index), indice1: Enum.at(obj_indices,index), translate1: Enum.at(obj_translates,index), rotate1: Enum.at(obj_rotates,index), point2: Enum.at(rob_points,3), indice2: Enum.at(rob_indices,3), translate2: Enum.at(rob_translates,3), rotate2: Enum.at(rob_rotates,3), margin: margin} end)
        data1 = [data_temp | data1]
        data_temp = Enum.with_index(obj_points, fn obj, index -> %{point1: Enum.at(obj_points,index), indice1: Enum.at(obj_indices,index), translate1: Enum.at(obj_translates,index), rotate1: Enum.at(obj_rotates,index), point2: Enum.at(rob_points,4), indice2: Enum.at(rob_indices,4), translate2: Enum.at(rob_translates,4), rotate2: Enum.at(rob_rotates,4), margin: margin} end)
        data1 = [data_temp | data1]
        data_temp = Enum.with_index(obj_points, fn obj, index -> %{point1: Enum.at(obj_points,index), indice1: Enum.at(obj_indices,index), translate1: Enum.at(obj_translates,index), rotate1: Enum.at(obj_rotates,index), point2: Enum.at(rob_points,5), indice2: Enum.at(rob_indices,5), translate2: Enum.at(rob_translates,5), rotate2: Enum.at(rob_rotates,5), margin: margin} end)
        data1 = [data_temp | data1]
        data_temp = Enum.with_index(obj_points, fn obj, index -> %{point1: Enum.at(obj_points,index), indice1: Enum.at(obj_indices,index), translate1: Enum.at(obj_translates,index), rotate1: Enum.at(obj_rotates,index), point2: Enum.at(rob_points,6), indice2: Enum.at(rob_indices,6), translate2: Enum.at(rob_translates,6), rotate2: Enum.at(rob_rotates,6), margin: margin} end)
        data1 = [data_temp | data1]
        data1 = List.flatten(data1)
        data = [1,2,3,4,5,6]
        TaskManagerSupervisor.start_link(data1)
        CollisionDetectorSupervisor.start_link(10)
        :timer.sleep(50000)
        TaskManager.add_task(data1)
        :timer.sleep(3000)
        TaskManager.remove_all_tasks()
        :timer.sleep(100000)
        IO.inspect TaskManager.get_result
    end

end