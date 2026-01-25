function mvs --description "Переместить папку и создать симлинк на ее месте"
    # Проверка: передано ли ровно 2 аргумента
    if test (count $argv) -ne 2
        echo "Ошибка: Нужно указать 2 аргумента."
        echo "Использование: mvs <что_переносим> <куда_переносим>"
        return 1
    end

    # Очищаем пути от лишних слешей в конце для корректной работы basename
    set -l source (string trim -r -c / $argv[1])
    set -l dest_dir (string trim -r -c / $argv[2])
    
    # Проверка на существование исходной папки
    if not test -e "$source"
        echo "Ошибка: Исходный путь '$source' не существует."
        return 1
    end

    # Получаем только имя папки (например, 'fish' из '.config/fish')
    set -l folder_name (basename "$source")
    # Формируем полный путь, где папка будет лежать физически
    set -l full_dest "$dest_dir/$folder_name"

    # 1. Перемещаем папку
    # Используем кавычки "$...", чтобы пути с пробелами не ломали команду
    if mv "$source" "$dest_dir/"
        # 2. Создаем симлинк, если перемещение прошло успешно
        if ln -s "$full_dest" "$source"
            echo "Успех: $source теперь ссылается на $full_dest"
        else
            echo "Ошибка при создании симлинка."
            return 1
        end
    else
        echo "Ошибка при перемещении папки."
        return 1
    end
end
