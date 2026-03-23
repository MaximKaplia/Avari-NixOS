#!/usr/bin/env bash

## Author  : Aditya Shakya (adi1090x)
## Modified for OBS Shortcuts
#
## Applets : OBS Controller

# Import Current Theme
source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$type/$style"

# OBS Password (change this to your actual password)
PASSWORD='paswrd'

# Theme Elements
prompt='OBS Controller'
mesg="WebSocket: localhost:4455"

# FIXED: Updated for 6 options instead of 5
if [[ ( "$theme" == *'type-1'* ) || ( "$theme" == *'type-3'* ) || ( "$theme" == *'type-5'* ) ]]; then
	list_col='1'
	list_row='6'  # CHANGED from 5 to 6
elif [[ ( "$theme" == *'type-2'* ) || ( "$theme" == *'type-4'* ) ]]; then
	list_col='6'  # CHANGED from 5 to 6
	list_row='1'
fi

if [[ ( "$theme" == *'type-1'* ) || ( "$theme" == *'type-5'* ) ]]; then
	efonts="JetBrains Mono Nerd Font 10"
else
	efonts="JetBrains Mono Nerd Font 28"
fi

# Options with Nerd Font icons
layout=`cat ${theme} | grep 'USE_ICON' | cut -d'=' -f2`
if [[ "$layout" == 'NO' ]]; then
    option_1="󰑊 Recording Control"
    option_2=" New Chapter"
    option_3="󱕴 Item Chapter"
    option_4=" NPC Chapter"
    option_5="󰱯 Boss Chapter"
    option_6="󰹑 VRR Control"
else
    option_1="󰑊"
    option_2=""
    option_3="󱕴"
    option_4=""
    option_5="󰱯"
    option_6="󰹑"
fi

# Base OBS commands - Recording control is now handled specially
declare -A obs_commands=(
    ["$option_2"]="recording create-chapter"
    ["$option_3"]="recording create-chapter \"Item\""
    ["$option_4"]="recording create-chapter \"NPC\""
    ["$option_5"]="recording create-chapter \"Boss\""
)

# Rofi CMD for main menu
rofi_cmd() {
	rofi -theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'textbox-prompt-colon {str: "󱄅";}' \
		-theme-str "element-text {font: \"$efonts\";}" \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		-markup-rows \
		-theme ${theme}
}

# Text input popup with dynamic prompt
text_input_cmd() {
    local prompt_text="$1"
    rofi -theme-str 'window {width: 400px;}' \
        -dmenu \
        -p "$prompt_text" \
        -l 0 \
        -filter '' \
        -theme ${theme}
}

# Recording controls popup
recording_controls_cmd() {
    rofi -theme-str 'window {width: 300px;}' \
        -theme-str 'listview {columns: 1; lines: 4;}' \
        -theme-str 'element-text {horizontal-align: 0.5;}' \
        -dmenu \
        -p 'Recording' \
        -mesg 'Select action:' \
        -theme ${theme}
}

# Recording control options
rec_start="󰐊 Start"
rec_pause="󰏤 Pause"
rec_resume="󰑄 Resume"
rec_stop="󰓛 Stop"

show_recording_controls() {
    echo -e "$rec_start\n$rec_pause\n$rec_resume\n$rec_stop" | recording_controls_cmd
}

