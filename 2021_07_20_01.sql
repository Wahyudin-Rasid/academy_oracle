-- 2021.07.20(ȭ)

-- 2. ���� ó�� �Լ�

-- substr() : ���ڿ��� �Ϻθ� �����ϴ� �Լ�
-- ���� : substr( ��� ���ڿ�, ������ġ, ������ ���ڰ��� )
-- ���� ��ġ ��ȣ�� ���ʺ��� 1������ �����Ѵ�.

select substr('Welcome to Oracle', 4, 3) from dual;     -- com ���
select substr('Welcome to Oracle', -4, 3) from dual;    -- acl ���    

--Q. ��� ���̺��� �Ի���(hiredate)�� ��, ��, ���� �����ؼ� ����ϴ� SQL�� �ۼ�?
select substr(hiredate,1,2) as "��", 
       substr(hiredate,4,2) as "��",
       substr(hiredate,7,2) as "��"  from emp;
       
--Q. ������̺��� 87�⵵�� �Ի��� ����� �˻��ϴ� SQL�� �ۼ�?
select * from emp where substr(hiredate, 1, 2) = '87';

--Q. ������̺��� ������� E�� ������ ����� �˻��ϴ� SQL�� �ۼ�? (2���� ���)
select * from emp where substr(ename, -1, 1) = 'E';
select * from emp where ename like '%E';

-- instr() : Ư�� ������ ��ġ�� �����ִ� �Լ�
-- instr(���, ã�� ����) : ���� ���� ������ ������ ��ġ�� ã���ش�.
-- instr(���, ã�� ����, ���� ��ġ, ���° �߰�)

--Q. ���� ���� ������ 'o' �� ��ġ�� ã���ش�.
select instr('Welcome to oracle', 'o') from dual;

--Q. 6�� ���Ŀ� 2��°�� �߰ߵ� 'o' �� ��ġ�� ã���ش�.
select instr('Welcome to oracle', 'o', 6, 2) from dual;

--Q. ������̺��� ������� 3��° �ڸ��� R�� �Ǿ��ִ� ����� �˻��ϴ� SQL�� �ۼ�?
--   3���� ��� : like ������, substr(), instr()
select * from emp where ename like '__R%';
select * from emp where substr(ename, 3, 1) = 'R';
select * from emp where instr(ename, 'R') = 3;
select * from emp where instr(ename, 'R', 3, 1) = 3;

-- lpad() / rpad() : Ư�� ��ȣ�� ä���ִ� �Լ�
select lpad('Oracle', 20, '#') from dual;   -- ##############Oracle
select rpad('Oracle', 20, '#') from dual;   -- Oracle##############

-- ltrim() : ���� ������ �����ϴ� �Լ�
-- rtrim() : ������ ������ �����ϴ� �Լ�
select  '  Oracle  ',  ltrim('  Oracle ') from dual;
select rtrim(' Oracle ') from dual;

-- trim() : ���ڿ� ��.���� ������ �����ϴ� �Լ�
--          Ư�� ���ڸ� �߶󳻴� �Լ�
select trim('  Oracle  ') from dual;
select trim('a' from 'aaaaaOracleaaaa') from dual;
---------------------------------------------------------------------

-- 3. ��¥ �Լ�
-- sysdate : �ý����� ��¥�� �����ִ� �Լ�
select sysdate from dual;       -- 21/07/20

select sysdate-1 ����, sysdate ����, sysdate+1 ���� from dual;

--Q. ������̺��� �� ������� ������� �ٹ��ϼ��� ���ϴ� SQL�� �ۼ�?
select sysdate - hiredate from emp;
select round(sysdate - hiredate) from emp;      -- �Ҽ� 1°�ڸ����� �ݿø�
select trunc(sysdate - hiredate) from emp;      -- �Ҽ��� �ڸ��� ����

-- round() : Ư�� �������� �ݿø� �ϴ� �Լ�
-- round( date, format )
-- �Ի����� �������� �ݿø�
select hiredate, round(hiredate, 'month') from emp;

-- trunc() : Ư�� �������� ������ �Լ�
-- trunc( date, format )
select hiredate, trunc(hiredate, 'month') from emp;

-- months_between() : �� ��¥ ������ ����� ���� ���� �����ִ� �Լ�
-- months_between( date1, date2 )
--Q. ������̺��� �� ������� �ٹ��� ���� ���� ���ϴ� SQL�� �ۼ�?
select ename, sysdate, hiredate, months_between(sysdate, hiredate) from emp;

select  months_between(sysdate, hiredate) from emp;
select  round(months_between(sysdate, hiredate)) from emp;
select  trunc(months_between(sysdate, hiredate)) from emp;

-- add_months() : Ư�� ��¥�� ����� ������ ��¥�� �����ִ� �Լ�
-- add_months( date, ������ )
--Q. ��� ���̺��� �� ������� �Ի��� ��¥�� 6������ ����� ���ڸ� ���ϴ� SQL�� �ۼ�?
select ename, hiredate, add_months(hiredate, 6) from emp;

--Q. ���� ��¥�� 6���� ����� ���ڸ� ���ϴ� SQL�� �ۼ�?
select sysdate, add_months(sysdate, 6) from dual;
select sysdate, add_months('21/06/15', 6) from dual;

-- next_day() : �ش� ������ ���� ����� ��¥�� �����ִ� �Լ�
-- next_day( date, ���� )
--Q.������ �������� ����� ������� �������� ���ϴ� SQL�� �ۼ�?
select sysdate, next_day(sysdate, '�����') from dual;
--select sysdate, next_day(sysdate, 'MONDAY') from dual;   -- ���� OS

