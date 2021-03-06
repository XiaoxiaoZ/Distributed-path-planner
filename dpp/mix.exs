defmodule DPP.MixProject do
  use Mix.Project

  def project do
    [
      app: :dpp,
      version: "0.1.1",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger,:elixir_xml_to_map]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:sweet_xml, "~> 0.6.5"},
      {:elixir_xml_to_map, "~> 2.0"},
      {:rustler, "~> 0.22.2"},
      {:elixir_linear_algebra, "~> 1.0.0", hex: :ela},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Xiaoxiao Zhang"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/XiaoxiaoZ/Distributed-path-planner.git"}
    ]
  end

  defp description do
    """
    # DPP

    A Distributed Path Planner

    """
  end
  
end
