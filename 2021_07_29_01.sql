-- 2021.07.29(��)

-- ���ǹ�(=���ù�)
--1. if ~ then ~ end if
--Q. SCOTT ����� �μ���ȣ�� �˻��ؼ� �μ����� ��� PL/SQL �ۼ�?

SET SERVEROUTPUT ON
declare                             -- �����
    vempno number(4);
    vename varchar2(20);
    vdeptno dept.deptno%type;
    vdname varchar2(20) := null;
begin                               -- �����
    select empno, ename, deptno into vempno, vename, vdeptno from emp
        where ename = 'SCOTT';
    
    if vdeptno = 10 then
        vdname := 'ACCOUNTING';
    end if;
    if vdeptno = 20 then
        vdname := 'RESEARCH';
    end if;
    if vdeptno = 30 then
        vdname := 'SALES';
    end if;
    if vdeptno = 40 then
        vdname := 'OPERATIONS';
    end if;
    
    DBMS_OUTPUT.PUT_LINE('��� / �̸� / �μ���');
    DBMS_OUTPUT.PUT_LINE(vempno || '/' || vename || '/' || vdname);
end;

--Q. ��� ���̺��� SCOTT ����� ������ ���ϴ� PL/SQL �ۼ� ?
SET SERVEROUTPUT ON
declare
    vemp emp%rowtype;           -- ���۷��� ����
    annsal number(7,2);         -- ��Į�� ����
begin
    select *  into vemp from emp where ename = 'SCOTT';
    
    if vemp.comm is null then
        vemp.comm := 0;
    end if;
    
    annsal := vemp.sal * 12 + vemp.comm;
    DBMS_OUTPUT.PUT_LINE('��� / �̸� / ����');
    DBMS_OUTPUT.PUT_LINE(vemp.empno || '/' || vemp.ename || '/' || annsal);
end;


--2. if ~ then ~ else ~ end if
--Q. ��� ���̺��� SCOTT ����� ������ ���ϴ� PL/SQL �ۼ� ?
set SERVEROUTPUT ON
declare
    vemp emp%rowtype;           -- ���۷��� ����
    annsal number(7,2);         -- ��Į�� ����
begin
      select * into vemp from emp where ename = 'SCOTT';
      
      if vemp.comm is null then
        annsal := vemp.sal * 12;
      else
        annsal := vemp.sal * 12 + vemp.comm;
      end if;
        
      DBMS_OUTPUT.PUT_LINE('��� / �̸� / ����');
      DBMS_OUTPUT.PUT_LINE(vemp.empno || '/' || vemp.ename || '/' || annsal);  
end;

--3. if ~ then ~ elsif ~ else ~ end if
--Q. �μ� ��ȣ�� �̿��ؼ� �μ����� ���ϴ� PL/SQL �ۼ�?
SET SERVEROUTPUT ON
declare
    vemp emp%rowtype;
    vdname varchar2(14);
begin
    select * into vemp from emp where ename = 'SCOTT';

    if vemp.deptno = 10 then
        vdname := 'ACCOUNTING';
    elsif vemp.deptno = 20 then
        vdname := 'RESEARCH';
    elsif vemp.deptno = 30 then
        vdname := 'SALES';
    elsif vemp.deptno = 40 then
        vdname := 'OPERATIONS';
    end if;
    
    DBMS_OUTPUT.PUT_LINE('��� / �̸� / �μ���');
    DBMS_OUTPUT.PUT_LINE(vemp.empno || '/' || vemp.ename || '/' || vdname);
end;
    

-- �ݺ���
--1. Basic Loop��
-- loop
--    �ݺ� ����� ����;
-- end loop;

--Q1. 1 ~ 5���� ���
SET SERVEROUTPUT ON
declare
    n number := 1;          -- ������ �ʱⰪ 1
begin
    loop
        DBMS_OUTPUT.PUT_LINE(n);
        n := n + 1;
        if n > 5 then
            exit;
        end if;
    end loop;
end;


--Q2. 1���� 10���� ���� ���ϴ� ���α׷� �ۼ�
SET SERVEROUTPUT ON
declare
    n number := 1;          -- ������ ���� ����
    s number := 0;          -- ���� ������ ����
begin
    loop
        s := s + n;
        n := n + 1;
        if n > 10 then
            exit;
        end if;        
    end loop;
    DBMS_OUTPUT.PUT_LINE('1~10������ ��:' || s);
end;


--2. For Loop��
--Q1. For Loop������ 1���� 5���� ���
set SERVEROUTPUT ON
begin
    for n in 1..5 loop          --- �ڵ����� 1�� ����
        DBMS_OUTPUT.PUT_LINE (n);      
    end loop;
end;

--Q2. For Loop������ 5���� 1���� ���
set SERVEROUTPUT ON
begin
    for n in reverse 1..5 loop          --- �ڵ����� 1�� ����
        DBMS_OUTPUT.PUT_LINE (n);      
    end loop;
end;

--Q3. For Loop���� �̿��ؼ� �μ� ���̺�(DEPT)�� ��� ������ ����ϴ� PL/SQL �ۼ�?
SET SERVEROUTPUT ON
declare
    vdept dept%rowtype;
begin
    DBMS_OUTPUT.PUT_LINE('�μ���ȣ / �μ��� / ������');
    for cnt in 1..4 loop
        select * into vdept from dept where deptno = 10 * cnt;
        
        DBMS_OUTPUT.put_line(vdept.deptno||'/'||vdept.dname||'/'||vdept.loc);
    end loop;
end;


--3. while loop��
--Q1. while loop������ 1���� 5���� ���
set SERVEROUTPUT ON
declare
    n number := 1;
begin
    while n<=5 loop
        DBMS_OUTPUT.PUT_LINE(n);
        n := n + 1;
    end loop;
end;

--Q2. while loop���� ��(*)�� �ﰢ�� ������� ���
set SERVEROUTPUT ON
declare
    c number := 1;
    str varchar2(100) := null;
begin
    while c<=5 loop
        str := str || '*';
        DBMS_OUTPUT.put_line(str);
        c := c + 1;
    end loop;
end;





