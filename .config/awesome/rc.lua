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
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- Vicious Widgets
require("vicious")
require("delightful.widgets.pulseaudio")
-- require('delightful.widgets.battery')
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
    delightful.widgets.network,
    delightful.widgets.cpu,
    delightful.widgets.memory,
--    delightful.widgets.battery,
    delightful.widgets.pulseaudio,
    delightful.widgets.datetime
}

-- Widget configuration
delightful_config = {
    [delightful.widgets.cpu] = {
        command = 'gnome-system-monitor',
    },
    [delightful.widgets.network] = {
      excluded_devices={"^lo$", "^sit0$"},
    },
    [delightful.widgets.memory] = {
        command = 'gnome-system-monitor',
    },
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

clipboardTable={ };
 -- Function to store text in clipboard
 function clipboardStore()
     table.insert(clipboardTable, selection());
 end

-- function clipboardPaste()
--     clipboardTable[#clipboardTable]

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
if(screen.count()==1) then
    taglayouts1 = 
    {
        awful.layout.suit.fair,
        awful.layout.suit.fair,
        awful.layout.suit.floating,
        awful.layout.suit.fair,
    }
    tagtable1 = { "1-terminal", "2-browser", "3-other"  }
    tags = {}
    tags[1] = awful.tag(tagtable1,1,taglayouts1);
else
    taglayouts1 = 
    {
        awful.layout.suit.max.fullscreen,
        awful.layout.suit.floating,
    }
    taglayouts2 = 
    {
        awful.layout.suit.fair,
        awful.layout.suit.fair,
    }
    tagtable1 = { "1-browser", "2-other" }
    tagtable2 = { "1-terminal" }
    tags = {}
    -- Each screen has its own tag table.
    tags[1] = awful.tag(tagtable1, 1, taglayouts1)
    tags[2] = awful.tag(tagtable2, 2, taglayouts2)
end
--for the pidgin tag increase number of masters
awful.tag.setnmaster(2,tags[1][3])
awful.tag.setmwfact(0.2,tags[1][3])
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal },
                                    { "cmus", terminal .. " -e cmus" },
                                    { "browser", "chromium" },
                                    { "thunderbird", "thunderbird" },
                                    { "pidgin", "pidgin" }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" })
mytextclock:add_signal("mouse::enter",function()
  monthcount=0
  curdate=awful.util.pread("date +\"%d %m %Y\"")
  calnot=naughty.notify({text= "<span font='Monospace 11'>"..awful.util.pread("cal "..curdate):gsub("(.*)\n","%1").."</span>", timeout=0})
end
);
mytextclock:add_signal("mouse::leave",function()
  monthcount=0
  if calnot ~= nil then
    naughty.destroy(calnot)
    calnot=nil
  end
end
);
mytextclock:buttons(awful.util.table.join(
  awful.button({ }, 5, function()
    monthcount=monthcount + 1
    curdate=awful.util.pread("date --date=\""..monthcount.." month ago\" +\"%d %m %Y\"")
    if calnot ~= nil then
      calnot=naughty.notify({text= "<span font='Monospace 11'>"..awful.util.pread("cal "..curdate):gsub("(.*)\n","%1").."</span>", timeout=0, replaces_id=calnot.id})
    end
  end),
  awful.button({ }, 4, function()
    monthcount=monthcount - 1
    curdate=awful.util.pread("date --date=\""..monthcount.." month ago\" +\"%d %m %Y\"")
    if calnot ~= nil then
      calnot=naughty.notify({text= "<span font='Monospace 11'>"..awful.util.pread("cal "..curdate):gsub("(.*)\n","%1").."</span>", timeout=0, replaces_id=calnot.id})
    end
  end)
))

function keyboardSwitch()
    if(keyboardwidget.text == "US") then
        os.execute("deutsch");
        keyboardwidget.text = "DE";
    else
        os.execute("us");
        keyboardwidget.text = "US";
    end
end

-- keybpard widget
keyboardwidget = widget({ type = "textbox", name = "keyboardwidget", align = "right"});
keyboardwidget.text = "US";
keyboardwidget:buttons(awful.util.table.join(
  awful.button({ }, 1, keyboardSwitch)
  ));
-- Create a battery widget
batterywidget = widget({type = "textbox", name = "batterywidget", align = "right" })
-- Create a cpu widget
thrmwidget = widget({type = "textbox", name = "cpuwidget", align = "right" })
vicious.register(thrmwidget, vicious.widgets.thermal, "$1C ",2,"thermal_zone0")
-- Create net widget
 netwidget = widget({ type = "textbox" })
 vicious.register(netwidget, vicious.widgets.net, 'Net: <span color="#CC9393">${wlan0 down_kb}</span> <span color="#7F9F7F">${wlan0 up_kb}</span> ', 2)
-- Create fs widget
 fswidget = widget({ type = "textbox" })
 vicious.register(fswidget, vicious.widgets.fs, "${/home avail_gb}GB ", 2)
--create fsicon
 fsicon = widget({ type = "imagebox", name="fs" })
 fsicon_tooltip = awful.tooltip({ objects = {fsicon}, 
 timer_function=function()
   return "<span font='Monospace 11'>"..awful.util.pread("df -h -t ext3 -t ext4 -t ntfs -t fat32 -t fuseblk").."</span>"
 end
 });
 fsicon.image=image(theme.widget_fs);
--create tempicon
 tempicon = widget({ type = "imagebox", name="temp" })
 tempicon_tooltip = awful.tooltip({ objects = {tempicon} });
 tempicon_tooltip:set_text("Temperature of thermal_zone0");
 tempicon.image=image(theme.widget_temp);
 


-- Create volume widget
-- volwidget = widget({ type = "textbox" })
-- vicious.register(volwidget, vicious.widgets.volume, '$1% ', 5, "Master")
-- mutewidget = widget({ type = "textbox" })
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
          --          awful.button({ }, 4, awful.tag.viewnext),
          --          awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end)
         --[[            awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end)--]]
                                          ) 

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end)
                   --        awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                   --        awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)
                           ))
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
        --mylauncher,
        mytaglist[s],
        mypromptbox[s],
        layout = awful.widget.layout.horizontal.leftright
      },
      mylayoutbox[s],
        --mytextclock,
        --batterywidget,
        --cpuwidget,
        --netwidget,
    }
    local widgets_middle = {}
    for delightful_container_index, delightful_container_data in pairs(delightful_container.widgets) do
      for widget_index, widget_data in pairs(delightful_container_data) do
          if(widget_data.widget) then
              table.insert(widgets_middle, widget_data.widget)
           else 
              table.insert(widgets_middle, widget_data)
          end
        if delightful_container.icons[delightful_container_index] and delightful_container.icons[delightful_container_index][widget_index] then
          table.insert(widgets_middle, delightful_container.icons[delightful_container_index][widget_index])
        end
      end
    end

    local widgets_end = {
      fswidget,
      fsicon,
      thrmwidget,
      tempicon,
      keyboardwidget,
--      musicwidget.widget,
      s == 1 and mysystray or nil,
      mytasklist[s],
      layout = awful.widget.layout.horizontal.rightleft
    }
    mywibox[s].widgets = awful.util.table.join(widgets_front, widgets_middle, widgets_end)
    -- Add widgets to the wibox - order matters
