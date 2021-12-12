defmodule Robot.Link do
    @moduledoc """
    Robot Link struct

    name: '', rotate_axis_sid: '', frames: [], rotate_axis: []
    """
    defstruct link_name: '', instance_geometry: [], frame: %Robot.Frame{}, linked_links: []
end