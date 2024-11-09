return {
    -- {
    --     'pocco81/auto-save.nvim',
    --     config = function()
    --         require("auto-save").setup {
    --             enabled = false,
    --             execution_message = {
    --                 message = function() return "AutoSave: saved at " .. os.date("%H:%M:%S") end,
    --                 dim = 0.18, -- Dim the message after this many seconds
    --             },
    --             events = {"InsertLeave"}, -- Events that trigger auto-save
    --             conditions = {
    --                 exists = true, -- Only save if the file exists
    --                 filetype_is_not = { "png", "jpg", "jpeg", "gif", "bmp", "svg", "webp", "pdf", "zip", "tar", "gz", "exe", "bin" },
    --                 filename_is_not = {}, -- List of filenames to ignore
    --             },
    --             write_all_buffers = false, -- Write all buffers when saving
    --             on_before_save = function() end, -- Function to run before saving
    --         }
    --     end
    -- },
}
