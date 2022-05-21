import os, subprocess
from libqtile import bar, layout, widget, hook
from libqtile.config import Group, Key, Match, Screen
# from libqtile.config import KeyChord
from libqtile.lazy import lazy
from libqtile.config import EzKey as EzKey
from libqtile.config import EzDrag as EzDrag
from libqtile.config import EzClick as EzClick
# from libqtile.utils import guess_terminal

mod = "mod4"
# terminal = guess_terminal()
terminal = "st"

keys = [
    EzKey("M-j", lazy.layout.next()),
    EzKey("M-k", lazy.layout.previous()),
    EzKey("M-<space>", lazy.window.toggle_floating()),
    EzKey("M-S-h", lazy.layout.shuffle_left()),
    EzKey("M-S-l", lazy.layout.shuffle_right()),
    EzKey("M-S-j", lazy.layout.shuffle_down()),
    EzKey("M-S-k", lazy.layout.shuffle_up()),
    EzKey("M-C-h", lazy.layout.grow_left()),
    EzKey("M-C-l", lazy.layout.grow_right()),
    EzKey("M-C-j", lazy.layout.grow_down()),
    EzKey("M-C-k", lazy.layout.grow_up()),
    EzKey("M-<Return>", lazy.spawn(terminal)),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    EzKey("M-S-<Return>", lazy.layout.toggle_split()),
    EzKey("M-<Tab>", lazy.spawn("dmenu_run")),
    EzKey("M-q", lazy.window.kill()),
    EzKey("M-S-q", lazy.shutdown()),
    EzKey("M-S-<space>", lazy.next_layout()),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    # qtile's run prompt
    # EzKey("M-r", lazy.spawncmd()),

    # just a keychord example, it doesnt feel stable
    #    KeyChord([mod],"a",[Key([],"p",lazy.spawn("pavucontrol"))]),


    Key([],"XF86MonBrightnessUp", lazy.spawn("xbacklight -inc 5")),
    Key([],"XF86MonBrightnessDown", lazy.spawn("xbacklight -dec 5")),
    Key([],"XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -10%")),
    Key([],"XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +10%")),
    Key([],"XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")),
    Key([],"XF86Search", lazy.spawn("passmenu")),
    Key([],"Print", lazy.spawn("flameshot gui")),
    Key([],"XF86AudioPlay", lazy.spawn("playerctl play-pause")),
    Key([],"XF86AudioPrev", lazy.spawn("playerctl previous")),
    Key([],"XF86AudioNext", lazy.spawn("playerctl next")),

    EzKey("M-C-c",lazy.spawn("firefox -P Cooku")),
    EzKey("M-C-e",lazy.spawn("emacsclient -c")),
    EzKey("M-C-f",lazy.spawn("firefox -P NiceBoi")),
    EzKey("M-C-g",lazy.spawn("clipmenu")),
    EzKey("M-C-p",lazy.spawn("pavucontrol")),
]

groups = [
    Group("1"),
    Group("2"),
    Group("3"),
    Group("4"),
    Group("5"),
    Group("6"),
    Group("7", label="", exclusive=True, layout="max", matches=[Match(wm_class=["firefox","Chromium-bin-browser-chromium"])]),
    Group("8", label="", matches=[Match(wm_class=["TelegramDesktop","wire"])]),
    Group("9", label=""),

]

for i in groups:
    keys.extend(
        [
            EzKey("M-" + i.name, lazy.group[i.name].toscreen()),
            EzKey("M-S-" + i.name, lazy.window.togroup(i.name, switch_group=True)),          
        ]
    )

col_orange = "#ff6a4d"
layouts = [
    # layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    layout.VerticalTile(border_focus=col_orange),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
 #layout.Stack(num_stacks=2),
 #layout.Bsp(),
 #layout.Matrix(),
    layout.MonadTall(border_focus=col_orange),
    layout.MonadWide(border_focus=col_orange),
 #layout.RatioTile(),
 #layout.Tile(),
    layout.TreeTab(active_bg=col_orange, panel_width=50),
 #layout.Zoomy(),
]

widget_defaults = dict(
    font="sans",
    fontsize=18,
    padding=5,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.GroupBox(disable_drag=True,highlight_method='line',highlight_color=[col_orange],inactive='777777'),
                # widget.Prompt(),
                widget.CurrentLayout(background='444444'),
                widget.TaskList(highlight_method="block",border=col_orange),
                # widget.Chord(
                #     chords_colors={
                #         "launch": ("#ff0000", "#ffffff"),
                #     },
                #     name_transform=lambda name: name.upper(),
                # ),
                # widget.TextBox("default config", name="default"),
                # widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
                # widget.Systray(),
                widget.Net(update_interval=2, format='<span fgcolor="#c37dfd"></span>  {up}  {down}', interface=["wlan0"]),
                widget.TextBox("", foreground="#ff5252"),
                widget.Clock(format="%d-%m %a"),
                widget.TextBox("", foreground="#fbc02d"),
                widget.Clock(format="%I:%M %p"),
                widget.Wallpaper(label="  ",foreground="00c853",random_selection=True,directory="/common/wallpapers/"),
                widget.QuickExit(default_text="", countdown_start=3, countdown_format="{}"),
            ],
            36,
            opacity=0.75,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ),
]

# Drag floating layouts.
mouse = [
    EzDrag("M-1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
#    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    EzDrag("M-3",lazy.window.set_size_floating(), start=lazy.window.get_size()),
#    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    EzClick("M-2",lazy.window.bring_to_front()),
#    Click([mod], "Button2", lazy.window.bring_to_front()),
]
 
dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="Pavucontrol"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(wm_class="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

@hook.subscribe.startup_once
def startstuff():
    if os.path.isfile(os.path.expanduser('~/.wmrc')):
        subprocess.run([os.path.expanduser('~/.wmrc')])