--    mywibox[s].widgets = {
--        {
--            mylauncher,
--            mytaglist[s],
--            mypromptbox[s],
--            layout = awful.widget.layout.horizontal.leftright
--        },
--        mylayoutbox[s],
----        volwidget,
----        mutewidget,
--        s == 1 and mysystray or nil,
--        mytasklist[s],
--        layout = awful.widget.layout.horizontal.rightleft
--    }
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end)
--    awful.button({ }, 4, awful.tag.viewnext),
--    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey }, "b", function ()
        os.execute("oj &");
    end),
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
                  mypromptbox[activeScreen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),

    -- Custom Commands
    awful.key({                   }, "Pause", keyboardSwitch),
    awful.key({ modkey, "Mod1"    }, "h", function () awful.util.spawn("hibernate") end),
    awful.key({ modkey, "Mod1"    }, "f", function () awful.util.spawn("firefox-bin") end),
    awful.key({ modkey, "Mod1"    }, "p", function () awful.util.spawn("tmux new-window \"irssi -c localhost -w ".. ircpass .."\"") end),
    awful.key({ modkey, "Mod1"    }, "m", function () awful.util.spawn("mysqlstart") end),
    awful.key({ modkey, "Mod1"    }, "n", function () awful.util.spawn("tmux new-window \"newsbeuter\"") end),
    awful.key({ modkey, "Mod1"    }, "t", function () 
        awful.util.spawn("tmux new-window \"mutt\"")
    end),
    awful.key({ modkey, "Mod1"    }, "c", function () awful.util.spawn("tmux new-window -n \"cmus\" \"cmus\""); end),
    awful.key({ modkey, "Mod1"    }, "l", function () awful.util.spawn("xscreensaver-command -lock") end),
    awful.key({ modkey, "Mod1"    }, "s", function () 
      awful.util.spawn("pidgin") 
      awful.util.spawn("thunderbird") 
      awful.util.spawn("skype")  
    end)

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
    awful.key({ modkey,           }, "c",      clipboardStore    ),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end),
        awful.key({ modkey }, "<",
        function (c)
            if c.titlebar then
                awful.titlebar.remove(c)
                debug_notify(c.name .. "\ntitlebar " .. colored_off)
            else
                awful.titlebar.add(c, { altkey = "Mod1" })
                debug_notify(c.name .. "\ntitlebar " .. colored_on)
            end
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
if screen.count()==1 then
    awful.rules.rules = {
        -- All clients will match this rule.
        { rule = { },
        properties = { border_width = beautiful.border_width,
        border_color = beautiful.border_normal,
        focus = true,
        keys = clientkeys,
        buttons = clientbuttons,
        tag = tags[1][3],
        maximized_vertical   = false,
        maximized_horizontal = false,
        size_hints_honor = false,
        }
        },
        { rule = { class = "MPlayer" },
        properties = { floating = true } },
        { rule = { class = "pinentry" },
        properties = { floating = true } },
        { rule = { class = "gimp" },
        properties = { floating = true } },
        -- Set Firefox to always map on tags number 2 of screen 1.
        { rule = { class = "Firefox" },
        properties = { tag = tags[1][2], fullscreen = true } },
        { rule = { class = "Chromium" },
        properties = { tag = tags[1][2] } },
        { rule = { class = "URxvt" },
        properties = { tag = tags[1][1], fullscreen=true } },
        { rule = { name = "MySQL" },
        properties = { tag = tags[1][4] } },
    }
else
    awful.rules.rules = {
        -- All clients will match this rule.
        { rule = { },
        properties = { border_width = beautiful.border_width,
        border_color = beautiful.border_normal,
        focus = true,
        keys = clientkeys,
        buttons = clientbuttons,
        --callback = awful.placement.under_mouse
         tag = tags[1][2],
         maximized_vertical   = false,
         maximized_horizontal = false,
         size_hints_honor = false,
        } },
        { rule = { class = "MPlayer" },
        properties = { floating = true } },
        { rule = { class = "pinentry" },
        properties = { floating = true } },
        { rule = { class = "gimp" },
        properties = { floating = true } },
        -- Set Firefox to always map on tags number 2 of screen 1.
        { rule = { class = "Firefox" },
        properties = { tag = tags[1][1] } },
        { rule = { class = "Chromium" },
        properties = { tag = tags[1][1] } },
      { rule = { class = "URxvt" },
        properties = { tag = tags[2][1], fullscreen=true } },
       { rule = { name = "MySQL" },
        properties = { tag = tags[2][2] } },
  }
end
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    --awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    --c:add_signal("mouse::enter", function(c)
    --    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
    --        and awful.client.focus.filter(c) then
    --        client.focus = c
    --    end
    --end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- Put windows in a smart way, only if they does not set an initial position.
--        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
--        end
    end
    awful.tag.viewonly(c:tags()[1]);
    client.focus=c;
end)

client.add_signal("focus", function(c) 
    c.border_color = beautiful.border_focus 
    activeScreen=c.screen
end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- {{{Startup programs
awful.util.spawn_with_shell("wmname LG3D")

