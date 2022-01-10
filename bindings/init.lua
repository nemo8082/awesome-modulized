require("awful.autofocus") -- Allow auto refocus when client closed

return {
   global = {
      key = require 'bindings.global.key',
      mouse = require 'bindings.global.mouse',
   },
   client = {
      key = require 'bindings.client.key',
      mouse = require 'bindings.client.mouse',
   },
   mod = require 'bindings.mod'
}
