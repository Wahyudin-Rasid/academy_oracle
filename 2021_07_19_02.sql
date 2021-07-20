-- 2021.07.19(��)

-- SQL�Լ�

select 10+20 from dept;     -- 4�� ���
select 10+20 from emp;      -- 14�� ���

select 10+20 from dual;     -- 1�� ���

-- dual ���̺�
--1. sys ���� ������ ���̺�� ���� ���Ǿ�� ���� �Ǿ� ����.
--2. dual ���̺��� ������ �Ǿ� �ֱ� ������ ������ ��� �����ϴ�.
--3. dual ���̺��� �����Ͱ� 1�� �ۿ� ���� ������, ���� ����� 1���� ����Ѵ�.

desc dual;                  --  dummy �÷� 1�� ����
select * from dual;         -- X  ������ 1�� ����
select 10+20 from sys.dual;
select 10+20 from dual;

select * from sys.tab;
select * from tab;

--1. ���� �Լ�
-- abs() : ���밪�� �����ִ� �Լ�
select -10, abs(-10), ABS(-20) from dual;
--  �Լ����� ��.�ҹ��ڸ� �������� �ʴ´�.

-- floor() : �Ҽ��� ���ϸ� ������ ����
select 34.5678, floor(34.5678) from dual;

-- round() : Ư�� �ڸ����� �ݿø��� �ϴ� ����
-- round( ���, �ڸ��� )
select 34.5678, round(34.5678) from dual;    -- 35��� : �Ҽ� ù��° �ڸ����� �ݿø�
select 34.5678, round(34.5678, 2) from dual; -- 34.57��� : 3�ڸ����� �ݿø�
select 34.5678, round(34.5678, -1) from dual;-- 30���
select 34.5678, round(35.5678, -1) from dual;-- 40���

-- trunc() : Ư�� �ڸ����� �߶󳻴� ����
select trunc(34.5678, 2), trunc(34.5678, -1), trunc(34.5678) from dual;
--         34.56                 30                  34   

-- mod() : �������� �����ִ� �Լ�
select mod(27, 2), mod(27, 5), mod(27, 7) from dual;
--          1            2           6

--Q. ������̺��� �����ȣ�� Ȧ���� ������� �˻��ϴ� SQL�� �ۼ�?
select * from emp where mod(empno, 2) = 1;

---------------------------------------------------------------------
--2. ���� ó�� �Լ�

-- upper() : �빮�ڷ� ��ȯ���ִ� �Լ�
select 'Wecome to Oracle', upper('Welcome to Oracle') from dual;

-- lower() : �ҹ��ڷ� ��ȯ���ִ� �Լ�
select 'Wecome to Oracle', lower('Welcome to Oracle') from dual;

-- initcap() : �̴ϼ��� �빮�ڷ� ��ȯ���ִ� �Լ�
select 'Wecome to Oracle', initcap('welcome to oracle') from dual;

--Q. ��� ���̺��� job�� manager�� ����� �˻��ϴ� SQL�� �ۼ�?
select empno, ename, job from emp where job='manager';      -- �˻��ȵ�
select empno, ename, job from emp where lower(job)='manager';
select empno, ename, job from emp where job=upper('manager');

-- length() : ������ ���̸� �����ִ� �Լ�(���ڼ�)
select length('oracle'), length('����Ŭ') from dual;
--            6                3 

-- lengthb() : ���ڿ��� ���̸� ����Ʈ�� �����ִ� �Լ�
-- ���� 1���� : 1Byte,  �ѱ� 1���� : 3Byte
select lengthb('oracle'), lengthb('����Ŭ') from dual;
--             6