-- last_day() : �ش� ���� ������ ��¥�� �����ִ� �Լ�
--Q. �� ������� �Ի��� ���� ������ ��¥�� ���ϴ� SQL�� �ۼ�?
select hiredate, last_day(hiredate) from  emp;

--Q.�̹����� ���� ������ ��¥�� ���ϴ� SQL�� �ۼ�?
select sysdate, last_day(sysdate) from dual;    -- 21/07/20	 21/07/31
select last_day('21/02/01') from dual;          -- 21/02/28
---------------------------------------------------------------------------

-- ����ȯ �Լ� : to_char(), to_date(), to_number()

--1. to_char() : ��¥��, ������ �����͸� ���������� ��ȯ�����ִ� �Լ�
--   to_char( ��¥ ������, '�������' )

--  1) ��¥�� �����͸� ���������� ��ȯ
-- Q. ���� �ý����� ��¥�� ��, ��, ��, ��, ��, ��, ������ ���
      select sysdate from dual;        -- 21/07/20

select sysdate, to_char(sysdate,'yyyy-mm-dd am hh:mi:ss dy') from  dual;
select sysdate, to_char(sysdate,'yyyy-mm-dd hh24:mi:ss day') from  dual;

--Q. ������̺��� �� ������� �Ի����� ��,��,��,��,��,��,������ ����ϴ� SQL�� �ۼ�?
select hiredate, to_char(hiredate,'yyyy-mm-dd hh24:mi:ss day') from emp;

--  2) ������ �����͸� ���������� ��ȯ
--     to_char( ���� ������, '���б�ȣ' )

--Q. ���� 1230000 �� 3�ڸ��� �ĸ��� �����ؼ� ���
select 1230000 from dual;

-- 0���� �ڸ����� �����ϸ�,������ ���̰� 9�ڸ��� ���� ������ 0���� ä���.
select 1230000, to_char(1230000, '000,000,000') from dual; --  001,230,000

-- 9���� �ڸ����� �����ϸ�,������ ���̰� 9�ڸ��� ���� �ʾƵ� ä���� �ʴ´�.
select 1230000, to_char(1230000, '999,999,999') from dual; -- 1,230,000

--Q. ������̺��� �� ������� �޿��� 3�ڸ��� �ĸ�(,)�� �����ؼ� ����ϴ� SQL�� �ۼ�?
select ename, sal, to_char(sal, '9,999') from emp; 
select ename, sal, to_char(sal, 'L9,999') from emp;


-- 2. to_date() : ���ڸ� ��¥������ ��ȯ�� �ִ� �Լ�
--    to_date( '����', 'format' )
--Q. 2021�� 1�� 1�� ���� ������� ����� �ϼ��� ���ϴ� SQL�� �ۼ�?
select sysdate - '2021/01/01' from dual;        -- �����߻�

select sysdate - to_date('2021/01/01','yyyy/mm/dd') from dual; 
select round(sysdate - to_date('2021/01/01','yyyy/mm/dd')) from dual;
select trunc(sysdate - to_date('2021/01/01','yyyy/mm/dd')) from dual;

--Q. 2021�� 12�� 25�� ũ������������ ���� �ϼ��� ���ϴ� SQL�� �ۼ�?
select '2021/12/25' - sysdate from dual;        -- ���� �߻�

select to_date('2021/12/25','yyyy/mm/dd') - sysdate from dual;
select round(to_date('2021/12/25','yyyy/mm/dd') - sysdate) from dual;
select trunc(to_date('2021/12/25','yyyy/mm/dd') - sysdate) from dual;

--3. to_number() : �������� ���������� ��ȯ���ִ� �Լ�
--   to_number( '���� ������', '���б�ȣ')
select  '20,000' - '10,000' from dual;      -- ���� �߻�
select to_number('20,000','99,999') - to_number('10,000','99,999') from dual;
--------------------------------------------------------------------------------

-- nvl() : null���� �ٸ������� ��ȯ���ִ� �Լ�
-- 1.null ���� �������� ���� ���� �ǹ�
-- 2.null ���� �������(+,-,*,/)�� ���� �ʴ´�.

--Q. ������̺� �ִ� �� ������� ������ ����ϴ� SQL�� �ۼ�?
--   ���� = �޿�(SAL) * 12 + COMM
--   NVL(COMM, 0) : COMM �� NULL���� �����͸� 0���� 

select sal*12 + nvl(comm, 0) as "����" from emp;

----------------------------------------------------------------------
-- decode() : switch ~ case ������ ����
-- decode( �÷���,  ��1, ���1,
--                 ��2, ���2,
--                 ��3, ���3, 
--                 ...........)

--Q. ������̺��� �μ���ȣ(deptno)�� �μ������� �ٲ㼭 ����ϴ� SQL�� �ۼ�?
select ename, deptno, decode( deptno, 10, 'ACCOUNTING',
                                      20, 'RESEARCH',
                                      30, 'SALES',
                                      40, 'OPERATION') as dname from emp;
------------------------------------------------------------------------------
-- case() : if ~ else if ���� ����
-- case when ����1 then ���1
--      when ����2 then ���2
--      else ���3
-- end
--Q. ������̺��� �μ���ȣ(deptno)�� �μ������� �ٲ㼭 ����ϴ� SQL�� �ۼ�?
select ename, deptno, case when deptno=10 then 'ACCOUNTING'
                           when deptno=20 then 'RESEARCH'
                           when deptno=30 then 'SALES'
                           else 'OPERATION' end from emp;
