defmodule GenServerDistributorTest do
    use ExUnit.Case
    test "GenServer test distributor" do
        data = [1,2,3,4,5,6]
        TaskManagerSupervisor.start_link(data)
        CollisionDetectorSupervisor.start_link(10)
        :timer.sleep(10)
        IO.inspect TaskManager.get_result
    end

end