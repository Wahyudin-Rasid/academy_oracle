--����
select * from emp;
--Q1. ������̺�(EMP)���� �Ի���(HIREDATE)�� 4�ڸ� ������ ��� �ǵ��� SQL���� �ۼ��ϼ���? (ex. 1980/01/01)
select hiredate, to_char(hiredate,'yyyy-mm-dd') from emp;
--Q2. ������̺�(EMP)���� MGR�÷��� ���� null�� �������� MGR�� ����  CEO ��  ����ϴ� SQL���� �ۼ� �ϼ���?
select nvl(to_char(mgr),'CEO') from emp;
--Q3. ��� ���̺�(EMP)���� ���� �ֱٿ� �Ի��� ������� ����ϴ� SQL���� �ۼ� �ϼ���?
select ename from emp where hiredate = (select max(hiredate) from emp);
--Q4. ��� ���̺�(EMP)���� �ִ� �޿��� �޴� ������ �ִ�޿� �ݾ��� ����ϴ� SQL���� �ۼ� �ϼ���?
select ename, sal from emp where sal = (select max(sal) from emp);