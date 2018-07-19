# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure for your application as:
#
     config :elixirjob_hire,
       host:     "localhost",
       username: "guest",
       password: "guest",
       queue:    "hire_queue",
       exchange: "apply_exchange" #"hire_exchange"
#
# And access this configuration in your application as:
#
#     Application.get_env(:elixirjob_apply, :key)
#
# Or configure a 3rd-party app:
#
#     config :logger, level: :info
#

     config :mailer, :smtp_client,
       server:    "smtp.gmail.com",
       username:  "YOUR_USERNAME@gmail.com",
       password:  "YOUR_APP_PASSWORD", #https://myaccount.google.com/apppasswords
       transport: :smtp,
       ssl:       :true,
       tls:       :if_available,
       port:      465

     config :mailer,
       templates: "priv/templates"
       

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env}.exs"
