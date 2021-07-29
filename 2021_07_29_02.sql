-- 2021.07.29(��)

-- ���� ���ν���

--[�ǽ�]
drop table emp01 purge;
create table emp01 as select * from emp;
select * from emp01;

--1. ���� ���ν��� ����
create or replace procedure del_all
is
begin
    delete from emp01;
end;

--2. ���ν��� ��� Ȯ��
select * from user_source;

--3. ���ν��� ����
execute del_all;

--4. ���ν��� ���� Ȯ��
select * from emp01;        -- ���ν����� ���ؼ� �����Ͱ� ��� ������

rollback;
insert into emp01 select * from emp;
----------------------------------------------------------------------
-- �Ű������� �ִ� ���ν���
--1. �Ű������� �ִ� ���ν��� ����
create or replace procedure del_ename(vename in emp01.ename%type)
is
begin
    delete from emp01 where ename = vename;
end;

--2. ���ν��� ��� Ȯ��
select * from user_source;

--3. ���ν��� ����
select * from emp01;
execute del_ename('SCOTT');
execute del_ename('KING');
execute del_ename('SMITH');
---------------------------------------------------------------------
-- �Ű������� MODE�� in, out���� �Ǿ��ִ� ���ν���
-- in : �Ű������� ���� �޴� ����
-- out : �Ű������� ���� �����ִ� ����

--1. ���ν��� ����
--   �����ȣ�� ���ν����� �Ű������� ���� �޾Ƽ� �� ����� �����, �޿�, ��å��
--   ���ϴ� ���ν��� ����
create or replace procedure sal_empno (
    vempno in emp.empno%type,
    vename out emp.ename%type,
    vsal out emp.ename%type,
    vjob out emp.job%type)
is
begin
    select ename, sal job into vename, vsal, vjob, from emp
        where empno = vempno;
end;
/
create table emp01 as select * from emp;
select * from emp01;
drop table emp01 purge;
select * from customer;
insert into customer values('����ȣ','holioud@naver.com','010','1');
    
create or replace procedure sel_customer
( vname in customer.name%TYPE,
  vemail out customer.email%TYPE,
  vtel out customer.tel%TYPE)

is
begin
	select email, tel into vemail, vtel from customer
	where name = vname;
end;
/    

variable var_email varchar2(20);
variable var_tel varchar2(20);

execute sal_customer(1,:var_email,:var_tel);
print var_email;
print var_tel;
end;
/

-- ���� �Լ�
-- 1. ���� ���ν����� ������ ����� ����������, �������� �����ִ� ���̰� ����

--Q1. ��� ���̺��� Ư�� ����� �޿��� 200% �λ��ϴ� ����� �����ִ� �����Լ�
create or replace function cal_bonus(vempno in emp.empno%type)
    return number
is
    vsal number(7,2);
begin
    select sal into vsal from emp where empno = vempno;
    return vsal * 2;
end;

variable var_res number;
execute :var_res := cal_bonus(7788);
print var_res;

-- ���� �Լ��� SQL���� �����ؼ� ����
select sal,cal_bonus(7788) from emp where empno = 7788;