-- 2021.07.16(��)

-- ���̺� ���
select * from tab;

-- dept���̺� ���� Ȯ��
describe dept;
desc dept;

-- dept ������ �˻�
select * from dept;

-- emp ���̺� ����
desc emp;

-- emp ���̺� �˻�
select * from  emp;

-- select SQL��
select * from dept;
select loc, dname, deptno from dept;

select * from emp;
select empno, ename, sal from emp;

-- ��� ������ : +, -, *, /
select ename, sal, sal*12 from emp;
select sal + comm from emp;
select sal - 100 from emp;
select sal * 12 from emp;
select sal / 12 from emp;

-- NULL
--1. �������� ���� ���� �ǹ�
--2. NULL���� ��������� �� �� ����.
--3. NULL ���� ��
--   EX) EMP ���̺� : MGR �÷�
--                   COMM �÷�

-- Q. EMP ���̺� �ִ� �� ������� ������ ���غ���?
--    ���� = �޿�(SAL) * 12  +  Ŀ�̼�(COMM)

select ename, job, sal, comm, sal*12, sal*12+comm from emp;

-- NVL(�÷�, ��ȯ�ɰ�) : NULL���� �ٸ� ��(0)���� ��ȯ ���ִ� �Լ�
-- NVL(comm, 0) : comm�� null���� 0���� ��ȯ
select ename, sal, comm, sal*12, nvl(comm,0), sal*12+nvl(comm, 0) from emp;

-- ��Ī�ο� :  as  "��Ī��"
select ename, sal*12+nvl(comm, 0) as "Annsal" from emp;
select ename, sal*12+nvl(comm, 0) "Annsal" from emp;    -- as ��������
select ename, sal*12+nvl(comm, 0) Annsal from emp;      -- "" ��������  

-- ��Ī�� ���Ⱑ ���� ��쿡�� �ֵ���ǥ�� ������ �� ����.
select ename, sal*12+nvl(comm, 0) as "����" from emp;
select ename, sal*12+nvl(comm, 0) "����" from emp;       -- as ��������
select ename, sal*12+nvl(comm, 0) ���� from emp;         -- "" ��������  
select ename, sal*12+nvl(comm, 0) "��  ��" from emp;

-- Concatenation ������ : ||
-- : �÷��� ���ڿ��� �����Ҷ� ����
select ename, 'is a', job from emp;

select ename || ' is a ' || job from emp;

-- distinct : �ߺ����� �����ϰ� 1���� ���
select deptno from emp;

select distinct deptno from emp; -- 3���� �μ���ȣ ��� : 10, 20, 30

-- EMP ���̺��� �� �����ͼ� ���ϱ�
-- count(�÷���) : ������ ���� ���ϱ�
select count(*) from dept;      -- 4
select count(*) from emp;       -- 14
select count(job) from emp;     -- 14

--Q. EMP ���̺��� �ߺ��� ������ JOB�� ������ ���ϴ� SQL�� �ۼ�?
select count(distinct job) from emp;    -- 5
select distinct job from emp;

------------------------------------------------------------------
-- where ������ : �� ������ ( =, >, >=, <, <=, !=, <>, ^= )

--1. ���� ������ �˻�
--Q. ������̺�(EMP)���� �޿��� 3000�̻� �޴� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where sal >= 3000;

--Q. �޿��� 3000�� ����� �˻�?
select * from emp where sal = 3000;

--Q. �޿��� 3000�� �ƴ� ����� �˻�?
select * from emp where sal != 3000;
select * from emp where sal <> 3000;
select * from emp where sal ^= 3000;

--Q. �޿��� 1500������ ����� �����ȣ, �����, �޿��� ����ϴ� SQL�� �ۼ�?
select empno, ename, sal from emp where sal <= 1500;


--2. ���� ������ �˻�
-- 1) ���� �����ʹ� ��.�ҹ��ڸ� �����Ѵ�.
-- 2) ���� �����͸� �˻��Ҷ��� ���ڿ� ��.�쿡 �ܵ���ǥ(')�� �ٿ��� �Ѵ�.

--Q. ��� ���̺��� ������� FORD�� ����� ������ �˻��ϴ� SQL�� �ۼ�?
select * from emp where ename = 'ford';     -- �˻���� ����
select * from emp where ename = FORD;       -- �����߻�
select * from emp where ename = "FORD";     -- �����߻�
select * from emp where ename = 'FORD';     -- �������� �˻�

--Q. SCOTT ����� �����ȣ, �����, �޿��� ����ϴ� SQL�� �ۼ�?
select empno, ename, sal from emp where ename = 'SCOTT';


--3. ��¥ ������ �˻�
-- 1) ��¥ �����͸� �˻��Ҷ� ��¥ ��.�쿡 �ܵ���ǥ(')�� �ٿ��� �Ѵ�.
-- 2) ��¥ �����͸� ���Ҷ� �� �����ڸ� ����Ѵ�.

--Q. 1982�� 1�� 1�� ���Ŀ� �Ի��� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where hiredate >= 82/01/01;       -- �����߻�
select * from emp where hiredate >= '82/01/01';     -- �������� �˻�
select * from emp where hiredate >= '1982/01/01';   -- �������� �˻�

------------------------------------------------------------------------
-- �� ������ : and, or, not
--1. and ������ : �� ���ǽ��� ��� �����ϴ� �����͸� �˻�
--Q.��� ���̺��� �μ���ȣ�� 10���̰�, job�� MANAGER�� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where deptno=10 and job='MANAGER';

--2. or ������ : �� ���ǽ� �߿��� �Ѱ����� �����ص� �˻�
--Q.��� ���̺��� �μ���ȣ�� 10�̰ų�, JOB�� MANAGER�� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where deptno=10 or job='MANAGER';

--3. not ������ : ������ �ݴ�� �ٲ��ִ� ����
--Q.�μ���ȣ�� 10�� �ƴ� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where deptno = 10;        -- 10�� �μ�

select * from emp where not deptno = 10;    -- �� ������
select * from emp where deptno != 10;       -- �� ������
select * from emp where deptno <> 10;       -- �� ������
select * from emp where deptno ^= 10;       -- �� ������

--Q1. �޿��� 2000���� 3000 ������ �޿��� �޴� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where sal >= 2000 and sal <=3000;

--Q2. Ŀ�̼��� 300�̰ų� 500�̰ų� 1400�� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where comm=300 or comm=500 or comm=1400;

--Q3. �����ȣ�� 7521�̰ų� 7654�̰ų� 7844�� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where empno=7521 or empno=7654 or empno=7844;


-- between and ������
-- : where  �÷���  between  ������  and ū��
--Q. �޿��� 2000���� 3000 ������ �޿��� �޴� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where sal >= 2000 and sal <=3000;

select * from emp where sal between 2000 and 3000;

select * from emp where sal between 3000 and 2000;      -- �˻� ��� ����

--Q. �޿��� 2000�̸��̰ų� 3000 �ʰ��� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where sal < 2000 or sal > 3000;
select * from emp where sal not between 2000 and 3000;

--Q.1987�⵵ �Ի��� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where hiredate >= '87/01/01' and hiredate <= '87/12/31';
select * from emp where hiredate between '87/01/01' and '87/12/31';
