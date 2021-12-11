defmodule Collision.Detector do
    use Rustler, otp_app: :dpp, crate: "collision_detector"

    # When your NIF is loaded, it will override this function.
    def collision_detect(_points1, _indices1, _translate1, _rotate1, _points2, _indices2, _translate2, _rotate2, _margin), do: :erlang.nif_error(:nif_not_loaded)
    def draw(_points_in , _indices_in, _translate_in, _rotate_in), do: :erlang.nif_error(:nif_not_loaded)
end