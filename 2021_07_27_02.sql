-- 2021.07.27(ȭ)

-- ������(sequence)
-- : ���̺� ���ڸ� �ڵ����� ���� ���Ѽ� ó�����ִ� ����

-- ������ ������
create sequence dept_deptno_seq 
start with 10
increment by 10;

-- ������ ���
select * from seq;
select * from user_sequences;

-- currval : ������ ���簪�� ��ȯ
-- nextval : ������ �������� ��ȯ
select nextval from dept_deptno_seq;
select dept_deptno_seq.nextval from dual;   -- ��ó���� nextval�� ���ؿ;���
select dept_deptno_seq.currval from dual;

--��1. �������� ���̺��� �⺻Ű�� �����ϱ�
drop table emp01 purge;
create table emp01(
    empno number(4) primary key,
    ename varchar2(10),
    hiredate date);
    
create sequence emp01_empno_seq;    -- �����ϸ� 1���� 1�� �����ϴ� ������ ����

select * from tab;
select * from seq;

insert into emp01 values(emp01_empno_seq.nextval,'����ȣ',sysdate);

select * from emp01;

-- ��2.
-- ���̺� ����
create table dept_example(
    deptno number(4) primary key,
    dname varchar2(15),
    loc varchar2(15));
create sequence dept_example_deptno_seq
start with 10
increment by 10;

select * from tab;
select * from seq;
select * from dept_example;

-- ������ �Է�
insert into dept_example values
(dept_example_deptno_seq.nextval,'�λ��','����');
insert into dept_example values
(dept_example_deptno_seq.nextval,'�渮��','����');
insert into dept_example values
(dept_example_deptno_seq.nextval,'�ѹ���','����');
insert into dept_example values
(dept_example_deptno_seq.nextval,'�����','��õ');

-- ������ ����
-- drop sequence �������̸�;
drop sequence dept_example_deptno_seq;
-- ������ ����
-- alter sequence �������̸� 
drop sequence dept_deptno_seq;

create sequence dept_deptno_seq
start with 10
increment by 10
maxvalue 30;

-- ������ ���
select * from seq;
select * from user_sequences;

select dept_deptno_seq.nextval from dual;
select dept_deptno_seq.nextval from dual;
select dept_deptno_seq.nextval from dual;
select dept_deptno_seq.nextval from dual;   -- 4��°�� 40�̹Ƿ� MAX�� �ɸ�

-- ������ ���� : maxvalue : 30 -> 1000000
alter sequence dept_deptno_seq maxvalue 1000000;

------------------------------------------------------------
-- �ε���(Index) : ���� �˻��� �ϱ� ���ؼ� ���Ǵ� ��ü
-- �ε��� ��� Ȯ��
select * from user_indexes;

-- �⺻Ű(primary key)�� ������ �÷��� �ڵ����� ���� index�� ������

-- [�ǽ�]
-- �ε��� �ǽ� : �ε��� ��� ������ ���� �޶����� �˻� �ӵ�
-- 1. ���̺� ����
drop table emp01 purge;
-- ���纻 ���̺� ���� : ���� ������ ������� �ʴ´�
create table emp01 as select * from emp;
-- 2. emp01 ���̺� ������ �Է�
insert into emp01 select * from emp01;  -- ���� 100������ ������
-- 3. �˻��� ������ �Է�
insert into emp01(empno, ename) values(1111,'ahn');
-- 4. �ð� ���� Ÿ�̸� ��
set timing on
-- 5. �ε��� ���� �˻�
select * from emp01 where ename='ahn';  -- 0.61�ʰɸ�
-- 6. �ε��� ���� : ename �÷��� �ε����� �����
create index idx_emp01_ename on emp01(ename);
select * from user_indexes; -- �ε��� �������ִ°͵� Ȯ��
-- 7. �˻��� �����ͷ� �˻��ð��� ���� : �ε����� ������ ���
select * from emp01 where ename = 'ahn';    -- 0.008��

-- �ε��� ����
-- ���� : drop index index_name;
drop index idx_emp01_ename;
set timing off

-- �ε��� ����
-- ���� �ε��� : �ߺ��� �����Ͱ� ���� �÷��� ������ �� �ִ� �ε���
-- ����� �ε��� : �ߺ��� �����Ͱ� �ִ� �÷��� ������ �� �ִ� �ε���

--1. ���̺� ����
drop table dept01 purge;
create table dept01 as select * from dept where 1=0;    -- ���̺� ������ ����
--2. ������ �Է�
select * from dept01;
insert into dept01 values(10, '�λ��', '����');
insert into dept01 values(20, '�湫��', '����');
insert into dept01 values(30, '������', '����');

--3. ���� �ε��� ���� : deptno �÷��� ���� �ε��� ����
create unique index idx_dept01_deptno on dept01(deptno);

-- ���� �ε����� ������ deptno �÷��� �ߺ� �����͸� �Է� �غ���
insert into dept01 values(30,'�λ��','�泲');   -- ���� �߻�

--4. �ε��� ��� Ȯ��
select * from user_indexes;

--5. ����� �ε��� : loc �÷��� ����, ����� �ε����� ���� �غ���
-- loc �÷��� �ߺ��� ���� �ֱ� ������ ����� �ε����� ��������
create index idx_dept01_loc on dept01(loc); 

--6. ���� �ε��� : 2�� �̻��� �÷����� ������� �ε���
create index idx_dept01_com on dept01(deptno, dname);

--7. �Լ� ��� �ε��� : �����̳� �Լ��� �����ؼ� ���� �ε���
create index idx_dept01_annsal on emp01(sal*12);
select (sal*12) from emp;

