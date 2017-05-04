defmodule RabbitMQ.Plugin.ManagementEndpoint do
  defmacro __using__(_opts) do
    quote do
      require Record
      Record.defrecord :context, :'context', Record.extract(:'context', from_lib: "rabbitmq_management_agent/include/rabbit_mgmt_records.hrl")

      def init(_, _, _) do
        {:upgrade, :protocol, :cowboy_rest}
      end

      def rest_init(req, _config) do
        {:ok, :rabbit_mgmt_cors.set_headers(req, __MODULE__), context()}
      end

      def variances(req, context) do
        {["accept-encoding", "origin"], req, context}
      end

      def content_types_provided(req, context) do
        {:rabbit_mgmt_util.responder_map(:to_json), req, context}
      end

      def is_authorized(req, context) do
        :rabbit_mgmt_util.is_authorized(req, context)
      end

      defoverridable [init: 3,
                      rest_init: 2,
                      variances: 2,
                      content_types_provided: 2,
                      is_authorized: 2]
    end
  end
end
