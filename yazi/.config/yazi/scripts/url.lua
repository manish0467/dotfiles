local yazi = require("yazi")

return {
  run = function()
    -- Run the mpv URL opener
    yazi.spawn("~/.config/yazi/openers/mpv-url.sh", {
      block = false,
    })
  end,
}
