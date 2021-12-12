defmodule Robot.Links.Server do
    @moduledoc """
    Robot model as a GenServer
    """

    use GenServer
    import Robot.Links
    import Collision.Detector
    # Client
    @doc """
    ## Example
        {:ok, pid} =Robot.Links.Server.start_link([])
    """
    def start_link(ops) do
        GenServer.start_link(__MODULE__, :ok, ops)
    end

    @doc """
    ## Example
        {:ok, pid} =Robot.Links.Server.start_link([])
        Robot.Links.Server.draw_default(pid)
    """
    def draw_default(pid) do
        GenServer.cast(pid, :draw_default)
    end
    @doc """
    ## Example
        {:ok, pid} =Robot.Links.Server.start_link([])
        joints = %Robot.Joints{joint1: :math.pi/2, joint2: 0.0, joint3: 0.0, joint4: :math.pi/2, joint5: 0.0, joint6: 0.0}
        robot_model = Robot.Links.Server.get_mesh_with_joints(pid, joints)
        Robot.Links.Server.draw(pid, robot_model)
    """
    def draw(pid, robot_model) do
        GenServer.cast(pid, {:draw, robot_model})
    end

    @doc """
    ## Example
        {:ok, pid} =Robot.Links.Server.start_link([])
        joints = %Robot.Joints{joint1: :math.pi/2, joint2: 0.0, joint3: 0.0, joint4: :math.pi/2, joint5: 0.0, joint6: 0.0}
        robot_model = Robot.Links.Server.get_mesh_with_joints(pid, joints)
    """
    def get_mesh_with_joints(pid, joints) do
        GenServer.call(pid, {:get_mesh_with_joints, joints})
    end

    # Server (callbacks)

    @impl true
     def init(_ops) do
        geometries = File.read!("geometries.txt") |> :erlang.binary_to_term
        link_base = File.read!("link_base.txt") |> :erlang.binary_to_term
        link_1 = File.read!("link_1.txt") |> :erlang.binary_to_term
        link_2 = File.read!("link_2.txt") |> :erlang.binary_to_term
        link_3 = File.read!("link_3.txt") |> :erlang.binary_to_term
        link_4 = File.read!("link_4.txt") |> :erlang.binary_to_term
        link_5 = File.read!("link_5.txt") |> :erlang.binary_to_term
        link_6 = File.read!("link_6.txt") |> :erlang.binary_to_term
        names = geometries |> Enum.map(fn map -> map[:name] end)
        {:ok, %{geometries: geometries, names: names, link_base: link_base, link_1: link_1, link_2: link_2, link_3: link_3, link_4: link_4, link_5: link_5, link_6: link_6}}
    end

    @impl true
    def handle_cast(:draw_default, state) do
        joints = %Robot.Joints{joint1: 0.0, joint2: 0.0, joint3: 0.0, joint4: 0.0, joint5: 0.0, joint6: 0.0}
        
        robot_model = %Robot.Mesh{points: [], indices: [], translates: [], rotates: []}

        robot_model = add_link_to_robot_model_by_name(robot_model, state[:geometries], state[:names], state[:link_base], 'gkmodel0_base_link_geom0', 0.0)
        robot_model = add_link_to_robot_model_by_name(robot_model, state[:geometries], state[:names], state[:link_1], 'gkmodel0_link_1_geom0', joints.joint1)
        robot_model = add_link_to_robot_model_by_name(robot_model, state[:geometries], state[:names], state[:link_2], 'gkmodel0_link_2_geom0', joints.joint2)
        robot_model = add_link_to_robot_model_by_name(robot_model, state[:geometries], state[:names], state[:link_3], 'gkmodel0_link_3_geom0', joints.joint3)
        robot_model = add_link_to_robot_model_by_name(robot_model, state[:geometries], state[:names], state[:link_4], 'gkmodel0_link_4_geom0', joints.joint4)
        robot_model = add_link_to_robot_model_by_name(robot_model, state[:geometries], state[:names], state[:link_5], 'gkmodel0_link_5_geom0', joints.joint5)
        robot_model = add_link_to_robot_model_by_name(robot_model, state[:geometries], state[:names], state[:link_6], 'gkmodel0_link_6_geom0', joints.joint6)
        
        points = robot_model.points
        indices = robot_model.indices
        translates = robot_model.translates
        rotates = robot_model.rotates

        #IO.inspect translates 
        #IO.inspect rotates

        draw(points,indices,translates,rotates)
        {:noreply, state}
    end

    @impl true
    def handle_cast({:draw, robot_model}, state) do
        points = robot_model.points
        indices = robot_model.indices
        translates = robot_model.translates
        rotates = robot_model.rotates

        #IO.inspect translates 
        #IO.inspect rotates

        draw(points,indices,translates,rotates)
        {:noreply, state}
    end


    @impl true
    def handle_call({:get_mesh_with_joints, joints}, _from, state) do
        
        robot_model = %Robot.Mesh{points: [], indices: [], translates: [], rotates: []}

        robot_model = add_link_to_robot_model_by_name(robot_model, state[:geometries], state[:names], state[:link_base], 'gkmodel0_base_link_geom0', 0.0)
        robot_model = add_link_to_robot_model_by_name(robot_model, state[:geometries], state[:names], state[:link_1], 'gkmodel0_link_1_geom0', joints.joint1)
        robot_model = add_link_to_robot_model_by_name(robot_model, state[:geometries], state[:names], state[:link_2], 'gkmodel0_link_2_geom0', joints.joint2)
        robot_model = add_link_to_robot_model_by_name(robot_model, state[:geometries], state[:names], state[:link_3], 'gkmodel0_link_3_geom0', joints.joint3)
        robot_model = add_link_to_robot_model_by_name(robot_model, state[:geometries], state[:names], state[:link_4], 'gkmodel0_link_4_geom0', joints.joint4)
        robot_model = add_link_to_robot_model_by_name(robot_model, state[:geometries], state[:names], state[:link_5], 'gkmodel0_link_5_geom0', joints.joint5)
        robot_model = add_link_to_robot_model_by_name(robot_model, state[:geometries], state[:names], state[:link_6], 'gkmodel0_link_6_geom0', joints.joint6)

        {:reply, robot_model, state}
    end

end