function fish_prompt -d "Write out the prompt"
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`
    printf '%s@%s %s%s%s > ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

if status is-interactive # Commands to run in interactive sessions can go here

    # No greeting
    set fish_greeting
        
    # Android Emulator для Hyprland/Wayland
    set -x QT_QPA_PLATFORM xcb
    set -x ANDROID_EMULATOR_USE_SYSTEM_LIBS 1
    set -x JAVA_HOME /usr/lib/jvm/default

    # Use starship
    starship init fish | source
    if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
        cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    end

    # Aliases
    alias pamcan pacman
    alias clear "printf '\033[2J\033[3J\033[1;1H'"
    alias q 'qs -c ii'
    alias ll='eza -lh --git --icons'
    alias la='eza -lha --git --icons'
    alias lt='eza -T --level=3 --icons --git-ignore'
    alias ls='eza --icons'
    alias v='nvim'
    alias leet='nvim leetcode.nvim' # Зпускает leetcode плагин в nvim
    alias pip-video 'nohup mpv --no-border --autofit=360x203 --geometry=100%:100% --ontop --force-window=yes --osd-level=0 --loop-file=inf $argv >/dev/null 2>&1 &; disown'
end
