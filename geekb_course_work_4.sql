create database geekb;
use geekb;
show TABLES;

-- Таблица Пользователей
DROP TABLE IF EXISTS users;
CREATE TABLE users (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY key COMMENT "Идентификатор строки",
first_name VARCHAR(100) NOT null COMMENT "Имя пользователя", 
last_name VARCHAR(100) NOT null COMMENT "Фамилия пользователя",
email VARCHAR(100) NOT null COMMENT "Почта",
phone VARCHAR(100) NOT null COMMENT "Телефон",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
update_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Пользователи";
select  * from users where created_at > update_at;-- Используем фильтр для поиска дат update более ранних чем дата created
update users set update_at = NOW() where created_at > update_at; -- Запрос на ОБНОВЛЕНИЕ

-- Добавим к сгенерированным пользотелям, ДВУХ РЕАЛЬНЫХ (см. табл. группы)
update users set first_name = 'Виктор', last_name = 'Шупоченко' where users.id = 1;
update users set first_name = 'Михаил', last_name = 'Демин' where users.id = 2;

desc users;
SELECT * from users;


-- Таблица Профилей
DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
user_id INT UNSIGNED NOT NULL PRIMARY key COMMENT "Ссылка на пользователя",
gender CHAR(1) NOT null COMMENT "Пол",
birthday DATE COMMENT "Дата рождения",
city VARCHAR(130) NOT null COMMENT "Город проживания",
country VARCHAR(130) NOT null COMMENT "Страна проживания",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
update_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Профили";

select  * from profiles where created_at > update_at;-- Используем фильтр для поиска дат update более ранних чем дата created
update profiles set update_at = NOW() where created_at > update_at; -- Запрос на ОБНОВЛЕНИЕ

-- Меняем в gender тип данных CHAR(1) на ENUM 
ALTER TABLE profiles MODIFY COLUMN gender ENUM('m', 'w');

SELECT * from  profiles;
describe  profiles;

-- Создаем Внешние Ключи таблицы profiles
desc profiles;
select * from profiles limit 10;
alter TABLE profiles
ADD CONSTRAINT profiles_user_id_fk
foreign KEY (user_id) REFERENCES users(id)
on delete CASCADE;



-- Таблица Учебный год (sessions)
-- таблица: Тема курса с названием темы для каждой четверти
DROP TABLE IF EXISTS sessions;
CREATE TABLE sessions (
  id INT unsigned not null auto_increment PRIMARY KEY,
  user_id INT unsigned,
  topic VARCHAR(100) NOT null COMMENT "Тема курса",
  topic_quarters VARCHAR(50) NOT null COMMENT "Тема четверти",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id)
) COMMENT = 'Учебный год. Python - разработки';
desc sessions;
INSERT into sessions (topic, topic_quarters)
VALUES
  ('Python - разработки', 'Введение в Backend-разработку'),
  ('', 'Frontend и Backend интернет-магазина'),
  ('', 'Сетевой чат'),
  ('', 'Командная разработка выпускного проекта');
 -- Присваиваем значение для user_id вместо NULL
-- ALTER TABLE communities add name_teacher_id INT unsigned after id;
-- update sessions set user_id = sessions.id;
desc sessions;
SELECT * from sessions;

select * from sessions limit 10;
alter TABLE sessions
ADD CONSTRAINT sessions_user_id_fk
foreign KEY (user_id) REFERENCES users(id)
on delete CASCADE;


