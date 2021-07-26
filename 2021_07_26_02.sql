-- 2021_07_26_02(��)

-- ��(view) : �⺻ ���̺��� �̿��ؼ� ������� ���� ���̺�

-- �ǽ��� ���� �⺻ ���̺� ���� : dept_copy, emp_copy

-- 2���� �⺻ ���̺� ����
create table dept_copy as select * from dept;
create table emp_copy as select * from emp;
select * from dept_copy;
select * from emp_copy;

-- �� ����
create view emp_view30
as
select empno, ename, deptno from emp_copy where deptno=30;
-- ���� �߻�. SCOTT������ ���̺��� ������ �� ������ ��� ������ ������ ����

-- �� Ȯ��
select * from user_views;

desc emp_view30;
select * from emp_view30;

--Q. ��(EMP_COPY30)�� insert�� �����͸� �Է� ���� ��쿡, �⺻ ���̺�
--   (EMP_COPY)�� �����Ͱ� �Է� �ɱ��
insert into emp_view30 values(1111,'����ȣ',30);   -- 

select * from emp_view30;   -- �ϴ� ����� �Էµ�
select * from emp_copy; -- �̰� �ǳ�

-- ���� ����
-- �ܼ��� : �ϳ��� �⺻ ���̺�� ������ ��
-- ���պ� : �������� �⺻ ���̺�� ������ ��

-- �ܼ���
--Q. �⺻ ���̺��� emp_copy�� �̿��ؼ� 20�� �μ��� �Ҽӵ� �������
--   ����� �̸�, �μ���ȣ, ���ӻ���� ����� ����ϱ� ���� ��(EMP_VIEW20) ����
create view emp_view20 as select empno,ename,deptno,mgr
from emp_copy where deptno = 20;
-- �� Ȯ��
select * from user_views;

-- ���պ�
--Q. �� �μ���(�μ���) �ִ�޿��� �ּұ޿��� ����ϴ� ��(sal_view)�� ����
create view sal_view as select dname, max(sal) MAX, min(sal) MIN
from dept, emp where dept.deptno = emp.deptno group by dname;
-- �� ������ Ȯ��
select * from sal_view;
