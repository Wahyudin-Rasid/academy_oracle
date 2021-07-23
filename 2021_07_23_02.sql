-- 2021.07.23(��)

-- Ʈ�����(Transaction) 
-- 1.������ �۾� ����
-- 2.�������� �ϰ����� �����ϸ鼭, �����͸� ���������� �����ϱ� ���ؼ� ����Ѵ�. 

-- TCL(Transaction Control Langage)
-- commit : Ʈ������� ����
-- rollback : Ʈ������� ���
-- savepoint : ������ ����(������)�� �����ϴ� ����

--[�ǽ�]
drop table dept01 purge;
create table dept01 as select * from dept;      -- ���纻 ���̺� ����
select * from dept01;

-- rollback : Ʈ������� ���(������ ����)
delete from dept01;
rollback;

-- commit : Ʈ������� ����
delete from dept01 where deptno=20;
commit;     -- Ʈ����� ����
rollback;   -- Ʈ������� ���� �Ǿ��� ������ ������ 20�� �����ʹ� �������� ���Ѵ�.

-- �ڵ� Ŀ�� : �ڵ����� Ŀ���� ����
-- 1) �������� ���� : quit, exit, con.close()
-- 2) DDL(create, alter, rename, drop, truncate), DCL(grant, revoke)
--    ����� ����
--��1.
select * from dept01;   -- 10, 30, 40
delete from dept01 where deptno=40;         -- 40�� ������ ����

create table dept03 as select * from dept;  -- �ڵ� Ŀ�� ����(DDL) 

rollback;       -- ������ 40�� �����ʹ� �������� ���Ѵ�.

--��2.
-- DML(delete), DDL(truncate)
select * from dept01;    -- 10, 30
delete from dept01 where deptno = 30;   -- DML(delete)
rollback;               --������ 30�� �����͸� �����Ѵ�

truncate table dept01;  -- �ڵ� Ŀ�� ����(DDL)
rollback;               -- dept01 ���̺��� �����͸� �������� ���Ѵ�

-- �ڵ� �ѹ�
-- : ���������� ���� ( ������ â�� �ݰų�, ��ǻ�Ͱ� �ٿ�Ǵ� ���)

-- savepoint : �ӽ� �������� ������ �� ���Ǵ� ���
-- [�ǽ�]
drop table dept01 purge;

--1. dept01 ���̺� ����
create table dept01 as select * from dept;
select * from dept01;

--2. 40�� �μ� ����
delete from dept01 where deptno = 40;

--3. commit ���� : Ʈ����� ����
commit;

--4. �μ� ���� �� savepoint ����
delete from dept01 where deptno = 30;
savepoint c1;
delete from dept01 where deptno = 20;
savepoint c2;
delete from dept01 where deptno = 10;

--5. ����
rollback to c2;
select * from dept01;

rollback to c1;
select * from dept01;

rollback;   -- �̳��� ���� Ʈ����� ����(commit������) ���Ŀ� �ͱ��� �ϴ� ����
select * from dept01;

--------------------------------------------------------------------------
-- ���Ἲ ��������
-- : ���̺� �������� �����Ͱ� �ԷµǴ� ���� �����ϱ� ���ؼ� ���̺��� ������ �� 
--   �� �÷��� ���ؼ� �����ϴ� �������� ��Ģ�� ���Ѵ�.
--   ex) not null, unique, primary key, foreign key, check, default

--1. not null ��������
--   null ���� ������� �ʴ´�. (�ݵ�� ���� �Է��ؾ���)
--[�ǽ�]
drop table emp02 purge;
create table emp02(
    empno number(4) not null,
    ename varchar2(12) not null,
    job varchar2(12),
    deptno number(2));
    
insert into emp02 values(1111,'����ȣ','MANAGER',30);
select * from emp02;
insert into emp02 values(null,null,'MANA',20);

--2. unique ���� ����
--   ������ ���� �Է� ����, �ߺ��� ���� �Է� �Ұ�, null���� �Է°���
drop table emp03 purge;
create table emp03(
    empno number(4) unique,
    ename varchar2(12) not null,
    job varchar2(12),
    deptno number(2) );
    
insert into emp03 values(1111,'����ȣ','������',10);
-- unique ���� ���� ����
insert into emp03 values(1111,'��ȭ��','�Ŵ���',20);

insert into emp03 values(null,'ȫ�浿','������',20);  -- �Է� �� ��
select * from emp03;