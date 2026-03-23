#!/usr/bin/env bash

## Author  : Aditya Shakya (adi1090x)
## Github  : @adi1090x
#
## Applets : Quick Links

# Import Current Theme
source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$type/$style"

# Theme Elements
prompt='Quick Links'
mesg="Using '$BROWSER' as web browser"

if [[ ( "$theme" == *'type-1'* ) || ( "$theme" == *'type-3'* ) || ( "$theme" == *'type-5'* ) ]]; then
	list_col='1'
	list_row='6'
elif [[ ( "$theme" == *'type-2'* ) || ( "$theme" == *'type-4'* ) ]]; then
	list_col='6'
	list_row='1'
fi

if [[ ( "$theme" == *'type-1'* ) || ( "$theme" == *'type-5'* ) ]]; then
	efonts="JetBrains Mono Nerd Font 10"
else
	efonts="JetBrains Mono Nerd Font 28"
fi

# Options
layout=`cat ${theme} | grep 'USE_ICON' | cut -d'=' -f2`
if [[ "$layout" == 'NO' ]]; then
	option_1=" Youtube"
	option_2=" Gmail"
	option_3=" Telegram"
	option_4=" DeepSeek"
	option_5=" Reddit"
	option_6=" VK"
else
	option_1=""
	option_2=""
	option_3=""
	option_4=""
	option_5=""
	option_6=""
fi

# URL mappings for each option
declare -A urls=(
    ["$option_1"]="https://www.youtube.com/"
    ["$option_2"]="https://mail.google.com/mail/u/0/#inbox"
    ["$option_3"]="https://web.telegram.org/a/#588760656"
    ["$option_4"]="https://chat.deepseek.com/"
    ["$option_5"]="https://www.reddit.com/"
    ["$option_6"]="https://vk.com/im"
)

# Rofi CMD for main menu
rofi_cmd() {
	rofi -theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'textbox-prompt-colon {str: "";}' \
		-theme-str "element-text {font: \"$efonts\";}" \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		-markup-rows \
		-theme ${theme}
}

# Universal popup options
open_tab="󰝜 Open Tab"
new_window=" New Window"
popup_cancel=" Cancel"

# Show universal popup and handle selection
show_link_popup() {
    echo -e "$open_tab\n$new_window\n$popup_cancel" | link_popup_cmd
}

# Rofi CMD for link confirmation popup - FIXED TO SHOW ALL 3 OPTIONS
link_popup_cmd() {
    rofi -theme-str 'window {width: 250px;}' \
        -theme-str 'listview {columns: 1; lines: 3;}' \
        -theme-str 'element-text {horizontal-align: 0.5;}' \
        -dmenu \
        -p 'Open Link' \
        -mesg 'Choose how to open:' \
        -theme ${theme}
}

# Execute Command
handle_link() {
    url="$1"

    if [[ -n "$url" ]]; then
        # Show options popup
        link_choice="$(show_link_popup)"
        case ${link_choice} in
            $open_tab)
                xdg-open "$url"
                # After opening, exit the script
                exit 0
                ;;
            $new_window)
                firefox --new-window "$url"
                # After opening, exit the script
                exit 0
                ;;
            $popup_cancel|*)
                # Cancel - DO NOT exit, just return to main loop
                return 1
                ;;
        esac
    fi
}

# Main loop
while true; do
    # Show main menu
    chosen=$(echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5\n$option_6" | rofi_cmd)

    # If user pressed Esc or closed Rofi, exit
    if [[ -z "$chosen" ]]; then
        exit 0
    fi

    # Get URL for chosen option
    url="${urls[$chosen]}"

    # Handle the link selection
    if [[ -n "$url" ]]; then
        handle_link "$url"
        # If handle_link returns 1 (cancelled), loop continues
        # If it opened a link (exited with 0), script ends
    fi
done
