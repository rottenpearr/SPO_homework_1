# Домашняя работа №1 по дисциплине "Системное программное обеспечение"

## Задача:
- Найти какой-либо проект на GitHub
- Запустить найденный проекст с помощью Docker

## Решение:

### Для примера мной был взят проект, который реализует веб приложение магазина электронных книг
`https://github.com/diyajaiswal11/BookStore`

### Сначала был склонирован выбранный проект
```
git clone https://github.com/diyajaiswal11/BookStore
```
Файлы склонированного проекта переместила в отдельный новый проект

### В файле было изменен psycopg2==2.8.5 на psycopg2-binary==2.8.5

### В файле bookstore/settings.py в строке 28 делаем ALLOWED_HOSTS = ["0.0.0.0", "127.0.0.1", "localhost", "*"]

### 5. В корне проекта создаем файл Dockerfile с данным содержимым
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

### Сначала соберем проект с помощью команды
```
docker build -t books_webserver .
```

### Запустим контейнер с помощью команды
```
docker run -d -p 8080:8080 books_webserver
```

### После запуска можно перейти по ссылке `http://localhost:8080` и проверить работоспособность проекта

Для входа нужно зарегистрироваться или авторизоваться

![Регистрация](https://github.com/rottenpearr/SPO_homework_1/blob/master/example/1.png)

![Авторизация](https://github.com/rottenpearr/SPO_homework_1/blob/master/example/2.png)

### На сайте можно искать и скачивать книги

![Главная](https://github.com/rottenpearr/SPO_homework_1/blob/master/example/3.png)

![Раздел "Все книги"](https://github.com/rottenpearr/SPO_homework_1/blob/master/example/4.png)

### Также книги можно добавлять в понравившиеся

![Добавление в понравившиеся](https://github.com/rottenpearr/SPO_homework_1/blob/master/example/5.png)

![Раздел понравившихся](https://github.com/rottenpearr/SPO_homework_1/blob/master/example/6.png)

### На сайте имеется функция добавления своих электронных книг

![Добавление своей книги](https://github.com/rottenpearr/SPO_homework_1/blob/master/example/7.png)

## Автор

### Работу выполнила Маркова Алёна Денисовна, студент группы Фт-320008.
