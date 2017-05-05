# RabbitMQ HTTP API 'Hello World' plugin

Shows how RabbitMQ HTTP API can be extended using a plugin written in Elixir.

This'll work only with RabbitMQ versions starting at ~3.7.0~.

## Running in an interactive mode

    make
    ERL_LIBS=./deps `# Add erlang.mk-built apps to code path` \
      iex --sname rabbit-mgmt-hello-world@localhost  \
      -S mix run \
      --no-start `# Our plugin will be started by rabbit plugin mechanism` \
      -e :rabbit.start `# With the help of config/dev.exs we are ready to start broker` \
      -e 'Application.start(:remix)' `# And we want our code-reloading too`
