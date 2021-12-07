defmodule ColladaImportTest do
    use ExUnit.Case
    import COLLADA
    import SweetXml
    import Map

    test "Import dae file" do
        {:ok, xmldoc} =import_robot("/test/irb6640.dae")
        XmlToMap.naive_map(xmldoc)
        end
end