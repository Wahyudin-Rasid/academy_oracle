--2021.07.21(��)
select * from emp;
-- �׷��Լ�
-- count() : �� ������ ������ �����ִ� �Լ�
select count(sal) from emp;     -- 14
select count(mgr) from emp;     -- 13 : null���� counting�� ���� �ʴ´�.
select count(comm) from emp;    -- 4 : null���� counting�� ���� �ʴ´�.
select count(empno) from emp;   -- 14 : ename�÷��� �⺻Ű�� �����Ǿ� �ִ�.
select count(*) from emp;       -- 14

--Q. ��� ���̺��� JOB�� ����
select count(job) from emp;     -- 14 : �ߺ� �����͵� counting �Ѵ�.
select job from emp;
select distinct job from emp;   -- �ߺ����� ������ JOB ���

-- �ߺ����� ������ JOB�� ���� ���ϱ�?
select count(distinct job) from emp;  -- 5

--Q. ���� �ֱ� �Ի��� ����� �Ի��ϰ� ���� ���� �Ի��� ����� �Ի����� ���ϴ� SQL�� �ۼ�?
select max(hiredate) �ֱ��Ի�, min(hiredate) �����Ի� from emp;

--Q. 30�� �μ� �Ҽ� ��� �߿��� Ŀ�̼��� �޴� ������� ���ϴ� SQL�� �ۼ�?
select count(comm) from emp where deptno=30;


-- group by ��
-- : Ư�� �÷��� �������� ���̺� �����ϴ� �����͸� �׷����� �����Ͽ� ó�����ִ� 
--   ������ �Ѵ�.

--Q. �� �μ�(10,20,30)�� �޿��� ��, ��ձ޿�, �ִ�޿�, �ּұ޿��� ���ϴ� SQL�� �ۼ�?
select sum(sal), avg(sal), max(sal), min(sal) from emp where deptno=10;
select sum(sal), avg(sal), max(sal), min(sal) from emp where deptno=20;
select sum(sal), avg(sal), max(sal), min(sal) from emp where deptno=30;

-- �׷��Լ��� �Ϲ� �÷��� ���� ����� �� ����.
select ename, max(sal) from emp;    -- ���� �߻�

-- �׷��Լ��� �Ϲ��÷��� ���� ����� �� ������, ���������� group by���� ���Ǵ� �÷���
-- �׷��Լ��� ���� ����� �� �ִ�.
select deptno, sum(sal), avg(sal), max(sal), min(sal) from emp
    group by deptno order by deptno asc;
--Q. JOB�÷��� �������� �޿��� ��, ���, �ִ�, �ּұ޿��� ���ϴ� SQL�� �ۼ�
select job, sum(sal), avg(sal), max(sal), min(sal) from emp group by job;
--Q. �� �μ�(10,20,30)�� ������� Ŀ�̼��� �޴� ����� ���� ���ϴ� SQL�� �ۼ�
select deptno, count(deptno) ����� , count(comm) "Ŀ�̼� �޴� ��� ��" from emp group by deptno order by deptno asc;

-- having ������
-- : group by���� ���Ǵ� ��쿡 ������ ������ ���ϱ� ���ؼ��� where ������ ���
--   having �������� ����ؾ� �Ѵ�

--Q. �� �μ��� ��ձ޿� �ݾ��� 2000 �̻��� �μ��� ����ϴ� SQL��
select deptno,avg(sal) from emp group by deptno having avg(sal) >= 2000;
--Q. �� �μ��� �ִ�޿� �ݾ��� 2900 �̻��� �μ��� ����ϴ� SQL�� �ۼ�
select deptno, max(sal) from emp group by deptno having max(sal) >= 2900;
-------------------------------------------------------------------------
-- ����(join)
-- : 2�� �̻��� ���̺��� �����ؼ� ������ ���ؿ��� ��

--Q. SCOTT ����� �Ҽӵ� �μ����� ����ϴ� SQL�� �ۼ�
--1. ������̺�(EMP)���� SCOTT����� �μ���ȣ�� ���Ѵ�.
select deptno from emp where ename = 'SCOTT';   -- 20
--2. �μ����̺�(DEPT)���� 20�� �μ��� �μ����� ���Ѵ�.
select dname from dept where deptno = 20;   -- RESEARCH

-- CROSS JOIN
select * from dept, emp;        -- 4 * 14 = 56�� ������ �˻�
select * from emp, dept;        -- 14 * 4 = 56�� ������ �˻�

-- CROSS JOIN ����
-- 1.� ���� (Equi Join)
-- 2.�� ���� (Non-Equi Join)
-- 3.��ü���� (Self Join)
-- 4.�ܺ����� (Outer Join)

--1.� ����(Equi Join)
--  : �� ���̺� ������ �÷��� �������� ����
select * from dept, emp where dept.deptno = emp.deptno;  -- 14���� ������ �˻�

--Q. SCOTT ����� �Ҽӵ� �μ����� ����ϴ� SQL�� �ۼ�? (���� �̿�)
select ename, dname from dept, emp 
    where dept.deptno=emp.deptno and ename='SCOTT';
 
