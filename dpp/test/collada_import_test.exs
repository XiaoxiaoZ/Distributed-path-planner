defmodule ColladaImportTest do
    use ExUnit.Case
    import COLLADA
    import SweetXml
    import ROBOT

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

        frame_r = %{name: 'link_1',
                    frames: [%{rotate: '1 0 0 0', translate: '-0 -0 -0'}, 
                             %{rotate: '1 0 0 0', translate: '0 0 0.227'}, 
                             %{rotate: '1 0 0 0', translate: '0 0 0'}], 
                    rotate_axis: '0 0 1 0', 
                    rotate_axis_sid: 'node_joint_1_axis0'}
        assert link_1 == %{link_name: 'link_1', instance_geometry: '#gkmodel0_link_1_geom0', frame: frame_r, linked_links: ['link_2', 'link_cylinder']}
 
    end
    
    
    """

    
    test "link 2 test" do
        {:ok, xmldoc} =import_robot("/test/irb6640.dae")
        
        link_2 = get_link_2(xmldoc)

        frame_r = %{name: 'link_2',
                    frames: [%{rotate: '1 0 0 0', translate: '-0 -0 -0'}, 
                             %{rotate: '1 0 0 0', translate: '0 0 0.227'}, 
                             %{rotate: '1 0 0 0', translate: '0 0 0'}], 
                    rotate_axis: '0 0 1 0', 
                    rotate_axis_sid: 'node_joint_1_axis0'}
        assert link_2 == %{link_name: 'link_2', instance_geometry: '#gkmodel0_link_1_geom0', frame: frame_r, linked_links: ['link_2', 'link_cylinder']}
 
    end



end