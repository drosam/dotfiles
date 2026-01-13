-- ~/.config/nvim/lua/status_icons.lua
local M = {}

function M.docker_os_icon()
  local os_icon = ""  -- default Linux icon
  local docker_icon = ""

  -- Detect OS
  local uname = vim.loop.os_uname().sysname
  if uname == "Darwin" then
    os_icon = ""
  elseif uname == "Linux" then
    local f = io.open("/etc/os-release")
    if f then
      local content = f:read("*a")
      f:close()
      if content:lower():match("ubuntu") then
        os_icon = ""
      end
    end
  end

  -- Detect Docker
  local f_docker = io.open("/.dockerenv")
  if f_docker then
    docker_icon = "  "
    f_docker:close()
  else
    -- fallback check for cgroup
    local f_cgroup = io.open("/proc/1/cgroup")
    if f_cgroup then
      local content = f_cgroup:read("*a")
      f_cgroup:close()
      if content:match("docker") or content:match("kubepods") then
        docker_icon = "  "
      end
    end
  end

  -- Return stacked icons
  return os_icon .. docker_icon
end

return M

