require("user-settings.options")   -- core options should come first
require("user-settings.keymaps")   -- key mappings next, they rely on options sometimes
require("user-settings.commands")  -- autocmds or custom commands
require("user-settings.plugins")   -- plugin manager and plugin configs come last

