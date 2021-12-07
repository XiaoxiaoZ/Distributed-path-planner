defmodule ColladaImportTest do
    use ExUnit.Case
    import COLLADA
    import SweetXml

    test "Import dae file" do
        {:ok, xmldoc} =import_robot("/test/irb6640.dae")
        # get body text of all to-dos where the ID attribute is `1` as a list:

        result = xmldoc |> xpath(
            ~x"//library_visual_scenes/visual_scene/node/node"l,
            name: ~x"./@name",
            link_id: ~x"./@sid",
            link_translate: ~x"./translate/text()",
            link_rotate: ~x"./rotate/text()",
            geo_group_id: ~x"./node/@id"

            )
            assert result == [
  %{name: 'Match One', winner: %{name: 'Team One'}},
  %{name: 'Match Two', winner: %{name: 'Team Two'}},
  %{name: 'Match Three', winner: %{name: 'Team One'}}]

        end
end