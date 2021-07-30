-- 2021.07.30(��)

-- ���� �Լ�
--Q2. ������� �����Լ��� �Ű������� �����Ͽ� �ش� ����� ������ ���ؿ��� �Լ�
--1. �����Լ� ����
create or replace function job_emp(vename in emp.ename%type)
    return varchar2
is
    vjob emp.job%type;  -- ���� ����
begin
    select job into vjob from emp where ename = vename;
    return vjob;
end;
/
--2. ���� �Լ� ��� Ȯ��
select * from user_source;
--3. ���ε� ���� ����
variable varr_job varchar2(10);

execute :varr_job := job_emp('SCOTT');
print varr_job;

-- ���� �Լ��� SQL���� �����ؼ� ����
select ename, job_emp('KING') from emp where ename = 'KING';

-- ī��(cursor)
-- : 2�� �̻��� �����͸� ó���� �� Ŀ���� �����

--Q1. �μ� ���̺��� ��� �����͸� ����ϱ� ���� PL/SQL �ۼ�
--1. ���� ���ν��� ����
set serveroutput on
create or replace procedure cursor_sample01
is
    vdept dept%rowtype;
    cursor c1
    is
    select * from dept;
begin
    dbms_output.put_line('�μ���ȣ / �μ��� / ������');
    dbms_output.put_line('--------------------------');
    
    open c1;
        loop
            fetch c1 into vdept.deptno, vdept.dname, vdept.loc;
            exit when c1%notfound;
        dbms_output.put_line(vdept.deptno||'/'||vdept.dname||'/'||vdept.loc);
        end loop;
    close c1;
end;
/
--2. ���ν��� ��� Ȯ��
select * from user_source;

--3. ���ν��� ����
execute cursor_sample01;

--Q2. �μ� ���̺��� ��� ������ ����ϱ� : For Loop������ ó��
-- 1. open - fetch - close ���� ó���� �� �ִ�
-- 2. for loop���� ����ϰ� �Ǹ� �� �ݺ��� ����, cursor�� ����, �� ���� ����(Fetch)

--1. ���� ���ν��� ����
create or replace procedure cursor_sample02
is
    vdept dept%rowtype;
    
    cursor c1
    is
    select* from dept;
begin
    dbms_output.put_line('�μ���ȣ / �μ��� / ������');
    DBMS_OUTPUT.PUT_line('----------------');
    
    for vdept in c1 loop
        exit when c1%notfound;
        dbms_output.put_line(vdept.deptno||'/'||vdept.dname||'/'||vdept.loc);
    end loop;
end;
/
--2. ���ν��� ��� Ȯ��
select * from user_source;
--3. ���ν��� ����
execute cursor_sample02;

--Q3. �μ���ȣ�� �����Ͽ� �ش� �μ��� �Ҽӵ� ����� ������ ����ϴ� ���ν����� 
--    Ŀ���� �̿��ؼ� ó���ϼ���
--1. ���� ���ν��� ����
create or replace procedure info_emp(vdeptno in emp.deptno%type)
is
    vemp emp%rowtype;
    
    cursor c1
    is
    select * from emp where deptno = vdeptno;
begin
    dbms_output.put_line('�μ���ȣ / �����ȣ / ����� / ���� / �޿�');
    dbms_output.put_line('-------------------------------------');
    for vemp in c1 loop
        DBMS_OUTPUT.PUT_LINE(vemp.deptno||'/'||vemp.empno||'/'||vemp.job||'/'||vemp.sal);
        exit when c1%notfound;
    end loop;
end;
/
execute info_emp(10);
---------------------------------------------------------------

-- ��Ű��(package) = ���� �Լ� : ���� ���ν���

-- ��Ű��(package) = ���� �Լ� + ���� ���ν���
 
--1. ��Ű�� ��� ����
create or replace package exam_pack
is
    function cal_bonus(vempno in emp.empno%type)        --  ���� �Լ�
        return number;
    procedure cursor_sample02;                          -- ���� ���ν��� 
end; 
 
--2. ��Ű�� �ٵ� ���� 
create or replace package body exam_pack
is

