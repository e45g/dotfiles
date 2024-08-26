require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd

local function sed(from, to, fname)
  vim.cmd(string.format("silent !sed -i 's/%s/%s/g' %s", from, to, fname))
end

local function liveReload_xresources()
  vim.cmd "silent !xrdb -merge ~/.Xresources"
  vim.cmd "silent !kill -USR1 $(xprop -id $(xdotool getwindowfocus) | grep '_NET_WM_PID' | grep -oE '[[:digit:]]*$')"
end

autocmd("VimLeavePre", {
  callback = function()
    sed("st.borderpx: 0", "st.borderpx: 20", "~/.Xresources")
    liveReload_xresources()
  end,
})
