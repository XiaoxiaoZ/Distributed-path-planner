defmodule ColladaImportTest do
    use ExUnit.Case
    import SweetXml

    test "Import dae file" do
        {:ok, xmldoc} =File.read(Path.join(File.cwd!,"/test/IRB2400_10_150__02.dae"))
        # get body text of all to-dos where the ID attribute is `1` as a list:
        xmldoc |> xpath(~x"/COLLADA/asset/contributor/authoring_tool"l)

        # get the body text of all to-dos where a child node "priority" with the value `3` exists as a list:
        xmldoc |> xpath(~x"/todos/todo[priority=\"3\"]/body/text()"l)

        end
end