-- ���� �Լ� : cal_bonus()
function cal_bonus(vempno in emp.empno%type)        --  ���� �Լ�
    return number
is
    vsal number(7,2);
begin
    select sal into vsal from emp where empno = vempno;
    return vsal * 2;
end;

-- ���� ���ν��� : cursor_sample02
procedure cursor_sample02
is
    vdept dept%rowtype;
    
    cursor c1                   -- Ŀ�� ����
    is
    select * from dept;
begin
    DBMS_OUTPUT.PUT_LINE('�μ���ȣ  /  �μ���  /  ������');    
    DBMS_OUTPUT.PUT_LINE('---------------------------');
    
    for vdept in c1 loop
        exit when c1%notfound;
        DBMS_OUTPUT.PUT_LINE(vdept.deptno||'/'||vdept.dname||'/'||vdept.loc);
    end loop;
end;

end;
/
--3. ���� ���ν��� ���� : cursor_sample02
execute  exam_pack.cursor_sample02;

--4. ���� �Լ� ���� : cal_bonus()
-- ���ε� ���� ����
variable var_res number;

execute :var_res := exam_pack.cal_bonus(7788);
print var_res;

select ename, exam_pack.cal_bonus(7788) from emp where empno = 7788;

-- Ʈ����(trigger)
--Q1. ��� ���̺� ����� ��ϵǸ�, "���Ի���� �Ի��߽��ϴ�" �� ����ϴ� Ʈ����
--1. emp01 ���̺� ����
drop table emp01 purge;
create table emp01(
    empno number(4) primary key,
    ename varchar2(20),
    job varchar2(20) );

--2. Ʈ���� ����
set serveroutput on
create or replace trigger trg_01
    after insert on emp01
begin
    dbms_output.put_line('���Ի���� �Ի��߽��ϴ�');
end;
/
select * from user_triggers;
--3. emp ���̺� ��� �Ի��Ű��
insert into emp01 values(1111,'��ȣ','������');

--Q2. ��� ���̺�(EMP01)�� ���Ի���� ��ϵǸ�, �޿� ���̺�(SAL01)��
--    �޿������� �ڵ����� �߰����ִ� Ʈ����

--1. ��� ���̺� ���� : EMP01
delete from emp01;
commit;

--2. �޿� ���̺� ���� : SAL01
create table sal01(
    salno number(4) primary key,
    sal number(7,2),
    empno number(4) references emp01(empno) ); 

select * from tab;

--3. ������ ����
create sequence sal01_salno_seq;
select * from seq;

--4. Ʈ���� ����
create or replace trigger trg_02
    after insert on emp01           -- �̺�Ʈ �߻�
    for each row                    -- �෹�� Ʈ����
begin
    insert into sal01 values(sal01_salno_seq.nextval, 100, :new.empno);
end;
/
--5. Ʈ���� ��� Ȯ��
select * from user_triggers;

--6. �̺�Ʈ �߻� : ȸ������
insert into emp01 values(1111,'��ȭ��','���α׷���');
insert into emp01 values(1112,'ȫ�浿','������');
insert into emp01 values(1113,'�̼���','ANALYST');

--7. ������ Ȯ��
select * from emp01;
select * from sal01;






--Q3. ȸ�� ������ �����Ǹ�, �޿� ������ �ڵ����� �����ϴ� Ʈ���� ����
delete from emp01 where empno=1111;     -- ���� �ȵ�

--1. Ʈ���� ����
create or replace trigger trg_03
    after delete on emp01           -- �̺�Ʈ
    for each row
begin
    delete from sal01 where empno = :old.empno; 
end;
/
--2. Ʈ���� ��� Ȯ��
select * from user_triggers;

--3. �̺�Ʈ �߻�
--  : ��� ���̺�(EMP01)�� �����ȣ 1111�� ����� ����(Ż��)�ϸ� ���������� 
--    �޿� ���̺�(SAL01)�� �޿� ������ ���� �����ȴ�.
delete from emp01 where empno = 1111;
delete from emp01 where empno = 1112;
delete from emp01 where empno = 1113;

--4. ��� Ȯ��
select * from emp01;
select * from sal01;


