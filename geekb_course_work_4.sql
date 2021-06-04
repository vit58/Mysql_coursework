create database geekb;
use geekb;
show TABLES;

-- ������� �������������
DROP TABLE IF EXISTS users;
CREATE TABLE users (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY key COMMENT "������������� ������",
first_name VARCHAR(100) NOT null COMMENT "��� ������������", 
last_name VARCHAR(100) NOT null COMMENT "������� ������������",
email VARCHAR(100) NOT null COMMENT "�����",
phone VARCHAR(100) NOT null COMMENT "�������",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",
update_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������"
) COMMENT "������������";
select  * from users where created_at > update_at;-- ���������� ������ ��� ������ ��� update ����� ������ ��� ���� created
update users set update_at = NOW() where created_at > update_at; -- ������ �� ����������

-- ������� � ��������������� �����������, ���� �������� (��. ����. ������)
update users set first_name = '������', last_name = '���������' where users.id = 1;
update users set first_name = '������', last_name = '�����' where users.id = 2;

desc users;
SELECT * from users;


-- ������� ��������
DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
user_id INT UNSIGNED NOT NULL PRIMARY key COMMENT "������ �� ������������",
gender CHAR(1) NOT null COMMENT "���",
birthday DATE COMMENT "���� ��������",
city VARCHAR(130) NOT null COMMENT "����� ����������",
country VARCHAR(130) NOT null COMMENT "������ ����������",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",
update_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������"
) COMMENT "�������";

select  * from profiles where created_at > update_at;-- ���������� ������ ��� ������ ��� update ����� ������ ��� ���� created
update profiles set update_at = NOW() where created_at > update_at; -- ������ �� ����������

-- ������ � gender ��� ������ CHAR(1) �� ENUM 
ALTER TABLE profiles MODIFY COLUMN gender ENUM('m', 'w');

SELECT * from  profiles;
describe  profiles;

-- ������� ������� ����� ������� profiles
desc profiles;
select * from profiles limit 10;
alter TABLE profiles
ADD CONSTRAINT profiles_user_id_fk
foreign KEY (user_id) REFERENCES users(id)
on delete CASCADE;



-- ������� ������� ��� (sessions)
-- �������: ���� ����� � ��������� ���� ��� ������ ��������
DROP TABLE IF EXISTS sessions;
CREATE TABLE sessions (
  id INT unsigned not null auto_increment PRIMARY KEY,
  user_id INT unsigned,
  topic VARCHAR(100) NOT null COMMENT "���� �����",
  topic_quarters VARCHAR(50) NOT null COMMENT "���� ��������",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id)
) COMMENT = '������� ���. Python - ����������';
desc sessions;
INSERT into sessions (topic, topic_quarters)
VALUES
  ('Python - ����������', '�������� � Backend-����������'),
  ('', 'Frontend � Backend ��������-��������'),
  ('', '������� ���'),
  ('', '��������� ���������� ���������� �������');
 -- ����������� �������� ��� user_id ������ NULL
-- ALTER TABLE communities add name_teacher_id INT unsigned after id;
-- update sessions set user_id = sessions.id;
desc sessions;
SELECT * from sessions;

select * from sessions limit 10;
alter TABLE sessions
ADD CONSTRAINT sessions_user_id_fk
foreign KEY (user_id) REFERENCES users(id)
on delete CASCADE;


