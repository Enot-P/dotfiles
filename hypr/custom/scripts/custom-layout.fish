#!/usr/bin/fish

# --- НАСТРОЙКИ ---
set SOCKET "/tmp/mykitty"
set VIDEO_URL "https://www.youtube.com/watch?v=jfKfPfyJRdk"
set WINDOW_TITLE "PiP Video"
set EDITOR_TITLE "EditorWindow"

# 0. Отключаем мышь, чтобы она не сбивала фокус
hyprctl keyword input:follow_mouse 0

# 1. Подготовка воркспейса
hyprctl dispatch workspace 2
sleep 0.2

# 2. Запускаем Редактор
hyprctl dispatch exec "[workspace 2] kitty --class editor_kitty --listen-on unix:$SOCKET --title '$EDITOR_TITLE'"

# Ждем появления nvim
while not hyprctl clients -j | jq -e ".[] | select(.class == \"editor_kitty\")" >/dev/null
    sleep 0.1
end

# 3. Запуск nvim
hyprctl dispatch focuswindow class:editor_kitty
kitty-control -s $SOCKET -c "send-text tmux\r" 
sleep 0.2
kitty-control -s $SOCKET -c "send-text nvim\r" 
sleep 0.2

# 4. Запускаем второй терминал (साइड-китти)
# Используем флаг [right], чтобы он точно встал справа
hyprctl dispatch exec "[right] kitty --class side_kitty"

# Ждем, пока он реально появится, и получаем его уникальный адрес
set SIDE_ADDR ""
while test -z "$SIDE_ADDR"
    set SIDE_ADDR (hyprctl clients -j | jq -r '.[] | select(.class == "side_kitty") | .address')
    sleep 0.1
end

# 5. Настраиваем пропорции (nvim слева)
hyprctl dispatch focuswindow address:$SIDE_ADDR
hyprctl dispatch splitratio 0.594
sleep 0.2

# 6. ЗАПУСК WAYDROID
hyprctl dispatch exec "env QT_QPA_PLATFORM=xcb waydroid > /tmp/waydroid_log.txt 2>&1"
# hyprctl dispatch exec "env QT_QPA_PLATFORM=xcb flutter emulators --launch Small_Phone > /tmp/emulators_log.txt 2>&1"

# 7. ЗАПУСК ВИДЕО ЧЕРЕЗ АДРЕС ОКНА
# Мы берем адрес side_kitty и говорим: "Сделай сплит вниз ТУТ"
hyprctl --batch "dispatch focuswindow address:$SIDE_ADDR ; dispatch layoutmsg preselect d"
sleep 0.1

# Запускаем видео. Флаг --no-terminal ускоряет запуск mpv.
hyprctl dispatch exec "mpv --no-border --title='$WINDOW_TITLE' '$VIDEO_URL'"

# 8. Ждем появления видео
set attempt 0
while test $attempt -lt 40
    if hyprctl clients -j | jq -e ".[] | select(.title == \"$WINDOW_TITLE\")" >/dev/null
        break
    end
    # Каждые 0.3 сек подтверждаем, что мы хотим видео именно под side_kitty
    hyprctl dispatch focuswindow address:$SIDE_ADDR
    sleep 0.3
    set attempt (math $attempt + 1)
end

# 9. Финальная настройка размеров
hyprctl dispatch focuswindow address:$SIDE_ADDR
hyprctl dispatch splitratio 0.57

# 10. Возвращаем фокус в nvim и включаем мышь
hyprctl dispatch focuswindow class:editor_kitty
hyprctl keyword input:follow_mouse 1

echo "Готово. Видео должно быть под правым терминалом."
