defmodule ColladaImportTest do
    use ExUnit.Case
    import COLLADA
    import SweetXml
    import ROBOT.LINKS


@doc """




    test "Base link import" do
        {:ok, xmldoc} =import_robot("/test/irb6640.dae")
        result = get_base_link(xmldoc)
        assert result == %{link_name: 'base_link', instance_geometry: '#gkmodel0_base_link_geom0', rotate: '1 0 0 0', translate: '0 0 0'}
    end

    test "Base frame" do
        {:ok, xmldoc} =import_robot("/test/irb6640.dae")
        frame = get_base_frame(xmldoc)
        assert frame == %{name: "base", frames: [%{rotate: '1 0 0 0', translate: '-0 -0 -0'}, %{rotate: '1 0 0 0', translate: '0 0 0'}, %{rotate: '1 0 0 0', translate: '0 0 0'}], rotate_axis: 
'0 0 0 0', rotate_axis_sid: 'node_base_link-base_axis0'}
        #assert result2 == %{base_frame: 'base'}
    end



    test "link 1 test" do
        {:ok, xmldoc} =import_robot("/test/irb6640.dae")
        
        link_1 = get_link_1(xmldoc)

        assert link_1 == %{frame: %{frames: [%{rotate: '1 0 0 0', translate: '-0 -0 -0'}, %{rotate: '1 0 0 0', translate: '0 0 0.227'}, %{rotate: '1 0 0 0', translate: '0 0 0'}], name: 'link_1', rotate_axis: '0 0 1 0', rotate_axis_sid: 'node_joint_1_axis0'}, instance_geometry: ['#gkmodel0_link_1_geom0'], link_name: 'link_1', linked_links: ['link_2', 'link_cylinder']}
    end
     
    test "link 2 test" do
        {:ok, xmldoc} =import_robot("/test/irb6640.dae")
        
        link_2 = get_link_2(xmldoc)

        assert link_2 == %{frame: %{frames: [%{rotate: '1 0 0 0', translate: '-0 -0 -0'}, %{rotate: '1 0 0 0', translate: '0.322 0.03 0.551'}, %{rotate: '1 0 0 0', translate: '0 0 0'}], name: 'link_2', rotate_axis: '0 1 0 0', rotate_axis_sid: 'node_joint_2_axis0'}, instance_geometry: ['#gkmodel0_link_2_geom0'], link_name: 'link_2', linked_links: ['link_3']}
    end

    test "link 3 test" do
        {:ok, xmldoc} =import_robot("/test/irb6640.dae")
        
        link_3 = get_link_3(xmldoc)

        assert link_3 == %{frame: %{frames: [%{rotate: '1 0 0 0', translate: '-0 -0 -0'}, %{rotate: '1 0 0 0', translate: '0 -0.2 1.07'}, %{rotate: '1 0 0 0', translate: '0 0 0'}], name: 'link_3', rotate_axis: '0 1 0 0', rotate_axis_sid: 'node_joint_3_axis0'}, instance_geometry: ['#gkmodel0_link_3_geom0'], link_name: 'link_3', linked_links: ['link_4']}
 
    end


    test "link 4 test" do
        {:ok, xmldoc} =import_robot("/test/irb6640.dae")
        
        link_4 = get_link_4(xmldoc)

        assert link_4 == %{frame: %{frames: [%{rotate: '1 0 0 0', translate: '-0 -0 -0'}, %{rotate: '1 0 0 0', translate: '-0.275 0.181 0.2'}, %{rotate: '1 0 0 0', translate: '0 0 0'}], name: 'link_4', rotate_axis: '1 0 0 0', rotate_axis_sid: 'node_joint_4_axis0'}, instance_geometry: ['#gkmodel0_link_4_geom0'], link_name: 'link_4', linked_links: ['link_5']}
    end

    
    test "link 5 test" do
        {:ok, xmldoc} =import_robot("/test/irb6640.dae")
        
        link_5 = get_link_5(xmldoc)

        assert link_5 == %{frame: %{frames: [%{rotate: '1 0 0 0', translate: '-0 -0 -0'}, %{rotate: '1 0 0 0', translate: '1.67 0 0'}, %{rotate: '1 0 0 0', translate: '0 0 0'}], name: 'link_5', rotate_axis: '0 1 0 0', rotate_axis_sid: 'node_joint_5_axis0'}, instance_geometry: ['#gkmodel0_link_5_geom0'], link_name: 'link_5', linked_links: ['link_6']}  

    end


    test "link 6 test" do
        {:ok, xmldoc} =import_robot("/test/irb6640.dae")
        
        link_6 = get_link_6(xmldoc)

        assert link_6 == %{frame: %{frames: [%{rotate: [1, 0, 0, 0], translate: [-0, -0, -0]}, %{rotate: [1, 0, 0, 0], translate: [0.153, 0, 0]}, %{rotate: [1, 0, 0, 0], translate: [0, 0, 0]}], name: 'link_6', rotate_axis: [1, 0, 0, 0], rotate_axis_sid: 'node_joint_6_axis0'}, instance_geometry: ['#gkmodel0_link_6_geom0'], link_name: 'link_6', linked_links: ['tool0']}  
    end





    test "Geometry import test" do
        {:ok, xmldoc} =import_robot("/test/irb6640.dae")
        geometries = get_geometries(xmldoc)
        

        assert Enum.count(geometries) == 9
        [head|tail] = geometries
        assert head[:offset] == 0
        assert head[:set] == 0
        [first | rest] = head[:positions]
        is_integer(first) == true
    end


        """
end