-- ������� ����� ������ �������� introduction_backend_developments
DROP TABLE IF EXISTS introduction_backend_developments;
CREATE TABLE introduction_backend_developments (
  id INT unsigned not null auto_increment PRIMARY KEY,
  user_id INT unsigned,
  session_id INT unsigned COMMENT "����� ��������",
  python VARCHAR(150) NOT null COMMENT "������ ����� Python",
  linux VARCHAR(150) NOT null COMMENT "Linux. ������� �������",
  mysql VARCHAR(150) NOT null COMMENT "������ ����������� ��� ������. MySQL",
  algorithm_structure_python VARCHAR(150) NOT null COMMENT "��������� � ��������� ������ �� Python. ������� ����",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id)
) COMMENT = '�������� � Backend-����������';
desc introduction_backend_developments;
INSERT into introduction_backend_developments (user_id, session_id, python, linux, mysql, algorithm_structure_python)
VALUES
  (1, 1, '���������� � Python', '��������. ��������� ��', '��������� ���������. DDL - �������', '�������� � �������������� � ���������� ������� ���������� �� Python'),
  (2, 2 , '���������� ���� � �������� � ����', '��������� � ���������� � ����������� ��������� ������', '���������� ��. ���� �������� SQL', '�����. ��������. �������.'),
  (3, 3, '�������',  '������������. ���������� �������������� � ��������', '�������� � �������������� ��', '�������. �������. ���������. ������.'),
  (4, 4, '�������� �����������', '�������� �� � ��������', 'CRUD-��������', '������������ ������ ���������� �� Python'),
  (5, null, '������ � �������', '���������� �������� ������� Linux. ������� ����� � ��������', '���������. ���������, ����������, ���������� � �����������. ��������� ������', '���������. ������. �������. �������.'),
  (6, null, '��������-��������������� ����������������', '�������� � ������� bash. ������������ ����� crontab � a', '�������. ���������, ����������, ���������� � �����������. ��������� ������', '������ � ������������ �������'),
  (7, null, '���. ����������� �������', '���������� �������� � �������������. ������ ������� ������������', '���������. ������� �������', '��������� ����������'),
  (8, null, '���. �������� ����������', '�������� � docker', '�������. ������� �������', '�������. ���-�������'),
  (9, null, '', '', '���������. ����������, ����������, �������������. �����������������. �������� ��������� � �������, ��������', ''),
 (10, null,  '', '', '�������. ����������, ����������, �������������. �����������������. �������� ��������� � �������, ��������', ''),
 (11, null, '', '', '���������. ����������� ��������. NoSQL', ''),
 (12, null, '', '', '�������. ����������� ��������', '');
desc introduction_backend_developments;
select * from introduction_backend_developments;

-- ������� ������� ���� ������� introduction_backend_developments
alter TABLE introduction_backend_developments
ADD CONSTRAINT introduction_backend_developments_user_id_fk
foreign KEY (user_id) REFERENCES users(id)
on delete CASCADE;
alter TABLE introduction_backend_developments
ADD CONSTRAINT introduction_backend_developments_session_id_fk
foreign KEY (session_id) REFERENCES sessions(id)
on delete CASCADE;


-- ������� ������������ (progress)
DROP TABLE IF EXISTS progress;
CREATE TABLE progress (
  id INT unsigned not null auto_increment PRIMARY KEY,
  user_id INT unsigned not null,
  introduction_backend_development_id INT unsigned not null COMMENT "������",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id)
) COMMENT = '������������';
INSERT into progress (id, user_id, introduction_backend_development_id)
VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5);
desc progress;
select * from progress;

-- ������� ������� ���� ������� progress
alter TABLE progress
ADD CONSTRAINT progress_introduction_backend_development_id_fk
foreign KEY (introduction_backend_development_id) REFERENCES introduction_backend_developments(id)
on delete CASCADE;



-- ������� ��������� (messages)
DROP TABLE IF EXISTS messages;
create table messages (
id INT unsigned not null auto_increment primary key,
from_user_id INT unsigned not null COMMENT "������ �� ����������� ���������",
to_user_id INT unsigned not null COMMENT "������ �� ���������� ���������",
body TEXT COMMENT "����� ���������",
is_important BOOLEAN COMMENT "������� ��������",
is_delivered BOOLEAN COMMENT "������� ��������",
create_at DATETIME default CURRENT_TIMESTAMP COMMENT "����� �������� ������"
) COMMENT "���������";
desc messages;
SELECT * FROM messages limit 15;

