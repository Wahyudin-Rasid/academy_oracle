--����.
select * from emp;

--       Q1. SMITH�� ������ ������ ���� ����� �̸��� ������ ����ϴ� 
--            SQL���� �ۼ� �ϼ���?
select ename, job from emp where job = 
    (select job from emp where ename = 'SMITH');
--       Q2. ������ 'SALESMAN'�� ����� �޴� �޿����� �ִ� �޿�����
-- 	���� �޴� ������� �̸��� �޿��� ����ϵ� �μ���ȣ�� 
--	20���� ����� �����Ѵ�.(ALL������ �̿�)
select ename, sal from emp where sal > 
all(select max(sal) from emp where job = 'SALESMAN')
and deptno != 20;
--
--       Q3. ������ 'SALESMAN'�� ����� �޴� �޿����� �ּ� �޿����� 
-- 	���� �޴� ������� �̸��� �޿��� ����ϵ� �μ���ȣ�� 
--	20���� ����� �����Ѵ�.(ANY������ �̿�)
select ename, sal, deptno from emp where sal >
any(select min(sal) from emp where job = 'SALESMAN')
and deptno != 20;
