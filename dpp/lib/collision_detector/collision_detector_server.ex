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
        :timer.sleep(1)
        #IO.puts "sdasdasd2222222222222222222222222222222222222222222222222222222222"
        TaskManager.recieve_result(task_id, task)
        {:noreply, state}
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