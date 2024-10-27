# Используем базовый образ Python
FROM python:3.7.4-slim

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем файл requirements.txt и устанавливаем зависимости
COPY requirements.txt requirements.txt
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Копируем приложение в рабочую директорию
COPY . .

# Инициализация базы данных
RUN python manage.py makemigrations
RUN python manage.py migrate

# Запуск сервера
CMD ["python", "manage.py", "runserver", "0.0.0.0:8080"]

# Открываем порт
EXPOSE 8080
