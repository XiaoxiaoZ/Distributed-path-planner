defmodule ROBOT.LINKS do

    @moduledoc """
    Provide functions that import robot links
    """

    import SweetXml
    import ROBOT.UTILS
    alias ELA.Matrix, as: Matrix
    alias ELA.Vector, as: Vector


    @doc """
        Get base frame information in a Map
        TODO: develop information model for robot.
    ## Parameters

        - xmldoc: xml file readed

    ## Examples

        result = get_base_frame(xmldoc)

    """
    @spec get_base_frame(binary()) :: %{frames: List, 
                                        name: String, 
                                        rotate_axis: List, 
                                        rotate_axis_sid: Charlist}
    def get_base_frame(xmldoc) do
        result = xmldoc |> xpath(
            ~x"//library_visual_scenes/visual_scene",
            translates: ~x"./node/node/node[@name=\"base\"]/translate/text()"l,
            rotate_axis_sid: ~x"./node/node/node[@name=\"base\"]/rotate/@sid",
            rotates: ~x"./node/node/node[@name=\"base\"]/rotate/text()"l,
        )
        frame = convert_to_frame(result, "base")
    end


    @doc """
        Get base link information in a Map
        TODO: develop information model for robot.
    ## Parameters

        - xmldoc: xml file readed

    ## Examples

        result = get_base_link(xmldoc)

    """
    @spec get_base_link(binary()) :: %{link_name: Charlist,
                                       instance_geometry: Charlist, 
                                       frame: %{}, 
                                       linked_links: List}
    def get_base_link(xmldoc) do
        #result = xmldoc |> xpath(
         #   ~x"///library_visual_scenes/visual_scene",
        #    link_name: ~x"./node/node/@name",
        ##    instance_geometry: ~x"./node/node/instance_geometry/@url",
        #    translate: ~x"./node/node/translate/text()",
         #   rotate: ~x"./node/node/rotate/text()"
        link_name = 'base_link'
        
        link_base_path = get_link_path(link_name)

        result = get_link(xmldoc, link_base_path, link_name)

        frame = get_base_frame(xmldoc)

        link_base = %{link_name: result[:link_name], instance_geometry: result[:instance_geometry], frame: frame, linked_links: result[:linked_links]}
    
    end
    

    @doc """
        Get link_1 information and put it in a Map
        TODO: develop information model for robot.
    ## Parameters

        - xmldoc: xml file readed

    ## Examples

        iex> get_link_1(xmldoc)
        %{frame: 
            %{frames: 
                [%{rotate: [1.0, 0.0, 0.0, 0.0], translate: [0.0, 0.0, 0.0]}, 
                 %{rotate: [1.0, 0.0, 0.0, 0.0], translate: [0.0, 0.0, 0.227]}, 
                 %{rotate: [1.0, 0.0, 0.0, 0.0], translate: [0.0, 0.0, 0.0]}], 
              name: 'link_1', 
              rotate_axis: [0.0, 0.0, 1.0, 0.0], 
              rotate_axis_sid: 'node_joint_1_axis0'}, 
          instance_geometry: ['#gkmodel0_link_1_geom0'], 
          link_name: 'link_1', 
          linked_links: ['link_2', 'link_cylinder']}
    """
    @spec get_link_1(binary()) :: %{link_name: Charlist,
                                    instance_geometry: List, 
                                    frame: %{}, 
                                    linked_links: List}
    def get_link_1(xmldoc) do
        link_name = 'link_1'
        
        link_1_path = get_link_path(link_name)

        result = get_link(xmldoc, link_1_path, link_name)

        frame = get_link_frame(xmldoc, link_1_path, link_name)

        link_1 = %{link_name: result[:link_name], instance_geometry: result[:instance_geometry], frame: frame, linked_links: result[:linked_links]}
    end


    @doc """
    TODO: merge to get_link_n, after development of information model
    """
    def get_link_2(xmldoc) do
        link_name = 'link_2'
        link_2_path=get_link_path(link_name)
        result = get_link(xmldoc, link_2_path, link_name)
        frame = get_link_frame(xmldoc, link_2_path, link_name)
        link_2 = %{link_name: result[:link_name], instance_geometry: result[:instance_geometry], frame: frame, linked_links: result[:linked_links]}

    end
    @doc """
    TODO: merge to get_link_n, after development of information model
    """
    def get_link_3(xmldoc) do
        link_name = 'link_3'
        link_3_path = get_link_path(link_name)
        result = get_link(xmldoc, link_3_path, link_name)
        frame = get_link_frame(xmldoc, link_3_path, link_name)
        link_3 = %{link_name: result[:link_name], instance_geometry: result[:instance_geometry], frame: frame, linked_links: result[:linked_links]}
    end
    @doc """
    TODO: merge to get_link_n, after development of information model
    """
    def get_link_4(xmldoc) do
        link_name = 'link_4'
        link_4_path = get_link_path(link_name)
        result = get_link(xmldoc, link_4_path, link_name)
        frame = get_link_frame(xmldoc, link_4_path, link_name)
        link_4 = %{link_name: result[:link_name], instance_geometry: result[:instance_geometry], frame: frame, linked_links: result[:linked_links]}
    end
    @doc """
    TODO: merge to get_link_n, after development of information model
    """
    def get_link_5(xmldoc) do
        link_name = 'link_5'
        link_5_path = get_link_path(link_name)
        result = get_link(xmldoc, link_5_path, link_name)
        frame = get_link_frame(xmldoc, link_5_path, link_name)
        link_5 = %{link_name: result[:link_name], instance_geometry: result[:instance_geometry], frame: frame, linked_links: result[:linked_links]}
    end
    @doc """
    TODO: merge to get_link_n, after development of information model
    """
    def get_link_6(xmldoc) do
        link_name = 'link_6'
        link_6_path = get_link_path(link_name)
        result = get_link(xmldoc, link_6_path, link_name)
        frame = get_link_frame(xmldoc, link_6_path, link_name)
        link_6 = %{link_name: result[:link_name], instance_geometry: result[:instance_geometry], frame: frame, linked_links: result[:linked_links]}
    end

    def get_link_path(link) do
        link_base_name = 'base_link'
        link_1_name = 'link_1'
        link_2_name = 'link_2'
        link_3_name = 'link_3'
        link_4_name = 'link_4'
        link_5_name = 'link_5'
        link_6_name = 'link_6'
        link_base_path = %SweetXpath{path: '//library_visual_scenes/visual_scene/node'}
        link_1_path = %SweetXpath{path: '//library_visual_scenes/visual_scene/node/node'}
        link_2_path = %SweetXpath{path: '//library_visual_scenes/visual_scene/node/node/node[@name=\"'++link_1_name++'\"]'}
        link_3_path = %SweetXpath{path: '//library_visual_scenes/visual_scene/node/node/node[@name=\"'++link_1_name++'\"]/node[@name=\"'++link_2_name++'\"]'}
        link_4_path = %SweetXpath{path: '//library_visual_scenes/visual_scene/node/node/node[@name=\"'++link_1_name++'\"]/node[@name=\"'++link_2_name++'\"]/node[@name=\"'++link_3_name++'\"]'}
        link_5_path = %SweetXpath{path: '//library_visual_scenes/visual_scene/node/node/node[@name=\"'++link_1_name++'\"]/node[@name=\"'++link_2_name++'\"]/node[@name=\"'++link_3_name++'\"]/node[@name=\"'++link_4_name++'\"]'}
        link_6_path = %SweetXpath{path: '//library_visual_scenes/visual_scene/node/node/node[@name=\"'++link_1_name++'\"]/node[@name=\"'++link_2_name++'\"]/node[@name=\"'++link_3_name++'\"]/node[@name=\"'++link_4_name++'\"]/node[@name=\"'++link_5_name++'\"]'}
        link_paths = [
                        %{name: link_base_name, path: link_base_path},
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

    # Some funtions 


    def add_link_to_robot_model_by_name(robot_model, geometries, names, link, name, joint_value) do
        index = Enum.find_index(names,fn x-> x==name end) 
        points = robot_model[:points]
        indices = robot_model[:indices]
        translates = robot_model[:translates]
        rotates = robot_model[:rotates]
        new_points = List.insert_at(points, length(points),Enum.at(geometries,index)|>Map.fetch!(:positions))
        robot_model = %{robot_model | points: new_points}
        new_indices = List.insert_at(indices, length(indices),Enum.at(geometries,index)|>Map.fetch!(:triangles))
        robot_model = %{robot_model | indices: new_indices}
        
        tranf_temp = apply_joint(List.last(robot_model[:translates]),List.last(robot_model[:rotates]), get_trans_or_rot_from_link(link, :translate),get_trans_or_rot_from_link(link, :rotate), get_joint_from_link(link, joint_value))
        
        new_translates = List.insert_at(translates, length(translates),tranf_temp[:trans])
        
        
        robot_model = %{robot_model | translates: new_translates}
        new_rotates = List.insert_at(rotates, length(rotates),tranf_temp[:rot])
        robot_model = %{robot_model | rotates: new_rotates}
    end

    defp get_trans_or_rot_from_link(link, key) do
        link|>Map.fetch!(:frame)|>Map.fetch!(:frames)|>Enum.at(1)|>Map.fetch!(key)
    end

    defp get_joint_from_link(link, joint_value) do

        rot = link|>Map.fetch!(:frame)|>Map.fetch!(:rotate_axis)
        
        rot = List.replace_at(rot, 3,joint_value)

        rot
    end

    def add_two_list(old_trans, new_trans) do
        if old_trans do
            trans = new_trans|> Enum.with_index |> Enum.map(fn({x, i}) -> x + Enum.at(old_trans,i) end)
        else
            trans = new_trans
        end
    end

    def apply_joint(old_trans, old_rots, new_trans, new_rots, joint_vector) when old_trans==nil do

        apply_joint([0.0,0.0,0.0], [1.0,0.0,0.0,0.0], new_trans, new_rots, joint_vector)
    end

    def apply_joint(old_trans, old_rots, new_trans, new_rots, joint_vector) do

        
        old_mat = matrixFromAxisAngle(old_rots, old_trans)
        new_mat = matrixFromAxisAngle(new_rots, new_trans)
        joint_vector = matrixFromAxisAngle(joint_vector, [0.0,0.0,0.0])
        mat_temp = Matrix.mult(old_mat, new_mat)

        IO.inspect old_mat, label: "old_mat:"
        IO.inspect new_mat, label: "new_mat:"
        IO.inspect joint_vector, label: "joint_vector:"
        IO.inspect Matrix.mult(mat_temp, joint_vector), label: "muilt:"
        axisAngleFromMatrix(Matrix.mult(mat_temp, joint_vector))
    end
end