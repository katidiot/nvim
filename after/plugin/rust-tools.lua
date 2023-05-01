local opts = {
    -- debugging stuff
--    dap = {
--        adapter = {
--            name = "codelldb",
--            type = "server",
--            port = "${port}",
--            executable = {
--                command = "codelldb",
--                args = {"--port", "${port}"},
--            }
--        },
--    },
}

require('rust-tools').setup(opts)
