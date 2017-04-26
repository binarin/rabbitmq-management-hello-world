PROJECT = rabbitmq_management_hello_world

DEPS = rabbit_common rabbit rabbitmq_management rabbitmq_management rabbitmq_management_agent
TEST_DEPS = rabbitmq_ct_helpers rabbitmq_ct_client_helpers

DEP_PLUGINS = rabbit_common/mk/rabbitmq-plugin.mk

elixir_srcs := mix.exs \
               $(shell find config lib -name "*.ex" -o -name "*.exs")

app:: $(elixir_srcs) deps
	$(MIX) make_all

# FIXME: Use erlang.mk patched for RabbitMQ, while waiting for PRs to be
# reviewed and merged.

ERLANG_MK_REPO = https://github.com/rabbitmq/erlang.mk.git
ERLANG_MK_COMMIT = rabbitmq-tmp

include rabbitmq-components.mk
include erlang.mk
