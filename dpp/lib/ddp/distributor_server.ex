defmodule Distributor.Server do
  @moduledoc """
  A server to distribute tasks to calculation servers.
  """

# def is_there_a_22(a) do
#  Enum.any?(a, fn(item) -> item == "22" end.)
#end

def test_fun(data) do
  point1 = data[:point1]
  indice1 = data[:indice1]
  translate1 = data[:translate1]
  rotate1 = data[:rotate1]
  point2 = data[:point2]
  indice2 = data[:indice2]
  translate2 = data[:translate2]
  rotate2 = data[:rotate2]
  margin = data[:margin]
  result = Collision.Detector.collision_detect(point1, indice1, translate1, rotate1,point2,indice2, translate2, rotate2, margin)
  IO.puts result
  result == 2
end


def map( task_data, task_fun) do 
   parent = self() 
    processes = Enum.map(task_data, 
                            fn(e) -> spawn_link( 
                              fn() -> send(parent, {self(), task_fun.(e)}) 
                             end) 
                            end)
    Enum.any?( processes, 
                fn(pid) -> receive do {^pid, result} -> result 
                                    end
                end) 
    end
end
