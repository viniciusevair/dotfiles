local user = {

  --Profile
  name         = "Zaurak",
  host         = "swordfishII",
  user_img     = os.getenv ("HOME") .. "/Pictures/Avatars/dramaturgy.png",

  -- Default apps
  terminal     = "wezterm",
  file_manager = "thunar",
  browser      = "firefox",
  editor       = "nvim",

  wallpaper    = "~/Pictures/Wallpapers/town.jpg",
  icon_path    = os.getenv ("HOME") .. "/.local/share/icons/Tela-circle-brown/scalable/apps/",
  screenshot_path = os.getenv ("HOME") .. "/Pictures/Screenshots",
  theme        = "zaurak",
  bar_floating = false,
}

user.dock_elements = {
  { 'terminal',    user.terminal },
  { user.browser,  user.browser },
  { 'Thunar',      user.file_manager },
  { 'telegram',    'telegram-desktop' },
  { 'discord',     'vesktop' },
  { 'krita' },
  { 'obs' }
}

return user
