defmodule COLLADA do

    # import robot(collada) to robot type 6 axies
    def import_robot(path) do
        {:ok, xmldoc} =File.read(Path.join(File.cwd!,path))
        #docmap = XmlToMap.naive_map(xmldoc)
        #robotmap = docmap["COLLADA"]["#content"]["library_visual_scenes"]["#content"]["visual_scene"]["#content"]["node"]
       #robot = %{name: robotmap["-name"]}
        #basemap = robotmap["#content"] 
        #baselink = %{name: basemap["name"],translate: basemap["node"]["#content"]["translate"], rotate: basemap["node"]["#content"]["rotate"]}
        
    end
    # import enviroment(collada) to enviroment type
    def import_env do
        
    end
end