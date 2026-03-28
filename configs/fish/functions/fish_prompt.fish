function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
    set -l normal (set_color normal)
    set -q fish_color_status
    or set -g fish_color_status red

    # Color the prompt differently when we're root
    set -l color_cwd $fish_color_cwd
    set -l suffix '>'
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        end
        set suffix '#'
    end

    # Write pipestatus
    # If the status was carried over (if no command is issued or if `set` leaves the status untouched), don't bold it.
    set -l bold_flag --bold
    set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
    if test $__fish_prompt_status_generation = $status_generation
        set bold_flag
    end
    set __fish_prompt_status_generation $status_generation
    set -l status_color (set_color $fish_color_status)
    set -l statusb_color (set_color $bold_flag $fish_color_status)
    set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

    # Read colors from alacritty.toml
    set -l alacritty_config ~/.config/alacritty/alacritty.toml


    # Main color
    set -l bright_red (grep -A 10 '\[colors.normal\]' $alacritty_config | grep 'red =' | head -1 | sed 's/.*= "\(.*\)"/\1/')


    set -l bright_blue (grep -A 10 '\[colors.bright\]' $alacritty_config | grep 'blue =' | head -1 | sed 's/.*= "\(.*\)"/\1/')
    set -l bright_white (grep -A 10 '\[colors.bright\]' $alacritty_config | grep 'white =' | head -1 | sed 's/.*= "\(.*\)"/\1/')
    set -l bright_foreground (grep 'bright_foreground' $alacritty_config | head -1 | sed 's/.*= "\(.*\)"/\1/')

    # Fallback colors if reading fails
    if test -z "$bright_red"
        set bright_red '#f6998f'
    end

    if test -z "$bright_blue"
        set bright_blue '#b0a4c3'
    end
    if test -z "$bright_white"
        set bright_white '#dcd2ce'
    end
    if test -z "$bright_foreground"
        set bright_foreground '#dcd2ce'
    end

    echo -n -s \
        (set_color -b $bright_red) (set_color $bright_foreground) " 💀 AVARI " \
        (set_color -b $bright_blue) (set_color $bright_red) "" \
        (set_color -b $bright_blue) (set_color $bright_foreground) " " (prompt_pwd) " " \
        (set_color -b normal) (set_color $bright_blue) "" \
        $normal (fish_vcs_prompt) $normal " " $prompt_status
        
end
