# Fish shell completions for mmsg (MangoWC IPC)

# Operation modes (primary)
complete -c mmsg -s g -d 'Get values (tags, layout, focused client)'
complete -c mmsg -s s -d 'Set values (switch tags, layouts)'
complete -c mmsg -s w -d 'Watch mode (stream events)'

# General options (work standalone or with any mode)
complete -c mmsg -s O -d 'Get all output (monitor) information'
complete -c mmsg -s T -d 'Get number of tags'
complete -c mmsg -s L -d 'Get all available layouts'
complete -c mmsg -s q -d 'Quit MangoWC'
complete -c mmsg -s o -d 'Select output (monitor)' -x

# Get options (used with -g or -w)
complete -c mmsg -n '__fish_contains_opt g w' -s O -d 'Get output name'
complete -c mmsg -n '__fish_contains_opt g w' -s o -d 'Get output (monitor) focus information'
complete -c mmsg -n '__fish_contains_opt g w' -s t -d 'Get selected tags'
complete -c mmsg -n '__fish_contains_opt g w' -s l -d 'Get current layout'
complete -c mmsg -n '__fish_contains_opt g w' -s c -d 'Get title and appid of focused clients'
complete -c mmsg -n '__fish_contains_opt g w' -s v -d 'Get visibility of statusbar'
complete -c mmsg -n '__fish_contains_opt g w' -s m -d 'Get fullscreen status'
complete -c mmsg -n '__fish_contains_opt g w' -s f -d 'Get floating status'
complete -c mmsg -n '__fish_contains_opt g w' -s x -d 'Get focused client geometry'
complete -c mmsg -n '__fish_contains_opt g w' -s e -d 'Get name of last focused layer'
complete -c mmsg -n '__fish_contains_opt g w' -s k -d 'Get current keyboard layout'
complete -c mmsg -n '__fish_contains_opt g w' -s b -d 'Get current keybind mode'
complete -c mmsg -n '__fish_contains_opt g w' -s A -d 'Get scale factor of monitor'

# Set options (used with -s)
complete -c mmsg -n '__fish_contains_opt s' -s o -d 'Select output (monitor)' -x
complete -c mmsg -n '__fish_contains_opt s' -s t -d 'Set selected tags (use [+-^.] modifiers)' -x -a '1 2 3 4 5 6 7 8 9'
complete -c mmsg -n '__fish_contains_opt s' -s l -d 'Set current layout' -x
complete -c mmsg -n '__fish_contains_opt s' -s c -d 'Get title and appid of focused client'
complete -c mmsg -n '__fish_contains_opt s' -s d -d 'Dispatch internal command (max 5 args)' -x

# Layout values (argument to -l)
complete -c mmsg -n 'string match -q -- -l (commandline -opc)[-1]' -a S  -d Scroller
complete -c mmsg -n 'string match -q -- -l (commandline -opc)[-1]' -a T  -d Tile
complete -c mmsg -n 'string match -q -- -l (commandline -opc)[-1]' -a G  -d Grid
complete -c mmsg -n 'string match -q -- -l (commandline -opc)[-1]' -a M  -d Monocle
complete -c mmsg -n 'string match -q -- -l (commandline -opc)[-1]' -a K  -d Deck
complete -c mmsg -n 'string match -q -- -l (commandline -opc)[-1]' -a VS -d 'Vertical Scroller'
complete -c mmsg -n 'string match -q -- -l (commandline -opc)[-1]' -a VT -d 'Vertical Tile'
complete -c mmsg -n 'string match -q -- -l (commandline -opc)[-1]' -a CT -d 'Center Tile'

# Dispatch command values (argument to -d)
complete -c mmsg -n 'string match -q -- -d (commandline -opc)[-1]' -a killclient              -d 'Close the focused window'
complete -c mmsg -n 'string match -q -- -d (commandline -opc)[-1]' -a resizewin               -d 'Resize window (args: +X,+Y)'
complete -c mmsg -n 'string match -q -- -d (commandline -opc)[-1]' -a togglefullscreen        -d 'Toggle fullscreen mode'
complete -c mmsg -n 'string match -q -- -d (commandline -opc)[-1]' -a disable_monitor         -d 'Disable a monitor (arg: monitor name)'
complete -c mmsg -n 'string match -q -- -d (commandline -opc)[-1]' -a create_virtual_output   -d 'Create a virtual output'
complete -c mmsg -n 'string match -q -- -d (commandline -opc)[-1]' -a destroy_all_virtual_output -d 'Destroy all virtual outputs'
