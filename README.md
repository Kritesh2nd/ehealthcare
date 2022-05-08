# ehealthcare

To create database

drop database ecare;create database ecare;use ecare;
create table userinfo(id int(4) primary key auto_increment,name varchar(50),email varchar(50),password varchar(50),utype varchar(10));
create table info(id int(4) primary key auto_increment,title varchar(50),content text,datetime varchar(20),type varchar(20));
insert into userinfo(name,email,password,utype)values('Swastika Thapa Magar','swostikamagar098@gmail.com','pass1234','admin');
show tables;select*from userinfo;
insert into userinfo(name,email,password,utype)values('Sanu Maya','sanu@gmail.com','1234','user');

Admin useremail  : swostikamagar098@gmail.com
Password         : pass1234

Normal useremail : sanu@gmail.com
Password         : 1234