-- ������� messages ������� ������� �����
alter TABLE messages
add CONSTRAINT messages_from_user_id_fk
foreign KEY (from_user_id) REFERENCES users(id)
on delete cascade,
add CONSTRAINT messages_to_user_id_fk
foreign KEY (to_user_id) REFERENCES users(id)
on delete CASCADE;


-- ������� ������� "������-�����" � ��������� ���-������� �������������� � ���������
DROP TABLE IF EXISTS communities;
create table communities (
id INT unsigned auto_increment not null primary key COMMENT "������������� ������",
course_communities VARCHAR(50) COMMENT "������ ������ �����",
created_at DATETIME default CURRENT_TIMESTAMP COMMENT "����� �������� ������",
update_at DATETIME default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT "����� ���������� ������"
) COMMENT "������ �����";

SELECT * FROM communities limit 19;
-- ������ ���-������� �������������� � ���������
INSERT into communities (course_communities) 
values
  ('������ ���������'),
 ('��������� �����������'),
 ('��������� �������������'),
 ('����� �������'),
('������ �������'),
('������� ��������'),
  ('������ �����'),
 ('������� ��������'),
 ('������ �������'),
 ('����� ������'),
('�������� ��������'),
('��������� ���������'),
 ('����� ����������'),
 ('����� ����'),
 ('���������� ��������'),
 ('����� ��������'),
('������ �������'),
('��������� ��������'),
 ('������ �����');

SHOW COLUMNS FROM communities;
desc communities;
SELECT * FROM communities limit 15;


-- ������� ����� ����������� � ����� 
drop table if exists communities_users;
create table communities_users (
-- id INT unsigned auto_increment not null primary key COMMENT "������������� ������",
users_id INT unsigned not null COMMENT "������ �� ������������",
communities_id INT unsigned not null COMMENT "������ �� ������",
created_at DATETIME default CURRENT_TIMESTAMP COMMENT "����� �������� ������",
primary key (communities_id, users_id) COMMENT "��������� ��������� ����"
) COMMENT "��������� �����, ����� ����� �������������� � ��������";

INSERT into communities_users (users_id, communities_id) 
values
  (1, 1),
 (2, 2),
 (3, 3),
 (4, 4),
(5, 5);
desc communities_users;
SELECT * FROM communities_users;

-- ������� ������� ����� ��� communities_users
alter TABLE communities_users
ADD CONSTRAINT communities_users_users_id_fk
foreign KEY (users_id) REFERENCES users(id)
on delete cascade;
alter TABLE communities_users
ADD CONSTRAINT communities_users_communities_id_fk
foreign KEY (communities_id) REFERENCES communities(id)
on delete CASCADE;



-- ������� ������� ����������� study_materials_1
DROP TABLE IF EXISTS study_materials_1;
create table study_materials_1 (
id INT unsigned not null auto_increment primary key COMMENT "������������� ������",
user_id INT unsigned not null COMMENT "������ �� ������������, ������� �������� ����",
introduction_backend_development_id INT unsigned not null COMMENT "������ �� ���� �����",
filename VARCHAR(250) not null COMMENT "���� � �����",
size INT not null COMMENT "������ �����",
metadata JSON COMMENT "���������� �����",
created_at DATETIME default CURRENT_TIMESTAMP COMMENT "������ �� ��� ��������",
update_at DATETIME default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT "����� ���������� ������"
) COMMENT "������� ����������";

show tables;
SELECT * FROM study_materials_1;
DESC study_materials_1;

-- UPDATE study_materials SET user_id = FLOOR(1 + RAND() * 100);
-- update study_materials_1 set study_materials_1.id = user_id;

-- ������� filename 
-- ��� ����� ����������? 
-- http://dropbox.com/vk/filename.ext ����������� ����: �����������������.��������� ����������
 -- ������� ��������� �������
