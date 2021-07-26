-- 2021.07.26(��)
--1. primary key(���Ű)
--   primary key = not null + unique
--   �ݵ�� �ߺ����� �ʴ� ���� �Է� �ؾߵȴ�

--   ex) �μ����̺�(DEPT) - deptno(pk)
--       ������̺�(EMP)  - empno(pk)

select * from dept;
insert into dept values(10,'���ߺ�','����'); -- unique �������� ����
insert into dept values(null,'���ߺ�','����');   -- not null ����
-- DEPT ���̺��� DEPTNO �÷��� primary key ���������� �������־
-- �ߺ��� ���� null ���� �Է��� �� ����

select * from emp;
insert into emp(empno, ename) values(7788,'����ȣ');   -- unique �������� ����
insert into emp(empno, ename) values(null,'����ȣ');   -- not null ����

drop table emp05 purge;

create table emp05(
    empno number(4) primary key,
    ename varchar2(12) not null,
    job varchar2(12),
    deptno number(2) );
    
select * from emp05;
insert into emp05 values (1111,'����ȣ','������','10');
--  primary key�ε� �÷����� not null, unique�� �����ؼ� insert�ϸ� �ȵ�

-- �������� �̸�(constraint_name)�� �����ؼ� ���̺��� ����
drop table emp04 purge;
create table emp04(
    empno number(4) constraint emp04_empno_pk primary key,
    ename varchar2(20) constraint emp04_ename_nn not null,
    job varchar2(20),
    deptno number(2));
    
--4. foreign key (�ܷ�Ű)
-- dept(�θ����̺�) - deptno(pk,�θ�Ű) : 10, 20, 30, 40
-- emp(�ڽ����̺�) = deptno(fk) : 10,20,30

--1) ������̺�(emp)�� deptno �÷��� foreign key ���������� �����Ǿ� �ִ�
--2) foreign key ���������� ������ �ִ� �ǹ̴� �θ����̺�(dept)�� �θ�
--   (deptno)�� ���� ������ �� �ִ�. (10,20,30,40�� �μ���ȣ�� ��������)
--3) �θ�Ű�� �Ǳ� ���� ������ primary key�� unique ������������ �������־����

--Q. ������̺�(emp)�� ���������� �����ؼ� ������� ����غ���
-- �ܷ�Ű�� �θ�Ű(dept - deptno)�ȿ� �ִ� ��(10,20,30,40)�� ������ �� �ִ�
insert into emp(empno,deptno) values(1111,50);  -- �����߻�

--[�ǽ�]
drop table emp06 purge;
create table emp06(
    emmpno number(4) primary key,
    ename varchar2(10) not null,
    job varchar2(10),
    deptno number(2) references dept(deptno) );
    
select * from emp06;
insert into emp06 values(1111,'����ȣ','������',10);
insert into emp06 values(1112,'����ȣ','������',20);
insert into emp06 values(1113,'����ȣ','������',30);
insert into emp06 values(1114,'����ȣ','������',40);
insert into emp06 values(1115,'����ȣ','������',50);  -- ���� �߻�

--5.check ��������
-- : �����Ͱ� �Էµɶ� Ư�� ������ �����ϴ� �����͸� �Էµǵ��� ������ִ� ��������

create table emp07(
    empno number(4) primary key,
    ename varchar2(10) not null,
    sal number(7,2) check(sal between 500 and 5000), -- sal : 500~5000
    gender varchar2(1) check(gender in('M','F')));  -- gender : 'M','F'

select * from emp07;
insert into emp07 values(1111,'����ȣ','3000','M');
insert into emp07 values(1112,'����ȣ','8000','M');    -- �����߻�
insert into emp07 values(1112,'����ȣ','8000','m');    -- �����߻�

--6. default ��������
-- default ���������� ������ �÷��� ���� �Էµ��� ������ default�� ������
-- ���� �ڵ����� �Էµȴ�

drop table dept01 purge;
create table dept01(
    deptno number(2) primary key,
    dname varchar2(14),
    loc varchar2(13) default 'SEOUL');
    
select * from dept01;
insert into dept01 values(10, 'ACCOUNTING', 'NEWYORK');
insert into dept01(deptno,dname) values(20,'RESEARCH'); -- loc�� SEOUL �ڵ� �Է�


--���� ���� ���� ���
--1. �÷����� ������� �������� ����
--2. ���̺��� ������� �������� ����

--1. �÷����� ������� �������� ����
drop table emp01 purge;

create table emp01(
    empno number(4) primary key,
    ename varchar2(15) not null,
    job varchar2(10) unique,
    deptno number(2) references dept(deptno) );

--2. ���̺��� ������� �������� ����
drop table emp02 purge;

create table emp02(
    empno number(4),
    ename varchar2(15) not null,
    job varchar2(10),
    deptno number(2),
    primary key(empno),
    unique(job),
    foreign key(deptno) references dept(deptno) );
    
-- ���� ������ ������ �� ���̺� ���� ��ĸ� ������ ���(2����)
--1. �⺻�⸦ ����Ű�� �����ϴ°�� ( �� ���̺��� pkŰ�� 2��)
drop table member01 purge;

-- �÷� ���� ������δ� 2���� �÷��� pk�� ���� �Ұ�
create table member01(
    id varchar2(20) primary key,
    passwd varchar2(20) primary key);   -- ���� �߻�
    
--2. alter table�� ���������� �߰��� ���

-- ���̺� ���� ������δ� pk 2�� ����
create table member01(
    id varchar2(20),
    passwd varchar2(20),
    primary key(id,passwd));
    
--2. alter table�� ���� ������ �߰��� ���
drop table emp01 purge;
-- �ϴ� ���������� ���� ���̺�� �����
create table emp01(
    empno number(4),
    ename varchar2(14),
    job varchar2(10),
    deptno number(2));
    
-- primary key ���� ���� �߰� : empno
alter table emp01 add primary key(empno);

-- not null ���� ���� �߰� : ename
alter table emp01 modify ename not null;

-- unique ���� ���� �߰� : job
alter table emp01 add unique(job);

-- foreign key ���� ���� �߰� : deptno
alter table emp01 add foreign key(deptno) references dept(deptno);

-- �������� ����
-- ���� : alter table ���̺�� drop constraint constraint_name;

-- primary key �������� ����
-- constraint_name���� Ȯ���ؾ��� ex)SYS_C007031
alter table emp01 drop constraint SYS_C007031; 
alter table emp01 drop primary key;

-- unique �������� ����
alter table emp01 drop constraint SYS_C007033;
alter table emp01 drop unique(job);
-- not null �������� ����
alter table emp01 drop constraint SYS_C007032;

-- foreign key ���� ���� ����
alter table emp01 drop constraint SYS_C007034;


-- ���� ������ Ȱ��ȭ / ��Ȱ��ȭ
--1. �θ� ���̺� ����
drop table dept01 purge;
create table dept01(
    deptno number(2) primary key,
    dname varchar2(14),
    loc varchar(13));
    
insert into dept01 values(10,'ACCOUNTING','NEW YORK');
select * from dept01;

--2. �ڽ� ���̺� ����
drop table emp01 purge;
create table emp01(
    empno number(4) primary key,
    ename varchar2(10) not null,
    job varchar2(10) unique,
    deptno number(2) references dept01(deptno) );
    
insert into emp01 values(1111, '����ȣ','SALESMAN',10);
select * from emp01;
    
--3. �θ� ���̺� ������ ����
delete from dept01; -- �����ϰ� �ִ� �ڽ��� �־ ��������. 
-- �ڽ��� ���������� ��Ȱ��ȭ ���Ѽ� �����ϴ� �����Ͱ� ���� ���·� ��������
-- alter table ���̺�� disablle constraint constraint_name;
alter table emp01 disable constraint SYS_C007067;

--cf. foreign key ���������� Ȱ��ȭ
alter table emp01 enable constraint SYS_C007067;   

-- CASCADE �ɼ��� �ٿ��� �θ� ���̺�(DEPT01)�� ����������
-- ��Ȱ��ȭ ��Ű��, �����ϰ� �ִ� �ڽ� ���̺�(EMP01)�� foreign key 
-- �������ǵ� ���� ��Ȱ��ȭ ��
alter table dept01 disable constraint SYS_C007063 cascade;
alter table dept01 enable constraint SYS_C007063 cascade;

-- cascade �ɼ��� �ٿ��� �θ� ���̺�(dept01)�� ���������� ��Ȱ��ȭ ��Ű��,
-- �����ϰ� �ִ� �ڽ� ���̺�(emp01)�� foreign key �������ǵ� ���� ��Ȱ��ȭ��
alter table dept01 drop primary key cascade;


