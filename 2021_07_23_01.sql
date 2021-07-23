-- 2021.07.23(��)

--* ����Ŭ�� ��ü
-- ���̺�, ��, ������, �ε���, ���Ǿ�, ���ν���, Ʈ����

--* ������ ��ųʸ��� ������ ��ųʸ� ��
-- ������ ��ųʸ��� ���ؼ� ���� ����

-- ������ ��ųʸ� �� ( ���� ���̺�) : user_xxxx
--                                all_xxxx
-- dba(system) ������ ��밡��       dba_xxxx 

-- ������ ��ųʸ�(�ý��� ���̺�)

-- SCOTT ���� ������ ���̺� ��ü�� ���� ������ ��ȸ
select * from tab;  -- tab : ���� ���Ǿ�
select * from sys.tab;

select * from user_tables;

-- �ڱ� ���� ���� �Ǵ� ������ �ο� ���� ��ü � ���� ���� ��ȸ
select * from all_tables;

-- DBA ������ ��� ������ dba_xxx
select * from dba_tables;   -- ���� �߻�(���� SCOTT����)

-- ����Ŭ �ý����� ���� ���� �˻�
select * from dba_users;    -- SCOTT�̶� ������

--1.insert
-- ���� : insert into ���̺��(�÷�1, �÷�2,...) values(������1, ������2,...);
--       insert into ���̺�� valeus(������1, ������2,...);

--[�ǽ�]
drop table dept01 purge;

-- ����ִ� dept01 ���纻 ���̺� ����
create table dept01 as select * from dept where 1=0;

select * from dept01;

insert into dept01(deptno, dname, loc) values(10,'ACCOUNTING','NEW YORK');
insert into dept01 values(20,'RESEARCH','DALLAS');
insert into dept01 values(30,'������','����');

-- NULL �� �Է�
insert into dept01(deptno, dname) values(40,'���ߺ�');
insert into dept01 values(50,'��ȹ��',null);

--2) ���������� ������ �Է�
drop table dept02 purge;
-- dept02 ���̺� ����
create table dept02 as select * from dept where 1=0;    -- ���̺� ������ ����
select * from dept02;

insert into dept02 select * from dept;
insert into dept02 select * from dept02;

-- 3) insert all ��ɹ����� ���� ���̺� ������ �Է�
-- 2���� ���̺� ����
create table emp_hir as select empno, ename, hiredate from emp where 1=0;
create table emp_mgr as select empno, ename, mgr from emp where 1=0;

-- insert all ��ɹ����� ���� ���̺� �����͸� �Է�
insert all into emp_hir values(empno, ename, hiredate)
           into emp_mgr values(empno, ename, mgr)
           select empno, ename, hiredate, mgr from emp where deptno = 20;
           
select * from emp_hir;
select * from emp_mgr;

--2. update
-- ���� : update ���̺�� set �÷�1 = ������ ��1, �÷�2 = �����Ұ�, where ������;

-- [�ǽ�]
drop table emp01 purge;

create table emp01 as select * from emp;
select * from emp01;

--1) ��� ������ ����
--Q. ��� ������� �μ���ȣ�� 30������ ����
update emp01 set deptno = 30;

--Q. ��� ������� �޿��� 10%�λ�
update emp01 set sal = sal*1.1;

--Q. ��� ������� �Ի����� ���� ��¥�� ����
update emp01 set hiredate = sysdate;

--2) Ư�� �����͸� ���� : where ������ ���
drop table emp02 purge;
create table emp02 as select * from emp;    -- ���纻 ���̺� ����
select * from emp02;
select * from emp;
--Q. �޿��� 3000 �̻��� ����� �޿��� 10% �λ�
update emp02 set sal=sal*1.1 where sal >= 3000;

--Q. �Ի����� 1987���� ����� �Ի����� ���� ��¥�� ����
update emp02 set hiredate = sysdate where substr(hiredate,1,2) = 87;

--Q. SCOTT ����� �Ի����� ���� ��¥�� �����ϰ�, �޿��� 50����, Ŀ�̼��� 4000���� ����
update emp02 set hiredate = sysdate, sal = 50, comm = 4000 where ename = 'SCOTT';

--3) ���� ������ �̿��� ������ ����
--Q. 20�� �μ��� ������(DALLAS)�� 40�� �μ��� ������(BOSTON)���� ����
select * from dept;
update dept set loc = (select loc from dept where deptno = '40') where deptno = 20;

--3. delete : ������ ����
-- ���� : delete from ���̺�� where ���ǽ�;
--1) ��� ������ ����
select * from dept01;
delete from dept01;
rollback;   --Ʈ������� ���

--2) ������ �����ϴ� ������ ����
delete from dept01 where deptno=30;

--3) ���������� �̿��� ����
--Q. ������̺�(EMP02)���� �μ����� SALES �μ��� ����� ����
delete from emp02 where deptno = (select deptno from dept where dname='SALES');
select * from emp02;

-- MERGE (���̺� �պ�)
-- : ���̺� ������ ���� 2���� ���̺��� �ϳ��� ���̺�� ��ġ�� ���
--   MERGE ����� ������ �� ������ �����ϴ� ���� ������ ���ο� ������
--   UPDATE�ǰ�, �������� ������ ���ο� ������ �߰��ȴ�
drop table emp01 purge;
drop table emp02 purge;
create table emp01 as select * from emp;
create table emp02 as select * from emp where job = 'MANAGER';
update emp02 set job = 'TEST';
insert into emp02 values(8000,'ahn','top',7566,'2018/02/22',1200,10,20);

merge into emp01
	using emp02
	on(emp01.empno = emp02.empno)
	when matched then
	     update set emp01.ename = emp02.ename,
			emp01.job = emp02.job,
			emp01.mgr = emp02.mgr,
			emp01.hiredate = emp02.hiredate,
			emp01.sal = emp02.sal,
			emp01.comm = emp02.comm,
			emp01.deptno = emp02.deptno
	when not matched then
	     insert values(emp02.empno, emp02.ename, emp02.job, 		         	         
                       emp02.mgr,emp02.hiredate, 
                       emp02.sal, emp02.comm,emp02.deptno);
select * from emp01;    