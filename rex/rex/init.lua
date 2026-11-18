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

-- Rex drops shift from alt+shift+<symbol>: the key arrives without usable
-- text, so the encoder falls back to the unshifted codepoint and M-> reaches
-- the program as M-. (ESC .). Send the shifted character explicitly. US layout.
local shifted = {
  ["`"] = "~", ["1"] = "!", ["2"] = "@", ["3"] = "#", ["4"] = "$",
  ["5"] = "%", ["6"] = "^", ["7"] = "&", ["8"] = "*", ["9"] = "(",
  ["0"] = ")", ["-"] = "_", ["="] = "+", ["["] = "{", ["]"] = "}",
  ["\\"] = "|", [";"] = ":", ["'"] = '"', [","] = "<", ["."] = ">",
  ["/"] = "?",
}
for base, char in pairs(shifted) do
  send("send_meta_" .. string.byte(char), "Send Meta " .. char,
    "alt+shift+" .. base, "\027" .. char)
end

rex.bind("alt+left", "pane.focus", { direction = "left" })
rex.bind("alt+right", "pane.focus", { direction = "right" })
rex.bind("alt+up", "pane.focus", { direction = "up" })
rex.bind("alt+down", "pane.focus", { direction = "down" })
rex.bind("ctrl+b>shift+'", "pane.split", { direction = "down" })
rex.bind("ctrl+b>shift+5", "pane.split", { direction = "right" })
rex.bind("ctrl+b>r", "client.config.reload")
rex.bind("ctrl+b>ctrl+b", "pane.send_key", { key = "ctrl+b" })
