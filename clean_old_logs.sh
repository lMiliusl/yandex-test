#!/bin/bash

# Получаем переменные
echo "Укажите директорию с логами"
read LOG_DIR

# Проверка, что директория существует
if [ ! -d "$LOG_DIR" ]; then
    echo "Ошибка: директория '$LOG_DIR' не существует."
    exit 1
fi

echo "Укажите количество дней (файлы старше этого будут удалены)"
read DAYS

# Проверка, что DAYS — число
if ! [[ "$DAYS" =~ ^[0-9]+$ ]]; then
    echo "Ошибка: количество дней должно быть числом."
    exit 1
fi

# Поиск файлов
FILES=$(find "$LOG_DIR" -type f -name "*.log" -mtime +"$DAYS")

# Если файлов нет
if [ -z "$FILES" ]; then
    echo "Файлы .log старше $DAYS дней не найдены."
    exit 0
fi

# Если файлы найдены, выводим их
echo "Найдены следующие файлы:"
echo "$FILES"
echo

# Запрос подтверждения
read -p "Удалить эти файлы? (y/n): " CONFIRM

case "$CONFIRM" in
    y|Y)
        echo "Удаление файлов..."
        echo "$FILES" | xargs rm -f
        echo "Готово."
        ;;
    n|N)
        echo "Удаление отменено."
        ;;
    *)
        echo "Некорректный ввод. Завершение."
        exit 1
        ;;
esac
