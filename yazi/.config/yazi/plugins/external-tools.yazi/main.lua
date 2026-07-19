--- @sync entry
--- @since 26.5.6

local function cwd()
	local current = cx.active.current.cwd
	if current.is_search then
		return tostring(current.path)
	end
	return tostring(current)
end

local function notify_error(title, content)
	ya.notify({
		title = title,
		content = content,
		level = "err",
		timeout = 5,
	})
end

local function spawn_detached(cmd, args)
	local command = Command(cmd)
	for _, arg in ipairs(args) do
		command = command:arg(arg)
	end

	local child, err = command:spawn()
	if not child then
		notify_error("External tools", ("Failed to start %s: %s"):format(cmd, err))
	end
end

return {
	entry = function(_, job)
		local action = job.args[1]
		local dir = cwd()

		if action == "code" then
			spawn_detached("code", { dir })
		elseif action == "ghostty" then
			spawn_detached("ghostty", { "--working-directory=" .. dir })
		else
			notify_error("External tools", ("Unknown action: %s"):format(action or ""))
		end
	end,
}
