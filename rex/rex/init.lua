-- Ports the text keybinds from ghostty/ghostty/config. Lua 5.1 has no \x
-- escapes, so the bytes are written in decimal.
local function send(name, title, key, bytes)
  rex.action{
    name = name,
    title = title,
    category = "Terminal",
    run = function(ctx, args)
      rex.block.call("com.superlogical.terminal", "write", { data = bytes })
    end,
  }
  rex.bind(key, name)
end

send("send_cr", "Send Return", "ctrl+m", "\r")
send("send_tab", "Send Tab", "ctrl+i", "\t")
send("send_esc", "Send Escape", "ctrl+[", "\027")
send("send_esc_cr", "Send Escape Return", "shift+enter", "\027\r")
send("send_esc_del", "Send Escape Delete", "ctrl+backspace", "\027\127")
