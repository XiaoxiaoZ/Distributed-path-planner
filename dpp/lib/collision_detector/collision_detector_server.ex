defmodule Collision.Detector.Server do
    @moduledoc """
    Collision detector server
    """
    use GenServer

    def start_link([]) do
        GenServer.start_link(__MODULE__, [])
    end

    def send_result(pid, task_id, task) do
        GenServer.cast(pid, {:send_result, task_id, task})
    end

    @impl true
    def init(_ops) do
        TaskManager.request_task(self())
        {:ok, nil}
    end
    @impl true
    def handle_cast({:send_result, task_id, task}, state) do
        TaskManager.request_task(self())
## add code here
##
        if task_id==:empty_task do
          #IO.puts "Empty"
          {:noreply, state}
        else
          result = Distributor.Server.test_fun(task)
          #:timer.sleep(1)
          IO.inspect task_id
        
          TaskManager.recieve_result(task_id, result)
          {:noreply, state}
        end
    end

end

defmodule CollisionDetectorSupervisor do
  use Supervisor
  def start_link(num_detector) do
    Supervisor.start_link(__MODULE__, num_detector) 
  end
  def init(num_detector) do
    workers = Enum.map(1..num_detector, fn(n) -> 
      worker(Collision.Detector.Server, [[]], id: "Detector#{n}")
    end)
    supervise(workers, strategy: :one_for_one)
  end
end