DROP TABLE IF EXISTS extensions;
CREATE temporary table extensions (name VARCHAR(10));
insert into extensions 
values ('jpeg'), ('png'), ('mp4'), ('mp3'), ('avi'), ('txt'), ('doc'), ('docx'), ('sql'), ('odp'), ('pptx');
select * from extensions;

-- ��������� �������� ������ 
update study_materials_1 set filename = concat(
-- ������� concat ���������� ��� ���� ���������, ������������� ����� ������� � ���� ������. �.�. ���������� 4 ������ (��. ��������� ����) � ����.
'http://dropbox.com/vk/',
filename,
'.',
(select name from extensions order BY RAND() limit 1))-- ������ ����������. ���� ���������� ��. �� ��������� (extensions) �������
;
SELECT * FROM study_materials_1;

-- ������� metadata
-- ���� ������� ����� ������.
-- ������ ���������� ���-�� �����: '{"ouner": "Ferst Last"}', �.�. '{"����": "�������� - ��� �������"}'
update study_materials_1 set metadata = CONCAT(
-- update media - ������ �� ���������� � ��������� (set) ��� ������� metadata ����-�������� ���� ������ �� ����������.
'{"ouner": "',
(select CONCAT(first_name, ' ', last_name)-- ��� � ������� ����� �� ����. users 
from users where users.id = study_materials_1.user_id),
'"}'
);
select * from study_materials_1 limit 20;
desc study_materials_1;

-- ������ � metadata Type (longtext) �� Type (JSON). �.�. ����������, �����������, ���������� ��� ������.
-- ��. 8-� ��� �������� 4 (1:11:35)

 alter table study_materials_1 modify COLUMN metadata JSON; 

ALTER TABLE study_materials_1 drop column introduction_backend_development_id;
ALTER TABLE study_materials_1 add introduction_backend_development_id INT unsigned after user_id;
update study_materials_1 set introduction_backend_development_id = study_materials_1(id);


-- ������� ������� ����� ��� study_materials_1
alter TABLE study_materials_1
ADD CONSTRAINT study_materials_1_introduction_backend_development_id_fk
foreign KEY (introduction_backend_development_id) REFERENCES introduction_backend_developments(id)
on delete CASCADE;



-- ������� ����� ������� �����������
show tables;
select * from study_materials_types;
drop table if exists study_materials_types;
CREATE TABLE study_materials_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "������������� ������",
  study_material_1_id INT unsigned COMMENT "������ �� ������� ������� ����������� (study_materials)",
  name VARCHAR(255) NOT NULL UNIQUE COMMENT "�������� ����",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������"
) COMMENT "���� ������� �����������";
insert into study_materials_types (study_material_1_id, name) values
(1, 'document'),
(2, 'presentation'),
(3, 'video');
-- select  * from study_materials_types where created_at > updated_at; -- ���������� ������ ��� ������ ��� update ����� ������ ��� ���� created
-- update study_materials_types set updated_at = NOW() where created_at > updated_at; 
desc study_materials_types;
select * from study_materials_types;


-- ������� ������� ����� ��� study_materials_types
alter TABLE study_materials_types
ADD CONSTRAINT study_materials_types_study_material_1_id_fk
foreign KEY (study_material_1_id) REFERENCES study_materials_1(id)
on delete CASCADE;



-- ***********************************************************************************************
-- ***********************************************************************************************

-- UNION �����������
select topic from sessions
union
select python from introduction_backend_developments;
-- �, ����� �� ��������� ������������ �������, ��� �������?


