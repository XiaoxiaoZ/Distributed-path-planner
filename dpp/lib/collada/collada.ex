defmodule COLLADA do
    import SweetXml
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


    def get_geometries(xmldoc) do
        result = xmldoc |> xpath(
            ~x'//library_geometries/geometry'l,
            name: ~x'./@id',
            positions: ~x'./mesh/source/float_array/text()'s,
            triangles: ~x'./mesh/triangles/p/text()'s,
            offset: ~x'./mesh/triangles/input/@offset'i,
            set: ~x'./mesh/triangles/input/@set'i
        )

        geometries = result 
        |> Enum.map(fn map -> 
                        pos_list = String.split(map[:positions]) 
                        pos_list_f = pos_list 
                                    |> Enum.map(fn s -> Float.parse(s) |> elem(0) end) 
                        map = %{map | positions: pos_list_f}
                        tri_list = String.split(map[:triangles])
                        tri_list_d = tri_list 
                                    |> Enum.map(fn s -> Integer.parse(s) |> elem(0) end) 
                        map = %{map | triangles: tri_list_d}
                    end)
    end
end