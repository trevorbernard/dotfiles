-- Plays a sound when an agent in any Rex terminal finishes, fails,
-- or stops to wait for you.
local sound = rex.args.sound or "Glass"
local sounds = { done = sound, blocked = sound, error = "Basso" }
local last = {}

rex.on("terminal.program_status_changed", function(ctx, ev)
  local key = tostring(ctx.block_id) .. "/" .. ev.id
  local state = ev.record.state
  local previous = last[key]
  last[key] = state
  if previous ~= "working" or not sounds[state] then return end
  rex.exec{ "afplay", "/System/Library/Sounds/" .. sounds[state] .. ".aiff" }
end)