# Execute OBS command - UPDATED for New Chapter behavior
execute_obs_command() {
    base_cmd="$1"
    extra_text="$2"

    # Special handling for "New Chapter" option
    if [[ "$base_cmd" == "recording create-chapter" && -z "$extra_text" ]]; then
        # New Chapter with empty field - send command without chapter name
        obs-cmd --websocket "obsws://localhost:4455/$PASSWORD" recording create-chapter

        # Notification
        if command -v notify-send &> /dev/null; then
            notify-send "OBS Controller" "Created blank chapter" -t 2000
        fi
        return
    fi

    # Regular handling for other chapter types
    if [[ "$base_cmd" == *"Item"* ]]; then
        # For Item chapters
        chapter_name="Item"
        if [[ -n "$extra_text" ]]; then
            chapter_name="Item $extra_text"
        fi
    elif [[ "$base_cmd" == *"NPC"* ]]; then
        # For NPC chapters
        chapter_name="NPC"
        if [[ -n "$extra_text" ]]; then
            chapter_name="NPC $extra_text"
        fi
    elif [[ "$base_cmd" == *"Boss"* ]]; then
        # For Boss chapters
        chapter_name="Boss"
        if [[ -n "$extra_text" ]]; then
            chapter_name="Boss $extra_text"
        fi
    else
        # For New Chapter with text
        chapter_name="$extra_text"
    fi

    # Execute with properly quoted chapter name
    obs-cmd --websocket "obsws://localhost:4455/$PASSWORD" recording create-chapter "$chapter_name"

    # Notification
    if command -v notify-send &> /dev/null; then
        notify-send "OBS Controller" "Chapter created: $chapter_name" -t 2000
    fi
}

# VRR control popup
vrr_controls_cmd() {
    rofi -theme-str 'window {width: 300px;}' \
        -theme-str 'listview {columns: 1; lines: 2;}' \
        -theme-str 'element-text {horizontal-align: 0.5;}' \
        -dmenu \
        -p 'Adaptive Sync' \
        -mesg 'Set VRR policy:' \
        -theme ${theme}
}

# VRR control options
vrr_on="󱣲 Automatic"
vrr_off=" Never"

show_vrr_controls() {
    echo -e "$vrr_on\n$vrr_off" | vrr_controls_cmd
}

# Main loop - FIXED: Now includes all 6 options
while true; do
    # Show main menu - FIXED: Now includes option_6
    chosen=$(echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5\n$option_6" | rofi_cmd)

    # If user pressed Esc or closed Rofi, exit
    if [[ -z "$chosen" ]]; then
        exit 0
    fi

    # Get base command for chosen option
    base_cmd="${obs_commands[$chosen]}"

    # Check if this is a chapter command (needs text input)
    if [[ "$base_cmd" == *"create-chapter"* ]]; then
        # Determine prompt text based on selection
        case "$chosen" in
            "$option_2")
                prompt_text="Chapter name:"
                ;;
            "$option_3")
                prompt_text="Item name:"
                ;;
            "$option_4")
                prompt_text="NPC name:"
                ;;
            "$option_5")
                prompt_text="Boss name:"
                ;;
            *)
                prompt_text="Text:"
                ;;
        esac

        # Show text input popup with dynamic prompt
        user_text=$(text_input_cmd "$prompt_text")

        # Execute OBS command with text input
        execute_obs_command "$base_cmd" "$user_text"
        # Script closes after successful execution
        exit 0

    elif [[ "$chosen" == "$option_6" ]]; then
        # For VRR Control option - show submenu
        vrr_choice="$(show_vrr_controls)"

        case ${vrr_choice} in
            $vrr_on)
                # Set VRR to Automatic (for your DP-2 monitor)
                kscreen-doctor output.DP-2.vrrpolicy.automatic
                ;;
            $vrr_off)
                # Set VRR to Never
                kscreen-doctor output.DP-2.vrrpolicy.never
                ;;
            *)
                # If no valid selection (pressed Esc), return to main menu
                continue
                ;;
        esac
        exit 0

    else
        # For Recording Control option - show submenu
        rec_choice="$(show_recording_controls)"

        case ${rec_choice} in
            $rec_start)
                obs-cmd --websocket "obsws://localhost:4455/$PASSWORD" recording start
                ;;
            $rec_pause)
                obs-cmd --websocket "obsws://localhost:4455/$PASSWORD" recording pause
                ;;
            $rec_resume)
                obs-cmd --websocket "obsws://localhost:4455/$PASSWORD" recording resume
                ;;
            $rec_stop)
                obs-cmd --websocket "obsws://localhost:4455/$PASSWORD" recording stop
                ;;
            *)
                # If no valid selection (pressed Esc), return to main menu
                continue
                ;;
        esac

        # Optional notification
        #if command -v notify-send &> /dev/null; then
         #   notify-send "OBS Controller" "Recording: ${rec_choice#* }"
        #fi

        # Script closes after successful execution
        exit 0
    fi
done
