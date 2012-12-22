-- Local config of gitterrost4
-- Standard awesome library
function nprint(arg)
  print(arg)
  io.flush()
end
require("awful")
require("awful.autofocus")
require("awful.rules")
require("awful.remote")
require("blingbling")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- Vicious Widgets
require("vicious")
require("delightful.widgets.pulseaudio")
 require('delightful.widgets.battery')
require('delightful.widgets.cpu')
require('delightful.widgets.datetime')
require('delightful.widgets.memory')
require('delightful.widgets.network')
beautiful.init(awful.util.getdir("config") .. "/themes/default/theme.lua")
require('pass')
--
--
--
-- Which widgets to install?
-- This is the order the widgets appear in the wibox.
 install_delightful = {
    delightful.widgets.battery,
    delightful.widgets.pulseaudio,
    delightful.widgets.datetime
}

-- Widget configuration
delightful_config = {
    [delightful.widgets.pulseaudio] = {
        mixer_command = 'pavucontrol',
    },
}

activeScreen=1;
-- Prepare the container that is used when constructing the wibox
local delightful_container = { widgets = {}, icons = {} }
if install_delightful then
    for _, widget in pairs(awful.util.table.reverse(install_delightful)) do
        local config = delightful_config and delightful_config[widget]
        local widgets, icons = widget:load(config)
        if widgets then
            if not icons then
                icons = {}
            end
            table.insert(delightful_container.widgets, awful.util.table.reverse(widgets))
            table.insert(delightful_container.icons,   awful.util.table.reverse(icons))
        end
    end
end
-- Function for dec to hex conversion
 function DEC_HEX(IN)
   local B,K,OUT,I,D=16,"0123456789ABCDEF","",0
   if IN==0 then
     return "00"
   end
   if IN>255 then
     return "FF"
   end
   while IN>0 do
     I=I+1
     IN,D=math.floor(IN/B),math.mod(IN,B)+1
     OUT=string.sub(K,D,D)..OUT
   end
   if string.len(OUT)==1 then
     OUT="0"..OUT
   end
   return OUT
 end
 
-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
-- beautiful.init("/usr/share/awesome/themes/default/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
taglayouts = 
{
  awful.layout.suit.max.fullscreen,
  awful.layout.suit.max.fullscreen,
  awful.layout.suit.max.fullscreen,
  awful.layout.suit.max.fullscreen,
  awful.layout.suit.max,
}
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ "1-terminal", "2-browser", "3-Mplayer", "4-other", "5-working" }, s, taglayouts)
end
-- vicious.register(mutewidget, vicious.widgets.volume, '<span size="12800">$2</span>', 2, "Master")
-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
   mywibox[s] = awful.wibox({ position = "top", screen = s })
    local widgets_front = {
      {
        mytaglist[s],
        mypromptbox[s],
        layout = awful.widget.layout.horizontal.leftright
      },
      mylayoutbox[s],
    }
    local widgets_middle = {}
    for delightful_container_index, delightful_container_data in pairs(delightful_container.widgets) do
      for widget_index, widget_data in pairs(delightful_container_data) do
        table.insert(widgets_middle, widget_data)
        if delightful_container.icons[delightful_container_index] and delightful_container.icons[delightful_container_index][widget_index] then
          table.insert(widgets_middle, delightful_container.icons[delightful_container_index][widget_index])
        end
      end
    end

    local widgets_end = {
      s == 1 and mysystray or nil,
      mytasklist[s],
      layout = awful.widget.layout.horizontal.rightleft
    }
    mywibox[s].widgets = awful.util.table.join(widgets_front, widgets_middle, widgets_end)
