local config = {
  allowDiskStartup = false,
  allowTerminate = false,
  terminateWarning = true,
  terminateMessage = "DETECTED TERMINATE!!",
  password = "",
  side = "front",
  text = "Input Password",
  opentime = 1,
  discordWebhook = { --todo
    enable = false,
    url =
    "",
    nickname = "Password System",
    prefix = "",
    items = {
      onOpen = false,
      onIncorrectPassword = true,
      tryTerminate = true,
    }
  }
}
if config.discordWebhook.enable then
  if not http then
    error("Webhook http is not supported.")
  end
  if not http.checkURL(config.discordWebhook.url) then
    error("Webhook URL is incorrect.")
  end
end

local function sel(bool, t, f)
  if bool then
    return t;
  else
    return f;
  end
end

local x, y = term.getSize();
local function setDiskStartup(at)
  settings.set("shell.allow_disk_startup", at)
end
local function sendWebhook(text)
  if not config.discordWebhook.enable then
    return;
  end
  http.post(
    config.discordWebhook.url,
    textutils.serialiseJSON({
      content = config.discordWebhook.prefix .. text,
      username = config.nickname
    }), { ["Content-Type"] = "application/json" }
  );
end
local function terminateWarning()
  --Set {A,B,A}
  local colorSet = { colors.red, colors.black, colors.red }
  repeat
    for i = 1, 2, 1 do
      term.setBackgroundColor(colorSet[i]);
      term.setTextColor(colorSet[i + 1])
      term.clear();
      local textX = (x / 2) - (#config.terminateMessage / 2) + 1
      for textY = 1, y, 1 do
        term.setCursorPos(textX, textY);
        term.write(config.terminateMessage);
      end
      os.startTimer(1);
      os.pullEventRaw();
    end
  until false
end
local function onTerminate()
  if config.discordWebhook.items.tryTerminate then
    sendWebhook("Anyone tried terminate!!!");
  end
  if config.terminateWarning then
    terminateWarning()
  end
end
local function onIncorrect()
  if config.discordWebhook.items.onIncorrectPassword then
    sendWebhook("Incorrect Password!!!")
  end
end
local function solveAnswer(ans)
  if ans == config.password then
    if config.discordWebhook.items.onOpen then
      sendWebhook("Door has opened")
    end
    term.clear();
    term.setCursorPos(1, 1);
    print("Unlocked")
    redstone.setOutput(config.side, true)
    sleep(config.opentime)
    redstone.setOutput(config.side, false)
    error("Program Exited. Please Restart", 0)
  else
    onIncorrect();
  end
end
setDiskStartup(config.allowDiskStartup);
-- upper one than center
local textY = sel(y % 2 == 1, (y - 1) / 2, y / 2);
local textX = (x / 2) - (#config.text / 2) + 1
local inputX = x * 0.2
local inputWidth = x * 0.6
-- lower one than center
local inputY = sel(y % 2 == 1, (y + 1) / 2, (y / 2) + 1);
local function inputScreen()
  term.clear();
  term.setCursorPos(textX, textY);
  term.write(config.text);
  term.setCursorPos(inputX, inputY);
  term.setBackgroundColor(colors.gray);
  term.write((" "):rep(inputWidth));
  term.setCursorPos(inputX, inputY);
  term.setTextColor(colors.white)
  local noTerminate, ans = pcall(read, "*")
  if not noTerminate then
    onTerminate();
  else
    term.setBackgroundColor(colors.black)
    solveAnswer(ans);
  end
end
repeat
  inputScreen()
until false
