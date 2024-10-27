# Домашняя работа №1 по дисциплине "Системное программное обеспечение"

## Задача
- Найти какой-либо проект на GitHub
- Запустить найденный проекст с помощью Docker

## Решение

### 1. Используемый проект
Для примера мной был взят проект, который реализует веб приложение магазина электронных книг
`https://github.com/diyajaiswal11/BookStore`

### 2. Клонирование проекта
Сначала был склонирован выбранный проект
```
git clone https://github.com/diyajaiswal11/BookStore
```
Файлы склонированного проекта переместила в отдельный новый проект

### 3. Изменение версии psycopg2 в файле requirements.txt
В файле было изменен psycopg2==2.8.5 на psycopg2-binary==2.8.5

### 4. Добавление разрешенного порта
В файле bookstore/settings.py в строке 28 делаем ALLOWED_HOSTS = ["0.0.0.0", "127.0.0.1", "localhost", "*"]

### 5. Создание Dockerfile
В корне проекта создаем файл Dockerfile с данным содержимым
```
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
```

### 6. Создание и запуск контейнера

Сначала соберем проект с помощью команды
```
docker build -t books_webserver .
```

Запустим контейнер с помощью команды
```
docker run -d -p 8080:8080 books_webserver
```