-- Таблица курса ПЕРВОЙ четверти introduction_backend_developments
DROP TABLE IF EXISTS introduction_backend_developments;
CREATE TABLE introduction_backend_developments (
  id INT unsigned not null auto_increment PRIMARY KEY,
  user_id INT unsigned,
  session_id INT unsigned COMMENT "Номер четверти",
  python VARCHAR(150) NOT null COMMENT "Основы языка Python",
  linux VARCHAR(150) NOT null COMMENT "Linux. Рабочая станция",
  mysql VARCHAR(150) NOT null COMMENT "Основы реляционных баз данных. MySQL",
  algorithm_structure_python VARCHAR(150) NOT null COMMENT "Алгоритмы и структуры данных на Python. Базовый курс",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id)
) COMMENT = 'Введение в Backend-разработку';
desc introduction_backend_developments;
INSERT into introduction_backend_developments (user_id, session_id, python, linux, mysql, algorithm_structure_python)
VALUES
  (1, 1, 'Знакомство с Python', 'Введение. Установка ОС', 'Установка окружения. DDL - команды', 'Введение в алгоритмизацию и реализация простых алгоритмов на Python'),
  (2, 2 , 'Встроенные типы и операции с ними', 'Настройка и знакомство с интерфейсом командной строки', 'Управление БД. Язык запросов SQL', 'Циклы. Рекурсия. Функции.'),
  (3, 3, 'Функции',  'Пользователи. Управление Пользователями и группами', 'Введение в проектирование БД', 'Массивы. Кортежи. Множества. Списки.'),
  (4, 4, 'Полезные инструменты', 'Загрузка ОС и процессы', 'CRUD-операции', 'Эмпирическая оценка алгоритмов на Python'),
  (5, null, 'Работа с файлами', 'Устройство файловой системы Linux. Понятие Файла и каталога', 'Видеоурок. Операторы, фильтрация, сортировка и ограничение. Агрегация данных', 'Коллекции. Список. Очередь. Словарь.'),
  (6, null, 'Объектно-ориентированное программирование', 'Введение в скрипты bash. Планировщики задач crontab и a', 'Вебинар. Операторы, фильтрация, сортировка и ограничение. Агрегация данных', 'Работа с динамической памятью'),
  (7, null, 'ООП. Продвинутый уровень', 'Управление пакетами и репозиториями. Основы сетевой безопасности', 'Видеоурок. Сложные запросы', 'Алгоритмы сортировки'),
  (8, null, 'ООП. Полезные дополнения', 'Введение в docker', 'Вебинар. Сложные запросы', 'Деревья. Хэш-функция'),
  (9, null, '', '', 'Видеоурок. Транзакции, переменные, представления. Администрирование. Хранимые процедуры и функции, триггеры', ''),
 (10, null,  '', '', 'Вебинар. Транзакции, переменные, представления. Администрирование. Хранимые процедуры и функции, триггеры', ''),
 (11, null, '', '', 'Видеоурок. Оптимизация запросов. NoSQL', ''),
 (12, null, '', '', 'Вебинар. Оптимизация запросов', '');
desc introduction_backend_developments;
select * from introduction_backend_developments;

-- Создаем Внешний Ключ таблицы introduction_backend_developments
alter TABLE introduction_backend_developments
ADD CONSTRAINT introduction_backend_developments_user_id_fk
foreign KEY (user_id) REFERENCES users(id)
on delete CASCADE;
alter TABLE introduction_backend_developments
ADD CONSTRAINT introduction_backend_developments_session_id_fk
foreign KEY (session_id) REFERENCES sessions(id)
on delete CASCADE;


-- Таблица успеваемости (progress)
DROP TABLE IF EXISTS progress;
CREATE TABLE progress (
  id INT unsigned not null auto_increment PRIMARY KEY,
  user_id INT unsigned not null,
  introduction_backend_development_id INT unsigned not null COMMENT "Оценка",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id)
) COMMENT = 'Успеваемость';
INSERT into progress (id, user_id, introduction_backend_development_id)
VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5);
desc progress;
select * from progress;

-- Создаем Внешний Ключ таблицы progress
alter TABLE progress
ADD CONSTRAINT progress_introduction_backend_development_id_fk
foreign KEY (introduction_backend_development_id) REFERENCES introduction_backend_developments(id)
on delete CASCADE;



-- Таблица сообщений (messages)
DROP TABLE IF EXISTS messages;
create table messages (
id INT unsigned not null auto_increment primary key,
from_user_id INT unsigned not null COMMENT "Ссылка на отправителя сообщения",
to_user_id INT unsigned not null COMMENT "Ссылка на получателя сообщения",
body TEXT COMMENT "Текст сообщения",
is_important BOOLEAN COMMENT "Признак важности",
is_delivered BOOLEAN COMMENT "Признак доставки",
create_at DATETIME default CURRENT_TIMESTAMP COMMENT "Время создания строки"
) COMMENT "Сообщения";
desc messages;
SELECT * FROM messages limit 15;

