defmodule Collision.Detector do
    use Rustler, otp_app: :dpp, crate: "collision_detector"

    # When your NIF is loaded, it will override this function.
    def collision_detect(_points1, _indices1, _points2, _indices2), do: :erlang.nif_error(:nif_not_loaded)
    def draw(_points_in , _indices_in), do: :erlang.nif_error(:nif_not_loaded)
end