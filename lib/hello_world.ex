defmodule RabbitMQ.Plugin.HelloWorld do
  @behaviour :rabbit_mgmt_extension

  def dispatcher do
    [{"/hello-world", RabbitMQ.Plugin.HelloWorld.Handler, []}]
  end

  def web_ui do
    []
  end

  defmodule Handler do
    use RabbitMQ.Plugin.ManagementEndpoint
    def to_json(req, context) do
      {"hello world1", req, context}
    end
  end
end
