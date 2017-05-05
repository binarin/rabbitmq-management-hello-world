use Mix.Config

# Make RabbitMQ include our plugin in its startup process. Plugin
# handling is heavily file-based, so we are going to create some
# helper files in "tmp" directory.
File.mkdir "./tmp"

# Request this plugin startup during :rabbit.start/0 initialization sequence
File.write! './tmp/enabled-plugins-file', "[rabbitmq_management_hello_world]."
config :rabbit, enabled_plugins_file: './tmp/enabled-plugins-file'

# Treat both 'mix'- and 'erlang.mk'-built apps as plugin candidates.
config :rabbit, plugins_dir: './deps:./_build/dev/lib'

# Needed until https://github.com/rabbitmq/rabbitmq-server/pull/1210
config :rabbit, plugins_expand_dir: './tmp/plugins-expand-dir'

# Needed until https://github.com/AgilionApps/remix/issues/15
config :remix, paths: ["lib"]
