#!/usr/bin/fish

# 1. Переходим на воркспейс 2
hyprctl dispatch workspace 2
sleep 0.2

# 2. Запускаем Kitty с удаленным управлением
# В Fish переменные пишутся через set, но в строках можно и так
set SOCKET "unix:/tmp/mykitty"
hyprctl dispatch exec "kitty --listen-on $SOCKET --title 'EditorWindow'"
sleep 0.2

# 3. Запускаем второй терминал
hyprctl dispatch exec kitty
sleep 0.2

# 4. Настраиваем пропорции
hyprctl dispatch splitratio 0.594
sleep 0.3


#5.1 Запускаем терминал
# hyprctl dispatch exec kitty
# sleep 0.3

# 5.2 Запускаем видео
set VIDEO_URL "https://www.youtube.com/watch?v=qk8ZnWirWD8"
set WINDOW_TITLE "PiP Video"

hyprctl dispatch exec "nohup mpv \
    --no-border \
    --autofit=360x203 \
    --geometry=100%:100% \
    --ontop \
    --force-window=yes \
    --osd-level=0 \
    --loop-file=inf \
    --title='$WINDOW_TITLE' \
    '$VIDEO_URL' >/dev/null 2>&1 &"

sleep 0.7

set max_attempts 350
set attempt 0

while test $attempt -lt $max_attempts
    set exists (hyprctl clients -j | jq --arg title "$WINDOW_TITLE" \
        '.[] | select(.title == $title) | .address' | count)

    if test $exists -gt 0
        echo "Окно видео появилось (jq)"
        break
    end

    sleep 0.22
    set attempt (math $attempt + 1)
end

if test $attempt -eq $max_attempts
    echo "Окно не появилось за ~7–8 секунд"
end

sleep 0.25

# 6. Манипуляции с фокусом
hyprctl dispatch movefocus u
# sleep 0.5
hyprctl dispatch splitratio +0.57
sleep 0.3
# 7. ЗАПУСК ЭМУЛЯТОРА
# Теперь это сработает, так как скрипт исполняется в fish
# hyprctl dispatch exec "env QT_QPA_PLATFORM=xcb flutter emulators --launch Medium_Phone > /tmp/flutter_log.txt 2>&1"
# hyprctl dispatch exec "env QT_QPA_PLATFORM=xcb waydroid > /tmp/waydroid_log.txt 2>&1"

# 8. Выполнение комманд в терминале
kitty-control -s /tmp/mykitty -c "send-text nvim\r" 