end
-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () 
        activeScreen = activeScreen % screen.count() + 1
        awful.screen.focus(activeScreen) 
    end),
    awful.key({ modkey, "Control" }, "k", function () 
        activeScreen = 1 + ((activeScreen-2) % screen.count())
        awful.screen.focus(activeScreen)
    end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),
    awful.key({ }, "XF86AudioMute", function () 
--      awful.util.spawn("amixer set Master toggle") 
--      vicious.force({mutewidget});
      delightful.widgets.pulseaudio.pulseaudio_control("toggle",1);
    end),
    awful.key({ }, "XF86AudioLowerVolume", function () 
--      awful.util.spawn("amixer set Master 1-,1-") 
--      vicious.force({volwidget});
      delightful.widgets.pulseaudio.pulseaudio_control("down",1);
    end),
    awful.key({ }, "XF86AudioRaiseVolume", function () 
--      awful.util.spawn("amixer set Master 1+,1+") 
--      vicious.force({volwidget});
      delightful.widgets.pulseaudio.pulseaudio_control("up",1);
    end),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[1]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[1].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),

    -- Custom Commands
    awful.key({                   }, "Pause", keyboardSwitch),
    -- Shared Commands
    awful.key({ modkey, "Mod1"    }, "f", function () awful.util.spawn("luakit") end),
    awful.key({ modkey, "Mod1"    }, "c", function () awful.util.spawn("tmux new-window -n \"cmus\" \"cmus\"\; split-window -h \"sleep 0.25; cmus-lyrics\"\; select-pane -L") end ), 
    awful.key({ modkey, "Mod1"    }, "p", function () awful.util.spawn("tmux new-window \"irssi -c localhost -w ".. ircpass .."\"") end),
    awful.key({ modkey, "Mod1"    }, "n", function () awful.util.spawn("tmux new-window \"newsbeuter\"") end),
    awful.key({ modkey, "Mod1"    }, "x", function () awful.util.spawn("tmux new-window \"mc\"") end),
    awful.key({ modkey, "Mod1"    }, "l", function () awful.util.spawn("xscreensaver-command -lock") end),
    -- Home Commands
    awful.key({ modkey, "Mod1"    }, "j", function () awful.util.spawn("jdownloader") end),
    awful.key({ modkey, "Mod1"    }, "t", function () 
      awful.util.spawn("tmux new-window \"mutt\"\\; split-window -h \"mutt -F ~/.work.muttrc\"; select-pane -L")
    end),
    awful.key({ modkey, "Mod1"    }, "m", function () awful.util.spawn("minecraft") end),
    awful.key({                   }, "XF86MonBrightnessUp", function () awful.util.spawn("xbacklight =100") end),
    awful.key({                   }, "XF86MonBrightnessDown", function () awful.util.spawn("xbacklight =0") end),
    awful.key({                   }, "XF86WLAN", function () awful.util.spawn("togglewlan toggle") end),

    --Soundeffects
    awful.key({ modkey, "Mod1"    }, "F1", function () awful.util.spawn("mplayer /home/gitterrost4/sounds/buzzer.mp3") end), --1
    awful.key({ modkey, "Mod1"    }, "F2", function () awful.util.spawn("mplayer /home/gitterrost4/sounds/cricket.mp3") end),--2
    awful.key({ modkey, "Mod1"    }, "F3", function () awful.util.spawn("mplayer /home/gitterrost4/sounds/jeopardy.mp3") end),--3
    awful.key({ modkey, "Mod1"    }, "F4", function () awful.util.spawn("mplayer /home/gitterrost4/sounds/trombone.mp3") end),--4
    awful.key({ modkey, "Mod1"    }, "F5", function () awful.util.spawn("mplayer /home/gitterrost4/sounds/badummtss.mp3") end),--5
    awful.key({ modkey, "Mod1"    }, "F6", function () awful.util.spawn("mplayer /home/gitterrost4/sounds/nein.mp3") end),--6
    awful.key({ modkey, "Mod1"    }, "F7", function () awful.util.spawn("mplayer /home/gitterrost4/sounds/bazinga.mp3") end),--7
    awful.key({ modkey, "Mod1"    }, "F8", function () awful.util.spawn("mplayer /home/gitterrost4/sounds/applause.mp3") end),--8
    awful.key({ modkey, "Mod1"    }, "Delete", function () awful.util.spawn("killall mplayer") end)
    

)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
--
-- I want to bind Mod4+` to the zeroeth tag.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = activeScreen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = activeScreen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[activeScreen][i] then
                          awful.client.movetotag(tags[activeScreen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[activeScreen][i] then
                          awful.client.toggletag(tags[activeScreen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     maximized_vertical   = false,
                     maximized_horizontal = false,
                     buttons = clientbuttons,
                     size_hints_honor = false,
--                     fullscreen = true,

                     tag = tags[1][4]} },
--    { rule = { class = "MuPDF" },
--      properties = { fullscreen=true  } },
--    { rule = { class = "mupdf" },
--      properties = { fullscreen=true } },
    { rule = { class = "feh" },
      properties = { tag = tags[1][1] } },
    { rule = { class = "luakit" },
      properties = { tag = tags[1][2] } },
    { rule = { class = "Firefox" },
      properties = { tag = tags[1][2] } },
    { rule = { class = "Chromium" },
      properties = { tag = tags[1][2], fullscreen = true } },
    { rule = { name = "<unknown>" },
      properties = { fullscreen=true, floating=true, tag = tags[1][2] } },
    { rule = { class = "Exe"}, 
      properties = {floating = true, tag = tags[1][2]} },
    { rule = { class = "MPlayer" },
      properties = { tag = tags[1][3] } },
    { rule = { class = "mplayer2" },
      properties = { tag = tags[1][3] } },
    { rule = { class = "URxvt" },
      properties = { tag = tags[1][1] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)

    if not startup then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
    end
if(c.class ~= "jd-Main" or not string.find(c.name, "win%d+")) then
    awful.tag.viewonly(c:tags()[1]);
    client.focus=c;
  end 
end)

client.add_signal("focus", function(c) 
    c.border_color = beautiful.border_focus 
    activeScreen=c.screen
end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- {{{Startup programs
awful.util.spawn_with_shell("wmname LG3D")

