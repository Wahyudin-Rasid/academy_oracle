-- 2021.07.19(��)

-- in������
-- : where  �÷���  in  (������1, ������2,...)
-- Q. Ŀ�̼��� 300�̰ų� 500�̰ų� 1400�� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where comm=300 or comm=500 or comm=1400;

select * from emp where comm in(300, 500, 1400);

--Q. Ŀ�̼��� 300, 500, 1400�� �ƴ� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where comm!=300 and comm!=500 and comm!=1400;

select * from emp where comm not in(300, 500, 1400);

--Q. �����ȣ�� 7521�̰ų� 7844�� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where empno=7521 or empno=7844;

select * from emp where empno in(7521, 7844);

----------------------------------------------------------------
-- like �����ڿ� ���ϵ� ī��
-- : where  �÷���  like   pattern

-- ���ϵ� ī��
--1. % : ���ڰ� ���ų�, �ϳ� �̻��� ���ڿ� � ���� �͵� �������.
--2. _ : �ϳ��� ���ڿ� � ���� �͵� �������.

--Q. ������̺��� ������� �빮�� F�� �����ϴ� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where ename = 'FORD';         -- FORD ����� �˻���

select * from emp where ename like 'F%';

--Q.������̺��� ������� N���� ������ ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where ename like '%N';

--Q.������̺��� ������� A�� �����ϴ� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where ename like '%A%';

-- ����(_) ���ϵ� ī��
-- : �ϳ��� ���ڿ� � ���� �͵� �������.
--Q. ��� �̸��� �ι�° ���ڰ� A�� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where ename like '_A%';

--Q. ��� �̸��� ����° ���ڰ� A�� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where ename like '__A%';

--Q. ��� �̸��� ������ 2��° ���ڰ� E�� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where ename like '%E_';

-- not like ������
--Q. ����� A�� ���ԵǾ� ���� ���� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where ename like '%A%';       -- A�� ���Ե� ����˻�
select * from emp where ename not like '%A%';
-----------------------------------------------------------------------
--null �� �˻�
-- EMP ���̺� : MGR�÷�, COMM�÷�

--Q. MGR �÷��� null���� �����͸� �˻�?
select ename, job, mgr from emp where mgr = null;       -- �˻��ȵ�
select ename, job, mgr from emp where mgr = '';         -- �˻��ȵ�

select ename, job, mgr from emp where mgr is null;

--Q. MGR �÷��� null���� �ƴ� �����͸� �˻�?
select ename, job, mgr from emp where mgr is not null;

--Q. COMM �÷��� null ���� ������ �˻�?
select ename, job, mgr from emp where comm = null;      -- �˻��ȵ�
select ename, job, mgr from emp where comm = '';        -- �˻��ȵ�
select ename, job, mgr from emp where comm is null;  

--Q. COMM �÷��� null ���� �ƴ� ������ �˻�?
select ename, job, mgr from emp where comm is not null;

------------------------------------------------------------------------
-- ���� : order  by  �÷���   ���Ĺ��(asc or desc)
-- ���Ĺ�� : ��������(ascending), ��������(descending)

--           ��������                           ��������
-----------------------------------------------------------------------
-- ���� : ���� ���ں��� ū���ڼ� ����(1,2,3..)     ū���ں��� ���� ���ڼ� ����
-- ���� : ������ ���� (a, b, c....)              �������� ����(z, y, x...)
-- ��¥ : ������¥ ������ ����                    ���� ��¥ ������ ����
-- NULL : NULL ���� ���� �������� ���            NULL ���� ���� ���� ���

--1. ���� ������ ����
--Q. ��� ���̺��� �޿��� �������� �������� ���� : ���� ���ں��� ū���� ������ ����
select ename, sal from  emp order by sal asc;

-- ���Ĺ��(asc, desc)�� �����Ǹ�, �⺻���� ����� ������������ ������.
select ename, sal from  emp order by sal;       -- ���Ĺ��(asc) ����

--Q. ��� ���̺��� �޿��� �������� �������� ���� : ū ���ں��� �������� ������ ����
select ename, sal from  emp order by sal desc;

--2. ���� ������ ����
--Q. ��� ���̺��� ������� �������� �������� ���� : ������ ����
select ename from emp order by ename asc;
select ename from emp order by ename;           -- asc ���� ����

--Q. ��� ���̺��� ������� �������� �������� ���� : �������� ����
select ename from emp order by ename desc;

--3. ��¥ ������ ����
--Q. ��� ���̺��� �Ի����� �������� �������� ���� : ���� ��¥�� ����
select hiredate from emp order by hiredate asc;

--Q. ��� ���̺��� �Ի����� �������� �������� ���� : ���� ��¥�� ����
select hiredate from emp order by hiredate desc;

--4. NULL ����
-- 1) �������� ���� : NULL ���� ���� �������� ���
-- 2) �������� ���� : NULL ���� ���� ���� ���

--Q. MGR �÷��� �������� �������� ����
select mgr from emp order by mgr asc;       -- NULL ���� ���� �������� ���

--Q. MGR �÷��� �������� �������� ����
select mgr from emp order by mgr desc;      -- NULL ���� ���� ���� ���

--Q. COMM �÷��� �������� �������� ����
select comm from emp order by comm asc;      -- NULL ���� ���� �������� ���

--Q. COMM �÷��� �������� �������� ����
select comm from emp order by comm desc;      -- NULL ���� ���� ���� ���

-- ������ �����ϱ�
--1. �ѹ� ���������� ������ ����� ������ �����Ͱ� ���� ��쿡�� �ѹ� �� ������ �ؾ��Ѵ�.
--2. �ι�° ���� ������ �ѹ� ���������� ������ ����� ���� �����͸� �ι�° ����������
--   ���� �޴´�.
--3. ��� �Խ����� ���� ��쿡 �ַ� ����Ѵ�.

--Q. ��� ���̺��� �޿��� �������� �������� ������ �Ѵ�. �̶� ������ �޿��� �޴� 
--   ������� ������� �������� �������� �����ؼ� ����ϴ� SQL�� �ۼ�?
select ename, sal from emp order by sal desc;  -- 3000(2��), 1250(2��)

select ename, sal from emp order by sal desc, ename asc; 

-- ���� ����
--Q1. ��� ���̺��� �ڷῡ�� �Ի����� �������� ������������ �����Ͽ� ����ϵ� �����ȣ,
--   �����, ����, �Ի��� �÷��� ����ϴ� SQL�� �ۼ�?
select empno, ename, job, hiredate from emp order by hiredate asc;

--Q2. ��� ���̺��� �ڷῡ�� �����ȣ�� �������� ������������ �����Ͽ� �����ȣ�� �����
--    �÷��� ����ϴ� SQL�� �ۼ�?
select empno, ename from emp order by empno desc;

--Q3. �μ���ȣ�� ���� ������� ����ϵ�, ������ �μ����� ����� ����� ��쿡�� �ֱٿ�
--    �Ի��� ������� ����ϵ� �����ȣ, �Ի���, �����, �޿������� ����ϴ� SQL�� �ۼ�?
select empno, hiredate, ename, sal, deptno from emp  
    order by deptno asc, hiredate desc;