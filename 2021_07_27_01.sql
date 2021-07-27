-- 2021_07_27_01(ȭ)

-- �並 ������ �� ���Ǵ� �ɼǵ�
--1. or replace �ɼ�
--   ������ �䰡 �������� ������ �並 �����ϰ�, ������ �̸��� ���� �䰡 
--   ������ ������ ������

select * from user_views;

-- ������ emp_view30�̶�� �並 �����ߴµ�, 
-- or replace �ɼ��� �ٿ��� emp_view30 �並 �����غ���
--1) or replace �ɼǾ��� ������ ��(emp_view30)�� �����ϸ� �����߻�
create  view emp_view30
as
select empno, ename, deptno, sal, comm from emp_copy where deptno=30;

--2) or replace �ɼ��� �ٿ��� ������ ��(emp_view30)���� : ���� ������ ������
create or replace view emp_view30
as 
select empno, ename, deptno, sal, comm from emp_copy where deptno=30;

select * from emp_view30;

--2. with check option
--   : where �������� ���� ���� �������� ���ϵ��� ����� �ִ� �ɼ�
--1) with check option ������� ���� ���
create or replace view emp_view30
as
select empno,ename,sal,comm,deptno from emp_copy where deptno=30;

-- emp_view30 �信�� �޿��� 1200 �̻��� ����� �μ���ȣ�� 30 -> 20���� ����
update emp_view30 set deptno=20 where sal>=1200;

--2) with check option ���
create or replace view emp_view_chk30
as
select empno,ename,sal,comm,deptno from emp_copy
where deptno=30 with check option;

select * from emp_view_chk30;
-- emp_view30 �信�� �޿��� 1200 �̻��� ����� �μ���ȣ�� 30 -> 20���� ����
update emp_view_chk30 set deptno=20 where sal>=1200;

--3. with read only �ɼ�
--   : �並 ���ؼ� �⺻ ���̺��� � �÷��� ������ �������� ���ϵ��� �ϴ� �ɼ�
create or replace view view_read30
as
select empno, ename, sal, comm, deptno from emp_copy
where deptno=30 with read only;

select * from view_read30;
select * from user views;

--Q. ������ �� view_read30�� �����غ���
update view_read30 set sal=3000;    -- with read only �ɼǶ��� �����ȵ�

select rownum, deptno, dname, loc from dept;

select rownum, ename, sal from emp order by sal desc;

--Q1. ������̺��� �Ի����� ���� ��� 5���� ���غ���
--1) �Ի����� ���� ��������� ���� ( �Ի����� �������� �������� ���� )
select empno, ename, hiredate from emp order by hiredate asc;

--2) �� ����
create or replace view hire_view
as select empno, ename, hiredate from emp order by hiredate asc;

--3) �Ի����� ���� ��� 5�� ���
select rownum, empno, ename, hiredate from hire_view;

select rownum, empno, ename, hiredate from hire_view where rownum <=5;

--4) �ζ��κ�( ���������� ������� ��)
-- �Ի����� ���� ��� 5�� �˻�
select rownum, ename, hiredate from
(select empno, ename, hiredate from emp order by hiredate asc)
where rownum <= 5;

-- �Ի����� 3 ~ 5��°�� ���� ����� �˻�
select rownum, ename, hiredate from(
    select ename, hiredate from emp order by hiredate asc)
where rownum <= 5 and rownum >= 3;  -- �̷������δ� �ȵ�

select ename, hiredate from(
    select rownum rnum, ename, hiredate from( -- rownum �÷� ��Ī �ο�
    select * from emp order by hiredate asc) )
where rnum >= 3 and rnum <= 5;

--Q2. ��� ���̺��� �����ȣ(empno)�� ���� ��� 5���� ���غ���

-- �ζ��� ��� �ذ�
select empno, ename from (
    select rownum rnum, empno, ename from( 
    select * from emp order by empno asc) )
where rnum <= 5;

--Q3. ��� ���̺��� �޿��� 3~5��°�� ���� �޴� ��� ���غ���
select empno, ename, sal from(
    select rownum rnum, empno, ename, sal from(
    select * from emp order by sal desc) )
where rnum <= 5 and rnum >= 3;

-- �÷����� �����ϰ� ó��
select rnum, ename, sal from(
    select rownum rnum, ename, sal from(
    select * from emp order by sal desc) board) -- ���������� ��Ī�ο�
where rnum >= 3 and rnum <= 5;

    

