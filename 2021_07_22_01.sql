--2021_07_21 (��)




---------------------------------------------------

-- ANSI OUTER JOIN
-- select * from table [ left | right | full ] outer join table2 using(�����÷�);

--1. dept01 ���̺� ����
create table dept01(deptno number(2), dname varchar2(14));
insert into dept01 values(10,'ACCOUNTING');
insert into dept01 values(20,'RESEARCH');
select * from dept01;
--2. dept02 ���̺� ����
create table dept02(deptno number(2), dname varchar2(14));
insert into dept02 values(10,'ACCOUNTING');
insert into dept02 values(30,'SALES');
select * from dept02;

--3. left outer join : dept01 ���̺� ������ ��µ�
select * from dept01 left outer join dept02 using(deptno);
--4. right outer join : dept02 ���̺� ������ ��µ�
select * from dept01 right outer join dept02 using(deptno);

--5. full outer join : dept01, dept02 ���̺� ��� ������ ��µ�
select * from dept01 full outer join dept02 using(deptno) order by deptno asc;

-------------------------------------------------------------------------------
-- ��������
--Q. SCOTT ����� �Ҽӵ� �μ����� ����ϴ� SQL�� �ۼ�

--1) ��� ���̺��� SCOTT����� �μ���ȣ�� ���Ѵ�.
select deptno from emp where ename='SCOTT';
--2) �μ� ���̺��� 20�� �μ��� �μ����� ���Ѵ�.
select dname from dept where deptno=20;

-- JOIN���� ���ϱ�
select dname from dept, emp where dept.deptno=emp.deptno and ename = 'SCOTT';
select dname from dept inner join emp on dept.deptno=emp.deptno where ename = 'SCOTT';
select dname from dept inner join emp using(deptno) where ename='SCOTT';
select dname from dept natural join emp where ename='SCOTT';
-- ���������� ���ϱ�
select dname from dept where deptno =                   -- ��������
    (select deptno from emp where ename = 'SCOTT');     -- ��������
    
--1.������ ��������
-- 1) ���������� �˻� ����� 1���� ��ȯ�Ǵ� ����
-- 2) ���������� where ���������� �� �����ڸ� ��� ����(=,>,>=,<,<=,!=)

--Q. ��� ���̺��� ���� �ֱٿ� �Ի��� ������� ����ϴ� SQL�� �ۼ�

select ename from emp where hiredate = (select max(hiredate) from emp);

--Q. ��� ���̺��� �ִ� �޿��� �޴� ������ �ִ�޿� �ݾ��� ����ϴ� SQL�� �ۼ�
select ename, sal from emp where sal = (select max(sal) from emp);

--Q. ���ӻ��(MGR)�� KING�� ����� ������ �޿��� ����ϴ� SQL�� �ۼ�
select ename, sal from emp where mgr = 
    (select empno from emp where ename='KING');     -- 7839

--2. ������ ��������
-- 1) ������������ ��ȯ�Ǵ� �˻� ����� 2�� �̻��� ��������
-- 2) ���� ������ WHERE ���������� ������ ������(in, all, any, ...)�� ����ؾ� �ȴ�

--<in ������>
-- : ���������� �˻� ��� �߿��� �ϳ��� ��ġ�Ǹ� ���̵ȴ�
--Q. �޿��� 3000�̻� �޴� ����� �Ҽӵ� �μ��� ������ �μ����� �ٹ��ϴ� �������
--   ������ ����ϴ� SQL�� �ۼ�

-- �� �μ��� �ִ�޿� �ݾ� ���ϱ�
select deptno, max(sal) from emp group by deptno;
-- 10 5000, 20 3000, 30 2850
select * from emp where deptno in(
select deptno from emp where sal >= 3000);

--Q. in�����ڸ� �̿��Ͽ� �μ����� ���� ���� �޿��� �޴�
-- ����� ����(�����ȣ, �����, �޿�, �μ���ȣ)�� ����ϴ� SQL�� �ۼ�
select empno, ename, sal, deptno from emp where sal in 
(select max(sal) from emp group by deptno) order by sal desc;

--<all ������>
-- : ���� ������ �� ������ ���������� �˻� ����� ��� ���� ��ġ�ϸ� ���̵ȴ�
--Q. 30�� �μ��� �Ҽӵ� ��� �߿��� �޿��� ���� ���� �޴� ������� �� ���� �޿��� 
-- �޴� ����� �̸��� �޿��� ����ϴ� SQL�� �ۼ�

--1) ������ ���������� ���ϱ�
select ename,sal from emp where sal > 
all(select max(sal) from emp where deptno = '30');
--2) ������ ���������� ���ϱ�
select ename, sal from emp where sal >
all(select sal from emp where deptno = '30');

--<any ������>
-- : ���� ������ �������� ���� ������ �˻� ����� �ϳ� �̻��� ��ġ�Ǹ� ���̵�
-- Q. �μ���ȣ�� 30���� ������� �޿��� ���� ���� �޿�(950)���� ���� �޿��� �޴�
-- ������ �޿��� ����ϴ� SQL�� �ۼ�
select ename, sal from emp where sal > 
any(select sal from emp where deptno = 30);


