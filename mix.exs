defmodule RabbitMQ.Plugin.Prometheus.Mixfile do
  use Mix.Project

  def project do
    deps_dir = case System.get_env("DEPS_DIR") do
      nil -> "deps"
      dir -> dir
    end
    [app: :rabbitmq_management_hello_world,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps_path: deps_dir,
     deps: deps(deps_dir, Mix.env),
     aliases: aliases()
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [applications: [:logger, :rabbit, :rabbitmq_management],
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps(deps_dir, :dev) do
    [{:remix, git: "https://github.com/AgilionApps/remix", branch: "master"}] ++ deps(deps_dir, :all)
  end
  defp deps(deps_dir, _all) do
    [
      {
        :rabbit_common,
        path: Path.join(deps_dir, "rabbit_common"),
        compile: "true",
        override: true
      },
      {
        :rabbitmq_management,
        path: Path.join(deps_dir, "rabbitmq_management"),
        compile: "true",
        override: true
      },
      {
        :rabbitmq_management_agent,
        path: Path.join(deps_dir, "rabbitmq_management_agent"),
        compile: "true",
        override: true
      },
      {
        :rabbit,
        path: Path.join(deps_dir, "rabbit"),
        compile: "true",
        override: true
      },
    ]
  end

  defp aliases do
    [
      make_deps: [
        "deps.get",
        "deps.compile",
      ],
      make_app: [
        "compile",
      ],
      make_all: [
        "deps.get",
        "deps.compile",
        "compile",
      ],
    ]
  end
end
