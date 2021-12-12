defmodule GenServerLinksTest do
    use ExUnit.Case
    test "Links GenServer test" do
        {:ok, pid} =Robot.Links.Server.start_link([])
        joints = %Robot.Joints{joint1: :math.pi/2, joint2: 0.0, joint3: 0.0, joint4: :math.pi/2, joint5: 0.0, joint6: 0.0}
        robot_model = Robot.Links.Server.get_mesh_with_joints(pid, joints)
        Robot.Links.Server.draw(pid, robot_model)
    end

    test "draw default robot" do
        {:ok, pid} =Robot.Links.Server.start_link([])
        Robot.Links.Server.draw_default(pid)
    end
end


