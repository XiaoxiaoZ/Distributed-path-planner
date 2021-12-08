defmodule Collision.Detector do
    use Rustler, otp_app: :dpp, crate: "collision_detector"

    # When your NIF is loaded, it will override this function.
    def collision_detect(_a, _b), do: :erlang.nif_error(:nif_not_loaded)
    def draw(), do: :erlang.nif_error(:nif_not_loaded)
end