-- ��������� ������
select * from sessions;
-- ��� ����������� �������
select id, topic, topic_quarters from sessions where topic_quarters = '�������� � Backend-����������';
-- select id, topic, topic_quarters  from sessions where id = 1;-- ����� ������ ��������.
-- select id, topic, topic_quarters  from sessions where id in (1, 2);-- ����� ���� ��������. ���-� IN !!!!!
-- select id, python from introduction_backend_developments where id in (1,2,3,4,5,6,7,8);
select id, topic, topic_quarters from sessions
-- �������� ��������� ���� ����. sessions, �������������� "�������� � Backend-����������"
-- ���������� ���� ������ �� ��������� ������
where id = (select id from sessions where topic_quarters = '�������� � Backend-����������');


-- JOIN ���������� ������ 
select * from sessions;
select * from introduction_backend_developments;

-- ������� ����������� (���� ��������) ���� ������ 
select sessions.*, introduction_backend_developments.* from sessions join introduction_backend_developments;
-- �.�. ������ ������ ����� ����. ������������ � ������ ������� ������ (1-� ������ ����� ����������� � ������ �� 8-��
-- ����� ������. 2-� ������ - ��� ��. � ��� �����.

-- ���������� ����������� (INNER JOIN, ����� ������ JOIN).  ���-��, ����� ���������� �������� ����������� ������
-- ����������� �������� ���������� ������� ���� ������
-- �� ��� ��� ������ ������ ����� ����. ���������� �� ������ ������ ������
select sessions.id, sessions.topic, sessions.topic_quarters,
introduction_backend_developments.python, introduction_backend_developments.linux, 
introduction_backend_developments.mysql, introduction_backend_developments.algorithm_structure_python
from sessions join introduction_backend_developments;
-- �.�. ���� ������� � ������������
-- ���������� where ��� ������ ���������� �������� � ���������� ����
select sessions.id as id, sessions.topic as '��� �����', sessions.topic_quarters as '���� �����',
introduction_backend_developments.python as python, introduction_backend_developments.linux as linux, 
introduction_backend_developments.mysql as mysql, introduction_backend_developments.algorithm_structure_python as algorithm_structure_python
from sessions join introduction_backend_developments where sessions.id = introduction_backend_developments.id;
-- ������� ���-�� ON ������ WHERE. ������, ������ ����� �������.


-- ������� ����� ����������� LEFT OUTER JOIN (LEFT JOIN).
-- �������: ���, ���� ������ ������� �����������

-- ������� �������� ���� ������ �� ���� 1-�� �������� ����� � �������� ������ ������
-- �.�. ������� ���������� ���� ����� ���� introduction_backend_developments �����
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
-- ������� ������� ������� ������������ left join ������� ������ right JOIN
 
-- ������� ������ ����������� RIGHT OUTER JOIN (RIGHT JOIN).
-- �.�. ������� ���������� ���� ����� ���� sessions ������
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
 
  

-- ������� ������� ���������� ������������ � id = 11
SELECT study_materials_1.id, users.first_name, users.last_name, study_materials_1.filename, study_materials_1.created_at
  FROM study_materials_1
    JOIN users
      ON study_materials_1.user_id = users.id     
  WHERE study_materials_1.user_id = 11;
 
  
 -- ��������� �� ������������ (teacher - ��������� �����������)
SELECT communities.course_communities, messages.body, messages.create_at
  FROM messages
    JOIN communities
      ON communities.id = messages.to_user_id
  WHERE communities.id = 2;
  
 -- ��������� � ������������ (student - ������� ��������)
SELECT communities.course_communities, messages.body, messages.create_at
  FROM messages
    JOIN communities
      ON communities.id = messages.from_user_id
  WHERE communities.id = 8;

-- ���������� ��� ��������� �� ������������ � � ������������
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
--  ????????????????????????????????????????????????????????? ������ ���������



/*!!!!!!!!!!!!!!!!!!!!!!!! ������������� !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 * 
 * ������������� - ��� ���� ������ ����������� ������ � ����� �������� SQL.
 * ������������� � ��� ������ �� ������� SELECT, �������� ������������� ���������� ���
 * � ������� ����� ��������� ��� ������� �� ���� ������ 
 * ��� ������� �������� ���������.
 * � ������� SELECT ���������� ������ � ���������� � �������������. ����� ������ � �������� �������� ���������, 
 * �� ��� ���������� � � �������������.
 * ������������� ��������� ������� ���������� ������������ ������� ����� �������, ��� ����� ��� ����������� 
 * ������� ���� ������. ������������� ��������� ����� ����� ��������� ������� ������� � ��������: ����� ��������� 
 * ������ ��������� ������������� � ��������, � ��������� ������ ������ � ��������������.

 * ��� �������� ������������� ������������ ������� CREATE VIEW, ����� ������� �� ��������� 
 ��� ������������� products_catalogs. ����� ����� ��������� ����� AS ����� ������ �������������.
*/
  
 -- ������������� ���� �������� ��������������� ������� sessions
CREATE VIEW representation_1 AS SELECT * FROM sessions ORDER BY topic;
SELECT * FROM representation_1;
 -- ������������� 2-� �������� ��������������� ������� sessions
CREATE VIEW representation AS SELECT id, topic FROM sessions ORDER BY topic;
SELECT * FROM representation;
-- ������������� 2-� �������� � ������ �� ����� ��������������� ������� sessions
CREATE VIEW representation_2 (quarter_number, topic) AS SELECT id, topic FROM sessions ORDER BY topic;
SELECT * FROM representation_2;-- ����� ��� ������� �������� �������
-- ������� ��� �������������
ALTER VIEW representation_2 (quarter_number, topic) AS SELECT id, topic FROM sessions ORDER BY id;
SELECT * FROM representation_2;
-- ������ ��� �������������
DROP VIEW if exists representation_2;-- if exists - �����������, ��� �� �� ���������� ��������� � ������, ����
-- ��������� �������������� �������������

-- ������������� ������ ������� �����, ���� ��� ����� � ���������� ������� 1-�� ��������
CREATE OR REPLACE VIEW representation_3 as-- REPLACE view - ������, ������������� �������������.
select sessions.topic as '������� �����', sessions.topic_quarters as '��� ���� �����', 
introduction_backend_developments.python as '����: python', introduction_backend_developments.linux as '����: linux', 
introduction_backend_developments.mysql as '����: mysql', 
introduction_backend_developments.algorithm_structure_python as '����: algorithm_structure_python'
from sessions join introduction_backend_developments
on introduction_backend_developments.session_id = sessions.id; 
SELECT * FROM representation_3;

SELECT * FROM sessions;
SELECT * FROM introduction_backend_developments;



-- �������� ��������� / ��������
/*
 * �������� ��������� � ������� ��������� ��������� ������������������ SQL-���������� � 
 * �������� �� �� ����� ������� ��� ���������:
CREATE PROCEDURE procedure_name
CREATE FUNCTION function_name
������� ����� ���������� � �������� ����������� � ���, ��� ������� ���������� �������� � 
�� ����� ���������� � SQL-�������, � �� ����� ��� �������� ��������� ���������� ����.

���������
CREATE PROCEDURE ��� ��������� (�������� � ��������� ���������)
BEGIN
  SELECT VERSION();
END
����� ��������� ������� BEGIN � END ����������� SQL-�������, ������� ����������� ������ ��� 
��� ������ �������� ���������.

CALL ��� ��������� (�������� � ��������� ���������); - ����� ���������
SELECT ��� ������� (�������� � ��������� ���������); - ����� �������
SHOW PROCEDURE STATUS - ������ �������� �������� 
SELECT name, type FROM mysql.proc LIMIT 10; �� ��� �����!!!!
SHOW FUNCTION STATUS
 * 
*/


DROP PROCEDURE IF EXISTS users_numb_string;
DELIMITER //
CREATE PROCEDURE users_numb_string (OUT amount INT)
BEGIN
  SELECT COUNT(*) INTO amount FROM users_numb_string;
END//





