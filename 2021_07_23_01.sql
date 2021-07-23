-- 2021.07.23(금)

--* 오라클의 객체
-- 테이블, 뷰, 시퀀스, 인덱스, 동의어, 프로시져, 트리거

--* 데이터 딕셔너리와 데이터 딕셔너리 뷰
-- 데이터 딕셔너리를 통해서 접근 가능

-- 데이터 딕셔너리 뷰 ( 가상 테이블) : user_xxxx
--                                all_xxxx
-- dba(system) 계정만 사용가능       dba_xxxx 

-- 데이터 딕셔너리(시스템 테이블)

-- SCOTT 계정 소유의 테이블 객체에 대한 정보를 조회
select * from tab;  -- tab : 공개 동의어
select * from sys.tab;

select * from user_tables;

-- 자기 계정 소유 또는 권한을 부여 받은 객체 등에 관한 정보 조회
select * from all_tables;

-- DBA 계정만 사용 가능한 dba_xxx
select * from dba_tables;   -- 오류 발생(현재 SCOTT계정)

-- 오라클 시스템의 계정 정보 검색
select * from dba_users;    -- SCOTT이라 오류남

--1.insert
-- 형식 : insert into 테이블명(컬럼1, 컬럼2,...) values(데이터1, 데이터2,...);
--       insert into 테이블명 valeus(데이터1, 데이터2,...);

--[실습]
drop table dept01 purge;

-- 비어있는 dept01 복사본 테이블 생성
create table dept01 as select * from dept where 1=0;

select * from dept01;

insert into dept01(deptno, dname, loc) values(10,'ACCOUNTING','NEW YORK');
insert into dept01 values(20,'RESEARCH','DALLAS');
insert into dept01 values(30,'영업부','서울');

-- NULL 값 입력
insert into dept01(deptno, dname) values(40,'개발부');
insert into dept01 values(50,'기획부',null);

--2) 서브쿼리로 데이터 입력
drop table dept02 purge;
-- dept02 테이블 생성
create table dept02 as select * from dept where 1=0;    -- 테이블 구조만 복사
select * from dept02;

insert into dept02 select * from dept;
insert into dept02 select * from dept02;

-- 3) insert all 명령문으로 다중 테이블에 데이터 입력
-- 2개의 테이블 생성
create table emp_hir as select empno, ename, hiredate from emp where 1=0;
create table emp_mgr as select empno, ename, mgr from emp where 1=0;

-- insert all 명령문으로 다중 테이블에 데이터를 입력
insert all into emp_hir values(empno, ename, hiredate)
           into emp_mgr values(empno, ename, mgr)
           select empno, ename, hiredate, mgr from emp where deptno = 20;
           
select * from emp_hir;
select * from emp_mgr;

--2. update
-- 형식 : update 테이블명 set 컬럼1 = 수정할 값1, 컬럼2 = 수정할값, where 조건절;

-- [실습]
drop table emp01 purge;

create table emp01 as select * from emp;
select * from emp01;

--1) 모든 데이터 수정
--Q. 모든 사원들의 부서번호를 30번으로 수정
update emp01 set deptno = 30;

--Q. 모든 사원들의 급여를 10%인상
update emp01 set sal = sal*1.1;

--Q. 모든 사원들의 입사일을 오늘 날짜로 수정
update emp01 set hiredate = sysdate;

--2) 특정 데이터만 수정 : where 조건절 사용
drop table emp02 purge;
create table emp02 as select * from emp;    -- 복사본 테이블 생성
select * from emp02;
select * from emp;
--Q. 급여가 3000 이상인 사원만 급여를 10% 인상
update emp02 set sal=sal*1.1 where sal >= 3000;

--Q. 입사일이 1987년인 사원의 입사일을 오늘 날짜로 수정
update emp02 set hiredate = sysdate where substr(hiredate,1,2) = 87;

--Q. SCOTT 사원의 입사일을 오늘 날짜로 수정하고, 급여를 50으로, 커미션을 4000으로 수정
update emp02 set hiredate = sysdate, sal = 50, comm = 4000 where ename = 'SCOTT';

--3) 서브 쿼리를 이용한 데이터 수정
--Q. 20번 부서의 지역명(DALLAS)를 40번 부서의 지역명(BOSTON)으로 수정
select * from dept;
update dept set loc = (select loc from dept where deptno = '40') where deptno = 20;

--3. delete : 데이터 삭제
-- 형식 : delete from 테이블명 where 조건식;
--1) 모든 데이터 삭제
select * from dept01;
delete from dept01;
rollback;   --트랜잭션을 취소

--2) 조건을 만족하는 데이터 삭제
delete from dept01 where deptno=30;

--3) 서브쿼리를 이용한 삭제
--Q. 사원테이블(EMP02)에서 부서명이 SALES 부서인 사원을 삭제
delete from emp02 where deptno = (select deptno from dept where dname='SALES');
select * from emp02;

-- MERGE (테이블 합병)
-- : 테이블 구조가 같은 2개의 테이블을 하나의 테이블로 합치는 기능
--   MERGE 명령을 수행할 때 기존에 존재하는 행이 있으면 새로운 값으로
--   UPDATE되고, 존재하지 않으면 새로운 행으로 추가된다
drop table emp01 purge;
drop table emp02 purge;
create table emp01 as select * from emp;
create table emp02 as select * from emp where job = 'MANAGER';
update emp02 set job = 'TEST';
insert into emp02 values(8000,'ahn','top',7566,'2018/02/22',1200,10,20);

merge into emp01
	using emp02
	on(emp01.empno = emp02.empno)
	when matched then
	     update set emp01.ename = emp02.ename,
			emp01.job = emp02.job,
			emp01.mgr = emp02.mgr,
			emp01.hiredate = emp02.hiredate,
			emp01.sal = emp02.sal,
			emp01.comm = emp02.comm,
			emp01.deptno = emp02.deptno
	when not matched then
	     insert values(emp02.empno, emp02.ename, emp02.job, 		         	         
                       emp02.mgr,emp02.hiredate, 
                       emp02.sal, emp02.comm,emp02.deptno);
select * from emp01;    