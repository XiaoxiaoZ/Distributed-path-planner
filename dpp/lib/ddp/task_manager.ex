defmodule TaskManager do

    # TODO1: Need to make it so that the impot is the LIST format, funtion to distribute and also an empty list format


    use GenServer

    def start_link(collision_data) do
        GenServer.start_link(__MODULE__, collision_data, name: {:global, :task_manager})
    end

    def request_task(pid) do
        GenServer.cast({:global, :task_manager},{:request_task, pid})
    end

    def recieve_result(task_id, result) do
        GenServer.cast({:global, :task_manager},{:recieve_result, task_id, result})
    end

    def get_result do
        GenServer.call({:global, :task_manager}, {:get_result})
    end

    def add_task(collision_data) do
        GenServer.cast({:global, :task_manager},{:add_task, collision_data})
    end

    @impl true
    def init(collision_data) do
        {:ok, {collision_data, Map.new(), MapSet.new(),Map.new()}}
    end

    @impl true
    def handle_cast({:add_task, new_collision_data}, {collision_data, pending, done_tasks, results}) do
        {:noreply, {List.flatten([new_collision_data | collision_data]), pending, done_tasks, results}}
    end

    @impl true
    def handle_cast({:request_task, pid}, {collision_data, pending, done_tasks, results}) do
        {task , new_collision_data} = cond do
            Enum.empty?(collision_data) ->
                {nil, []}
            true -> 
                [task | new_collision_data] = collision_data
                {task , new_collision_data}
        end
        new_pending = send_result(pid, pending, task)
        {:noreply, {new_collision_data, new_pending, done_tasks, results}}
    end

    @impl true
    def handle_cast({:recieve_result, task_id, result}, {collision_data, pending, done_tasks, results}) do
        cond do
            MapSet.member?(done_tasks, task_id) ->
                {:noreply, {collision_data, pending, done_tasks, results}}  
            true ->
                new_done_tasks = MapSet.put(done_tasks, task_id)
                new_pending = Map.delete(pending, task_id)
                new_results = Map.put(results, task_id, result)
                {:noreply, {collision_data, new_pending, new_done_tasks, new_results}}
        end
    end

    @impl true
    def handle_call({:get_result}, _from, {collision_data, pending, done_tasks, results}) do
        {:reply, results,  {collision_data, pending, done_tasks, results}}
    end


  defp send_result(pid, pending, task) when is_nil(task) do
    if Enum.empty?(pending) do
      pending # Nothing to do
    else
    #TODO: this empty LIST need to be a argument impot!!!!!
      empty_task = %{point1: [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0], indice1: [0,1,2], translate1: [0.0,0.0,0.0], rotate1: [0.0,0.0,0.0,0.0], point2: [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0], indice2: [0,1,2], translate2: [0.0,0.0,0.0], rotate2: [0.0,0.0,0.0,0.0], margin: 0.1}
      {task_id, prev_task} ={:empty_task, empty_task}
      Collision.Detector.Server.send_result(pid, task_id, prev_task)
      Map.put(Map.delete(pending, task_id), task_id, prev_task)
    end
  end


  defp send_result(pid, pending, task) do
      task_id = make_ref()
      Collision.Detector.Server.send_result(pid, task_id, task)
      Map.put(pending, task_id, task)
  end
end

defmodule TaskManagerSupervisor do
  use Supervisor

  def start_link(collision_data) do
    Supervisor.start_link(__MODULE__, collision_data)
  end

  def init(collision_data) do
    workers = [worker(TaskManager, [collision_data])]
    supervise(workers, strategy: :one_for_one)
  end
end