--2021_07_21 ����
select * from emp;
select * from dept;
--����.
--       Q1. ������ MANAGER�� ����� �̸�, �μ����� ����ϴ� SQL����
--             �ۼ� �ϼ���? (JOIN�� ����Ͽ� ó��)
select e.ename, d.dname from emp e, dept d where e.job='MANAGER' and e.deptno = d.deptno;
--   
--       Q2. �Ŵ����� KING �� ������� �̸��� ������ ����ϴ� SQL�� �ۼ�?
select employee.ename, employee.job from emp employee, emp manager where employee.mgr = manager.empno;
--
--       Q3. SCOTT�� ������ �ٹ������� �ٹ��ϴ� ����� �̸��� ����ϴ� SQL�� �ۼ�?
select ename from emp where deptno = (select deptno from emp where ename = 'SCOTT');

