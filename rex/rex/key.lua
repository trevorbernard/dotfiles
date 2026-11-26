-- Ports the navigation and window/pane creation keys from tmux/.tmux.conf,
-- plus the tmux defaults that file relied on. A tmux window is a Rex tab.
local prefix = "ctrl+b>"

for _, direction in ipairs({ "left", "right", "up", "down" }) do
  rex.bind("alt+" .. direction, "pane.focus", { direction = direction })
  rex.bind(prefix .. direction, "pane.focus", { direction = direction })
end
rex.bind(prefix .. "o", "pane.focus_next")
-- Rex has no last-pane or last-tab action. Navigate Back walks one focus
-- history across tabs and sessions, so it stands in for both ; and l.
rex.bind(prefix .. ";", "client.navigate.back")

-- " and % on a US layout: bindings match on the unshifted key.
rex.bind(prefix .. "shift+'", "pane.split", { direction = "down" })
rex.bind(prefix .. "shift+5", "pane.split", { direction = "right" })
rex.bind(prefix .. "x", "pane.close")

rex.bind(prefix .. "c", "client.tab.new")
rex.bind(prefix .. "n", "client.tab.next")
rex.bind(prefix .. "p", "client.tab.previous")
rex.bind(prefix .. "l", "client.navigate.back")
-- Rex numbers tabs from 1, where tmux numbered windows from 0.
for index = 1, 9 do
  rex.bind(prefix .. index, "client.tab.goto", { index = index })
end

rex.bind(prefix .. "w", "pane.go_to")
rex.bind(prefix .. "s", "session.switch")
rex.bind(prefix .. "shift+9", "session.previous")
rex.bind(prefix .. "shift+0", "session.next")

rex.bind(prefix .. "r", "client.config.reload")
-- ctrl+b now starts a sequence, so it needs another way to reach the terminal.
rex.bind(prefix .. "ctrl+b", "pane.send_key", { key = "ctrl+b" })