-- �����÷�(deptno)�� ���̺�.�����÷��� �������� ����ؾ� �Ѵ�.
-- �����÷��� �ƴ� �÷����� �տ� ���̺���� ������ �� �ִ�.
select deptno, ename, dname from dept, emp 
    where dept.deptno=emp.deptno and ename='SCOTT';   -- ���� �߻� 

select dept.deptno, emp.ename, dept.dname from dept, emp    -- dept.deptno
    where dept.deptno=emp.deptno and emp.ename='SCOTT'; 
    
select emp.deptno, emp.ename, dept.dname from dept, emp    -- emp.deptno
    where dept.deptno=emp.deptno and emp.ename='SCOTT';  
    
-- ���̺� ��Ī �ο��ϱ�
--1.���̺� ���� ��Ī�� �ο��� ���� ���ʹ� ���̺���� ����� �� ����, 
--  ��Ī�� ����ؾ� �ȴ�.
--2. ��Ī���� ��.�ҹ��ڸ� �������� �ʴ´�.
--3. ���� �÷�(deptno)�� ��Ī��.�����÷��� �������� ����ؾ� �ȴ�. ex) D.deptno
--4. ���� �÷��� �ƴ� �÷����� �տ� ��Ī���� ���� �� �� �ִ�.
select D.deptno, E.ename, D.dname from dept D, emp E
    where D.deptno=E.deptno and E.ename='SCOTT';
 
select DEPT.deptno, E.ename, D.dname from dept D, emp E
    where D.deptno=E.deptno and E.ename='SCOTT';   -- �����߻� : ���̺���� ����� �� ����. 
    
select d.deptno, E.ename, D.dname from dept D, emp E
    where D.deptno=E.deptno and E.ename='SCOTT';  -- ��Ī���� ��.�ҹ��ڸ� �������� �ʴ´� 
    
-- 2. �� ����
-- : ������ �÷����� �ٸ� ������ ����Ͽ� ����
--Q. ������̺� �ִ� �� ������� �޿��� �� ��������� ����ϴ� SQL�� �ۼ�
--  EMP(SAL) - SALGRADE(GRADE)
select ename, sal, grade from emp, salgrade
    where sal between losal and hisal;

select e.ename, e.sal, s.grade from emp e, salgrade s 
    where e.sal between s.losal and s.hisal;
    
--3. ��ü����(Self Join)
-- : �� ���� ���̺� ������ �÷��� �÷� ������ ���踦 �̿��ؼ� ����
--Q. ��ü������ �̿��� ��� ���̺��� �� ������� ������ �Ŵ����� ����ϴ� SQL�� �ۼ�
-- EMP(EMPNO)-EMP(MGR)

select employee.ename || '�� �Ŵ����� ' || manager.ename
    from emp employee, emp manager
    where employee.mgr = manager.empno;
    
-- 13���� �˻� ����� ��µȴ�.
-- KING ����� ���ӻ���� ���� ������ ��µ��� �ʴ´�.   

--4.�ܺ�����(Outer Join)
-- : ���� ������ �������� �ʴ� �����͸� ������ִ� ����
-- 1) ���̺��� ������ �� ��� ������ ���̺��� �����Ͱ� ����������, �ٸ� ���̺���
--    �����Ͱ� �������� �ʴ� ��쿡, �� �����Ͱ� ��µ��� �ʴ� ������ �ذ��ϱ� ���ؼ�
--    ���Ǵ� ���ι��
-- 2) ������ ������ ���� (+)�� �߰��Ѵ�.

--Q1. ���� ��ü����(Self Join)�� ���,KING����� ���ӻ���� ���� ������ ��µ��� 
-- �ʾҴµ�, King ����� �ܺ������� �̿��ؼ� ����ϼ���
select employee.ename || '�� �Ŵ�����' || manager.ename 
from emp employee, emp manager
where employee.mgr = manager.empno(+);

--Q2. �μ����̺�(DEPT)�� 40�� �μ��� ������ ������̺�(EMP)�� �μ���ȣ���� ��Ÿ����
-- ������, 40�� �μ��� �μ����� ����ϴ� SQL�� �ۼ�
-- 1) DEPT - EMP � ���� : 40�� �μ��� ��¾ȵ�
select ename, d.deptno, dname from dept d, emp e
where d.deptno = e.deptno;

-- 2) �ܺ����� : ��µ��� �ʴ� 40�� �μ��� ������ִ� ����
select ename, d.deptno, dname from dept d, emp e
where d.deptno = e.deptno(+);

-------------------------------------------------------------------
-- ANSI JOIN
-- : ANSI(�̱� ǥ�� ��ȸ) ǥ�ؾȿ� ���� ������� JOIN ���
select * from dept cross join emp;
select * from emp cross join dept;

-- ANSI INNER JOIN
--Q. SCOTT����� �Ҽӵ� �μ����� ��� SQL�� �ۼ�
select ename, dname from dept inner join emp
    on dept.deptno = emp.deptno where ename='SCOTT';

-- using�� �̿��ؼ� ����
select ename, dname from dept inner join emp
    using(deptno) where ename='SCOTT';
    
-- ANSI NATURAL JOIN
-- : DEPT�� EMP ���̺� ������ �����÷��� ���ٴ� �ǹ̸� ������ ����.
select ename, dname from dept natural join emp where ename='SCOTT';