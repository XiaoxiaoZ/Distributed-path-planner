defmodule ROBOT.LINKS do
    import SweetXml


    def get_base_frame(xmldoc) do
        result = xmldoc |> xpath(
            ~x"//library_visual_scenes/visual_scene",
            translates: ~x"./node/node/node[@name=\"base\"]/translate/text()"l,
            rotate_axis_sid: ~x"./node/node/node[@name=\"base\"]/rotate/@sid",
            rotates: ~x"./node/node/node[@name=\"base\"]/rotate/text()"l
        )
        frame = convert_to_frame(result, "base")
    end

    def get_base_link(xmldoc) do
        result = xmldoc |> xpath(
            ~x"///library_visual_scenes/visual_scene",
            link_name: ~x"./node/node/@name",
            instance_geometry: ~x"./node/node/instance_geometry/@url",
            translate: ~x"./node/node/translate/text()",
            rotate: ~x"./node/node/rotate/text()"
        )
    end
    
    def get_link_1(xmldoc) do
        link_name = 'link_1'
        
        link_1_path = get_link_path(link_name)

        result = get_link(xmldoc, link_1_path, link_name)

        frame = get_link_frame(xmldoc, link_1_path, link_name)

        link_1 = %{link_name: result[:link_name], instance_geometry: result[:instance_geometry], frame: frame, linked_links: result[:linked_links]}
    end

    def get_link_2(xmldoc) do
        link_name = 'link_2'
        link_2_path=get_link_path(link_name)
        result = get_link(xmldoc, link_2_path, link_name)
        frame = get_link_frame(xmldoc, link_2_path, link_name)
        link_2 = %{link_name: result[:link_name], instance_geometry: result[:instance_geometry], frame: frame, linked_links: result[:linked_links]}

    end

    def get_link_3(xmldoc) do
        link_name = 'link_3'
        link_3_path = get_link_path(link_name)
        result = get_link(xmldoc, link_3_path, link_name)
        frame = get_link_frame(xmldoc, link_3_path, link_name)
        link_3 = %{link_name: result[:link_name], instance_geometry: result[:instance_geometry], frame: frame, linked_links: result[:linked_links]}
    end

    def get_link_4(xmldoc) do
        link_name = 'link_4'
        link_4_path = get_link_path(link_name)
        result = get_link(xmldoc, link_4_path, link_name)
        frame = get_link_frame(xmldoc, link_4_path, link_name)
        link_4 = %{link_name: result[:link_name], instance_geometry: result[:instance_geometry], frame: frame, linked_links: result[:linked_links]}
    end

    def get_link_5(xmldoc) do
        link_name = 'link_5'
        link_5_path = get_link_path(link_name)
        result = get_link(xmldoc, link_5_path, link_name)
        frame = get_link_frame(xmldoc, link_5_path, link_name)
        link_5 = %{link_name: result[:link_name], instance_geometry: result[:instance_geometry], frame: frame, linked_links: result[:linked_links]}
    end

    def get_link_6(xmldoc) do
        link_name = 'link_6'
        link_6_path = get_link_path(link_name)
        result = get_link(xmldoc, link_6_path, link_name)
        frame = get_link_frame(xmldoc, link_6_path, link_name)
        link_6 = %{link_name: result[:link_name], instance_geometry: result[:instance_geometry], frame: frame, linked_links: result[:linked_links]}
    end

    def get_link_path(link) do
        link_1_name = 'link_1'
        link_2_name = 'link_2'
        link_3_name = 'link_3'
        link_4_name = 'link_4'
        link_5_name = 'link_5'
        link_6_name = 'link_6'
        link_1_path = %SweetXpath{path: '//library_visual_scenes/visual_scene/node/node'}
        link_2_path = %SweetXpath{path: '//library_visual_scenes/visual_scene/node/node/node[@name=\"'++link_1_name++'\"]'}
        link_3_path = %SweetXpath{path: '//library_visual_scenes/visual_scene/node/node/node[@name=\"'++link_1_name++'\"]/node[@name=\"'++link_2_name++'\"]'}
        link_4_path = %SweetXpath{path: '//library_visual_scenes/visual_scene/node/node/node[@name=\"'++link_1_name++'\"]/node[@name=\"'++link_2_name++'\"]/node[@name=\"'++link_3_name++'\"]'}
        link_5_path = %SweetXpath{path: '//library_visual_scenes/visual_scene/node/node/node[@name=\"'++link_1_name++'\"]/node[@name=\"'++link_2_name++'\"]/node[@name=\"'++link_3_name++'\"]/node[@name=\"'++link_4_name++'\"]'}
        link_6_path = %SweetXpath{path: '//library_visual_scenes/visual_scene/node/node/node[@name=\"'++link_1_name++'\"]/node[@name=\"'++link_2_name++'\"]/node[@name=\"'++link_3_name++'\"]/node[@name=\"'++link_4_name++'\"]/node[@name=\"'++link_5_name++'\"]'}
        link_paths = [
                        %{name: link_1_name, path: link_1_path},
                        %{name: link_2_name, path: link_2_path},
                        %{name: link_3_name, path: link_3_path},
                        %{name: link_4_name, path: link_4_path},
                        %{name: link_5_name, path: link_5_path},
                        %{name: link_6_name, path: link_6_path}
                     ]
        link_paths
        |> Enum.find(fn map -> map[:name] == link end)
        |> Map.fetch!(:path)
    end

    def get_link(xmldoc, link_path, link_name) do
        link_name_path = %SweetXpath{path: './node[@name=\"'++link_name++'\"]/@name'}
        instance_geometry_path = %SweetXpath{path: './node[@name=\"'++link_name++'\"]/instance_geometry/@url', is_list: true}
        linked_links_path = %SweetXpath{path: './node[@name=\"'++link_name++'\"]/node/@name', is_list: true}
        result = xmldoc |> xpath(
            link_path,
            link_name: link_name_path,
            instance_geometry: instance_geometry_path,
            linked_links: linked_links_path
        )
    end

    def get_link_frame(xmldoc, link_path, link_name) do
        translates_path = %SweetXpath{path: './node[@name=\"'++link_name++'\"]/translate/text()', is_list: true}
        rotate_axis_sid_path = %SweetXpath{path: './node[@name=\"'++link_name++'\"]/rotate/@sid'}
        rotates_path = %SweetXpath{path: './node[@name=\"'++link_name++'\"]/rotate/text()', is_list: true}
        result = xmldoc |> xpath(
            link_path,
            translates: instance_geometry_path = translates_path,
            rotate_axis_sid: rotate_axis_sid_path,
            rotates: rotates_path
        )
        frame = convert_to_frame(result, link_name)
    end

    def get_tool_frame do
        
    end

    # Update your robot cad with configuration 
    def update_conf(joints) do
        
    end

    
    def convert_to_frame(xmlresult,name) do
        [t1 | t] = xmlresult[:translates]
        [t2 | [t3]] = t
        [r1 | r] = xmlresult[:rotates]
        [r2 | r_] = r
        [r3 | [r4]] = r_

        
        frame = %{name: name,
                  rotate_axis_sid: xmlresult[:rotate_axis_sid], 
                  frames: [%{translate: charlist_to_flist(t1), rotate: charlist_to_flist(r1)}, 
                           %{translate: charlist_to_flist(t2), rotate: charlist_to_flist(r2)}, 
                           %{translate: charlist_to_flist(t3), rotate: charlist_to_flist(r4)}],
                  rotate_axis: charlist_to_flist(r3)
                           }
    end

    def charlist_to_flist(charlist) do
        pos_list_f = String.split(to_string(charlist))
                        |> Enum.map(fn s -> Float.parse(s) |> elem(0) end) 
    end
end