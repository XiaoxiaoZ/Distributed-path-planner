defmodule COLLADA do
    import SweetXml
    # import robot(collada) to robot type 6 axies
    def import_robot(path) do
        {:ok, xmldoc} =File.read(Path.join(File.cwd!,path))
        
    end
    # import enviroment(collada) to enviroment type
    def import_env do
        
    end
end