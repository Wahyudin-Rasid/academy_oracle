-- 2021.07.28

-- PL/SQL

--Q. Hello World~!! ���
set SERVEROUTPUT on
begin
DBMS_OUTPUT.PUT_LINE('Hello World~!!');
end;

-- ���� ����ϱ�
set SERVEROUTPUT on
declare                                 -- ����� ����
    vempno number(4);                   -- ���� ���� : ��Į�� ���� 
    vename varchar2(10);
begin                                   -- ����� ����
    vempno := 7788;                     -- �������� ��.�ҹ��ڸ� �������� �ʴ´�.
    vename := 'SCOTT';
    DBMS_OUTPUT.PUT_LINE('��� / �̸�');
    DBMS_OUTPUT.PUT_LINE(VEMPNO || '/' || VENAME);
end;                                    -- ����� ��

-- ����� �̸� �˻��ϱ�
set SEVEROUTPUT on
declare
    vempno emp.empno&type;  -- ���۷��� ����(emp ���̺��� empno Ÿ������)
    vename emp.ename&type;
begin
    select empno, ename into vempno, vename from emp where ename='SCOTT';
    DBMS_OUTPUT.PUT_LINE('���/�̸�');
    DBMS_OUTPUT.PUT_LINE(vempno || '/' || vename);
end;