-- Таблица messages Создаем Внешние Ключи
alter TABLE messages
add CONSTRAINT messages_from_user_id_fk
foreign KEY (from_user_id) REFERENCES users(id)
on delete cascade,
add CONSTRAINT messages_to_user_id_fk
foreign KEY (to_user_id) REFERENCES users(id)
on delete CASCADE;


-- Создаем таблицу "Группы-курса" с РЕАЛЬНЫМИ Имя-Фамилия преподавателей и студентов
DROP TABLE IF EXISTS communities;
create table communities (
id INT unsigned auto_increment not null primary key COMMENT "Идентификатор строки",
course_communities VARCHAR(50) COMMENT "Список группы курса",
created_at DATETIME default CURRENT_TIMESTAMP COMMENT "Время создания строки",
update_at DATETIME default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Группа курса";

SELECT * FROM communities limit 19;
-- Внесем Имя-Фамилия преподавателей и студентов
INSERT into communities (course_communities) 
values
  ('Виктор Щупоченко'),
 ('Александр Васильченко'),
 ('Владислав Колокольчиков'),
 ('Павел Тиняков'),
('Сергей Романов'),
('Альбина Гилязова'),
  ('Михаил Демин'),
 ('Алексей Ероховец'),
 ('Андрей Синицын'),
 ('Роман Аширов'),
('Владимир Черненко'),
('Владислав Семилетов'),
 ('Артем Оболенский'),
 ('Шахин Авад'),
 ('Александра Науменко'),
 ('Антон Дмитриев'),
('Андрей Мусатов'),
('Екатерина Лобанова'),
 ('Сергей Зонов');

SHOW COLUMNS FROM communities;
desc communities;
SELECT * FROM communities limit 15;


-- Таблица связи пользотелей и групп 
drop table if exists communities_users;
create table communities_users (
-- id INT unsigned auto_increment not null primary key COMMENT "Идентификатор строки",
users_id INT unsigned not null COMMENT "Ссылка на пользователя",
communities_id INT unsigned not null COMMENT "Ссылка на группу",
created_at DATETIME default CURRENT_TIMESTAMP COMMENT "Время создания строки",
primary key (communities_id, users_id) COMMENT "Составной первичный ключ"
) COMMENT "Участники групп, связь между пользователями и группами";

INSERT into communities_users (users_id, communities_id) 
values
  (1, 1),
 (2, 2),
 (3, 3),
 (4, 4),
(5, 5);
desc communities_users;
SELECT * FROM communities_users;

-- Создаем Внешние Ключи для communities_users
alter TABLE communities_users
ADD CONSTRAINT communities_users_users_id_fk
foreign KEY (users_id) REFERENCES users(id)
on delete cascade;
alter TABLE communities_users
ADD CONSTRAINT communities_users_communities_id_fk
foreign KEY (communities_id) REFERENCES communities(id)
on delete CASCADE;



-- Таблица учебных материаллов study_materials_1
DROP TABLE IF EXISTS study_materials_1;
create table study_materials_1 (
id INT unsigned not null auto_increment primary key COMMENT "Идентификатор строки",
user_id INT unsigned not null COMMENT "Ссылка на пользователя, который загрузил файл",
introduction_backend_development_id INT unsigned not null COMMENT "Ссылка на тему курса",
filename VARCHAR(250) not null COMMENT "Путь к файлу",
size INT not null COMMENT "Размер файла",
metadata JSON COMMENT "Метаданные файла",
created_at DATETIME default CURRENT_TIMESTAMP COMMENT "Ссылка на тип контента",
update_at DATETIME default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "учебные материаллы";

show tables;
SELECT * FROM study_materials_1;
DESC study_materials_1;

-- UPDATE study_materials SET user_id = FLOOR(1 + RAND() * 100);
-- update study_materials_1 set study_materials_1.id = user_id;

-- СТОЛБЕЦ filename 
-- Где взять расширение? 
-- http://dropbox.com/vk/filename.ext Прописываем путь: имяфайлаИЗтаблицы.случайное расширение
 -- Создаем ВРЕМЕННУЮ таблицу
DROP TABLE IF EXISTS extensions;
CREATE temporary table extensions (name VARCHAR(10));
insert into extensions 
values ('jpeg'), ('png'), ('mp4'), ('mp3'), ('avi'), ('txt'), ('doc'), ('docx'), ('sql'), ('odp'), ('pptx');
select * from extensions;

-- Компануем основной запрос 
update study_materials_1 set filename = concat(
-- Функция concat объеденяет все свои параметры, перечисленные через ЗАПЯТУЮ в ОДНУ строку. Т.е. объеденяет 4 строки (см. следующие ниже) в одну.
'http://dropbox.com/vk/',
filename,
'.',
(select name from extensions order BY RAND() limit 1))-- строка расширения. Сами расширения см. во временной (extensions) таблице
;
SELECT * FROM study_materials_1;

-- СТОЛБЕЦ metadata
-- Сюда помещае любой объект.
-- Должно получиться что-то вроде: '{"ouner": "Ferst Last"}', т.е. '{"КЛЮЧ": "ЗНАЧЕНИЕ - Имя Фамилия"}'
update study_materials_1 set metadata = CONCAT(
-- update media - запрос на обновление и вставляем (set) для столбца metadata ключ-значение ОДНУ строку из нескольких.
'{"ouner": "',
(select CONCAT(first_name, ' ', last_name)-- Имя и фамилию берем из табл. users 
from users where users.id = study_materials_1.user_id),
'"}'
);
select * from study_materials_1 limit 20;
desc study_materials_1;

-- Меняем в metadata Type (longtext) на Type (JSON). Т.е. возвращаем, подмененный, КОРРЕКТНЫЙ тип данных.
-- См. 8-ю стр вебинара 4 (1:11:35)

 alter table study_materials_1 modify COLUMN metadata JSON; 

ALTER TABLE study_materials_1 drop column introduction_backend_development_id;
ALTER TABLE study_materials_1 add introduction_backend_development_id INT unsigned after user_id;
update study_materials_1 set introduction_backend_development_id = study_materials_1(id);


-- Создаем Внешние Ключи для study_materials_1
alter TABLE study_materials_1
ADD CONSTRAINT study_materials_1_introduction_backend_development_id_fk
foreign KEY (introduction_backend_development_id) REFERENCES introduction_backend_developments(id)
on delete CASCADE;



-- Таблица типов учебных материаллов
show tables;
select * from study_materials_types;
drop table if exists study_materials_types;
CREATE TABLE study_materials_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  study_material_1_id INT unsigned COMMENT "Ссылка на таблицу учебных материаллов (study_materials)",
  name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название типа",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Типы учебных материаллов";
insert into study_materials_types (study_material_1_id, name) values
(1, 'document'),
(2, 'presentation'),
(3, 'video');
-- select  * from study_materials_types where created_at > updated_at; -- Используем фильтр для поиска дат update более ранних чем дата created
-- update study_materials_types set updated_at = NOW() where created_at > updated_at; 
desc study_materials_types;
select * from study_materials_types;


-- Создаем Внешние Ключи для study_materials_types
alter TABLE study_materials_types
ADD CONSTRAINT study_materials_types_study_material_1_id_fk
foreign KEY (study_material_1_id) REFERENCES study_materials_1(id)
on delete CASCADE;



-- ***********************************************************************************************
-- ***********************************************************************************************

-- UNION объединение
select topic from sessions
union
select python from introduction_backend_developments;
-- А, можно ли сохранить объединенную таблицу, как таблицу?


-- Вложенный запрос
select * from sessions;
-- Два аналогичных запроса
select id, topic, topic_quarters from sessions where topic_quarters = 'Введение в Backend-разработку';
-- select id, topic, topic_quarters  from sessions where id = 1;-- Вызов ОДНОГО значения.
-- select id, topic, topic_quarters  from sessions where id in (1, 2);-- Вызов ДВУХ значений. Исп-я IN !!!!!
-- select id, python from introduction_backend_developments where id in (1,2,3,4,5,6,7,8);
select id, topic, topic_quarters from sessions
-- Извлечем первичный ключ табл. sessions, соответсвующий "Введение в Backend-разработку"
-- Превращаем этот запрос во вложенный запрос
where id = (select id from sessions where topic_quarters = 'Введение в Backend-разработку');


-- JOIN соединение таблиц 
select * from sessions;
select * from introduction_backend_developments;

-- Простое объединение (всех столбцов) двух даблиц 
select sessions.*, introduction_backend_developments.* from sessions join introduction_backend_developments;
-- Т.е. каждая строка ЛЕВОЙ табл. объединяется с КАЖДОЙ строкой правой (1-я строка ЛЕВОЙ соединяется с каждой из 8-ми
-- строк правой. 2-я строка - ток же. И так далее.

-- ВНУТРЕННЕЕ объединение (INNER JOIN, можно просто JOIN).  Исп-ся, когда необходимо получить пересечение данных
-- Объединение столбцов КОНКРЕТНЫХ столцов этих таблиц
-- НО все еще каждой строке ЛЕВОЙ табл. приводится по ЧЕТЫРЕ строки ПРАВОЙ
select sessions.id, sessions.topic, sessions.topic_quarters,
introduction_backend_developments.python, introduction_backend_developments.linux, 
introduction_backend_developments.mysql, introduction_backend_developments.algorithm_structure_python
from sessions join introduction_backend_developments;
-- Т.е. Мало полезно и информативно
-- Используем where для вывода КОНКРЕТНЫХ значений в нормальном виде
select sessions.id as id, sessions.topic as 'Имя курса', sessions.topic_quarters as 'Темы курса',
introduction_backend_developments.python as python, introduction_backend_developments.linux as linux, 
introduction_backend_developments.mysql as mysql, introduction_backend_developments.algorithm_structure_python as algorithm_structure_python
from sessions join introduction_backend_developments where sessions.id = introduction_backend_developments.id;
-- Следует исп-ть ON вместо WHERE. Аналог, просто более быстрый.


-- ВНЕШНЕЕ ЛЕВОЕ объединение LEFT OUTER JOIN (LEFT JOIN).
-- Слышипь: ВСЕ, ВСЕХ значит ВНЕШНЕЕ объединение

-- Выводим перечень ВСЕХ уроков по теме 1-ой четверти СЛЕВА и названия курсов справа
-- Т.е. Выводим содержимое ВСЕХ строк табл introduction_backend_developments СЛЕВА
select * from sessions;
select * from introduction_backend_developments;
SELECT
  introduction_backend_developments.python, introduction_backend_developments.linux,
  introduction_backend_developments.mysql, introduction_backend_developments.algorithm_structure_python,
  sessions.topic_quarters
FROM
  introduction_backend_developments
LEFT JOIN
 sessions
ON
  sessions.id =  introduction_backend_developments.session_id;
-- Поменяв местами таблицы относительно left join получим аналог right JOIN
 
-- ВНЕШНЕЕ ПРАВОЕ объединение RIGHT OUTER JOIN (RIGHT JOIN).
-- Т.е. Выводим содержимое ВСЕХ строк табл sessions СПРАВА
 select * from sessions;
select * from introduction_backend_developments;
SELECT
  introduction_backend_developments.python, introduction_backend_developments.linux,
  introduction_backend_developments.mysql, introduction_backend_developments.algorithm_structure_python,
  sessions.topic_quarters
FROM
  introduction_backend_developments
RIGHT JOIN
 sessions
ON
  sessions.id =  introduction_backend_developments.session_id;
 
  

-- Выборка учебных материалов пользователя с id = 11
SELECT study_materials_1.id, users.first_name, users.last_name, study_materials_1.filename, study_materials_1.created_at
  FROM study_materials_1
    JOIN users
      ON study_materials_1.user_id = users.id     
  WHERE study_materials_1.user_id = 11;
 
  
 -- Сообщения от пользователя (teacher - Александр Васильченко)
SELECT communities.course_communities, messages.body, messages.create_at
  FROM messages
    JOIN communities
      ON communities.id = messages.to_user_id
  WHERE communities.id = 2;
  
 -- Сообщения к пользователю (student - Алексей Ероховец)
SELECT communities.course_communities, messages.body, messages.create_at
  FROM messages
    JOIN communities
      ON communities.id = messages.from_user_id
  WHERE communities.id = 8;

-- Объединяем все сообщения от пользователя и к пользователю
SELECT 
  messages.from_user_id, communities.course_communities AS from_user,
  messages.to_user_id, communities.course_communities AS to_user,     
  messages.body, messages.create_at
  FROM communities
    JOIN messages
      ON communities.id = messages.to_user_id
        OR communities.id = messages.from_user_id
    JOIN communities users_from
      ON communities.id = messages.from_user_id
    JOIN communities users_to
      ON communities.id = messages.to_user_id
  WHERE communities.id = 3;
--  ????????????????????????????????????????????????????????? ПУСТОЙ РЕЗУЛЬТАТ



/*!!!!!!!!!!!!!!!!!!!!!!!! ПРЕДСТАВЛЕНИЯ !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 * 
 * Представления - еще один способ организации данных в языке запросов SQL.
 * Представление — это запрос на выборку SELECT, которому присваивается уникальное имя
 * и который можно сохранять или удалять из базы данных 
 * как обычную хранимую процедуру.
 * С помощью SELECT выбираются данные и помещаются в представление. Когда данные в исходных таблицах изменятся, 
 * то они поменяются и в представлении.
 * Представления позволяют увидеть результаты сохраненного запроса таким образом, как будто это полноценная 
 * таблица базы данных. Представления позволяют более гибко управлять правами доступа к таблицам: можно запретить 
 * прямое обращение пользователей к таблицам, и разрешить доступ только к представлениям.

 * Для создания представления используется команда CREATE VIEW, после которой мы указываем 
 имя представления products_catalogs. Затем после ключевого слова AS пишем запрос представления.
*/
  
 -- представление всех столбцов отсортированной таблицы sessions
CREATE VIEW representation_1 AS SELECT * FROM sessions ORDER BY topic;
SELECT * FROM representation_1;
 -- представление 2-х столбцов отсортированной таблицы sessions
CREATE VIEW representation AS SELECT id, topic FROM sessions ORDER BY topic;
SELECT * FROM representation;
-- представление 2-х столбцов и замена их имени отсортированной таблицы sessions
CREATE VIEW representation_2 (quarter_number, topic) AS SELECT id, topic FROM sessions ORDER BY topic;
SELECT * FROM representation_2;-- Можно эти столбцы поменять местами
-- Изменим это представление
ALTER VIEW representation_2 (quarter_number, topic) AS SELECT id, topic FROM sessions ORDER BY id;
SELECT * FROM representation_2;
-- Удалим это представление
DROP VIEW if exists representation_2;-- if exists - добавляется, что бы не появлялось сообщение о ошибке, если
-- удалается НЕсуществующие представление

-- Представление вывода назвния курса, всех тем курса и содержание занятий 1-ой четверти
CREATE OR REPLACE VIEW representation_3 as-- REPLACE view - замена, существующего представления.
select sessions.topic as 'Назвние курса', sessions.topic_quarters as 'Все темы курса', 
introduction_backend_developments.python as 'Тема: python', introduction_backend_developments.linux as 'Тема: linux', 
introduction_backend_developments.mysql as 'Тема: mysql', 
introduction_backend_developments.algorithm_structure_python as 'Тема: algorithm_structure_python'
from sessions join introduction_backend_developments
on introduction_backend_developments.session_id = sessions.id; 
SELECT * FROM representation_3;

SELECT * FROM sessions;
SELECT * FROM introduction_backend_developments;



-- Хранимые процедуры / триггеры
/*
 * Хранимые процедуры и функции позволяют сохранить последовательность SQL-операторов и 
 * вызывать их по имени функции или процедуры:
CREATE PROCEDURE procedure_name
CREATE FUNCTION function_name
Разница между процедурой и функцией заключается в том, что функции возвращают значение и 
их можно встраивать в SQL-запросы, в то время как хранимые процедуры вызываются явно.

Синтаксис
CREATE PROCEDURE ИМЯ ПРОЦЕДУРЫ (входящие и исходящие параметры)
BEGIN
  SELECT VERSION();
END
Между ключевыми словами BEGIN и END размещаются SQL-команды, которые выполняются всякий раз 
при вызове хранимой процедуры.

CALL ИМЯ ПРОЦЕДУРЫ (входящие и исходящие параметры); - Вызов Процедуры
SELECT ИМЯ ФУНКЦИИ (входящие и исходящие параметры); - Вызов Функции
SHOW PROCEDURE STATUS - список хранимых процедур 
SELECT name, type FROM mysql.proc LIMIT 10; Но это ЛУЧШЕ!!!!
SHOW FUNCTION STATUS
 * 
*/


DROP PROCEDURE IF EXISTS users_numb_string;
DELIMITER //
CREATE PROCEDURE users_numb_string (OUT amount INT)
BEGIN
  SELECT COUNT(*) INTO amount FROM users_numb_string;
END//





