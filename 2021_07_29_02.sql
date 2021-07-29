-- 2021.07.29(목)

-- 저장 프로시저

--[실습]
drop table emp01 purge;
create table emp01 as select * from emp;
select * from emp01;

--1. 저장 프로시저 생성
create or replace procedure del_all
is
begin
    delete from emp01;
end;

--2. 프로시저 목록 확인
select * from user_source;

--3. 프로시저 실행
execute del_all;

--4. 프로시저 실행 확인
select * from emp01;        -- 프로시저에 의해서 데이터가 모두 삭제됨

rollback;
insert into emp01 select * from emp;
----------------------------------------------------------------------
-- 매개변수가 있는 프로시저
--1. 매개변수가 있는 프로시저 생성
create or replace procedure del_ename(vename in emp01.ename%type)
is
begin
    delete from emp01 where ename = vename;
end;

--2. 프로시저 목록 확인
select * from user_source;

--3. 프로시저 실행
select * from emp01;
execute del_ename('SCOTT');
execute del_ename('KING');
execute del_ename('SMITH');
---------------------------------------------------------------------
-- 매개변수의 MODE가 in, out으로 되어있는 프로시저
-- in : 매개변수로 값을 받는 역할
-- out : 매개변수로 값을 돌려주는 역할

--1. 프로시저 생성
--   사원번호를 프로시저의 매개변수로 전달 받아서 그 사원의 사워명, 급여, 직책을
--   구하는 프로시저 생성
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
insert into customer values('송윤호','holioud@naver.com','010','1');
    
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

-- 저장 함수
-- 1. 저장 프로시저와 유사한 기능을 수행하지만, 실행결과를 돌려주는 차이가 있음

--Q1. 사원 테이블에서 특정 사원의 급여를 200% 인상하는 결과를 돌려주는 저장함수
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

-- 저장 함수를 SQL문에 포함해서 실행
select sal,cal_bonus(7788) from emp where empno = 7788;