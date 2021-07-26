-- 2021_07_26_02(월)

-- 뷰(view) : 기본 테이블을 이용해서 만들어진 가상 테이블

-- 실습을 위한 기본 테이블 생성 : dept_copy, emp_copy

-- 2개의 기본 테이블 생성
create table dept_copy as select * from dept;
create table emp_copy as select * from emp;
select * from dept_copy;
select * from emp_copy;

-- 뷰 생성
create view emp_view30
as
select empno, ename, deptno from emp_copy where deptno=30;
-- 오류 발생. SCOTT계정은 테이블은 생성할 수 있지만 뷰는 생성할 권한이 없음

-- 뷰 확인
select * from user_views;

desc emp_view30;
select * from emp_view30;

--Q. 뷰(EMP_COPY30)에 insert로 데이터를 입력 했을 경우에, 기본 테이블
--   (EMP_COPY)에 데이터가 입력 될까요
insert into emp_view30 values(1111,'송윤호',30);   -- 

select * from emp_view30;   -- 일단 여기는 입력됨
select * from emp_copy; -- 이게 되네

-- 뷰의 종류
-- 단순뷰 : 하나의 기본 테이블로 생성된 뷰
-- 복합뷰 : 여러개의 기본 테이블로 생성한 뷰

-- 단순뷰
--Q. 기본 테이블인 emp_copy를 이용해서 20번 부서에 소속된 사원들의
--   사번과 이름, 부서번호, 직속상관의 사번을 출력하기 위한 뷰(EMP_VIEW20) 생성
create view emp_view20 as select empno,ename,deptno,mgr
from emp_copy where deptno = 20;
-- 뷰 확인
select * from user_views;

-- 복합뷰
--Q. 각 부서별(부서명) 최대급여와 최소급여를 출력하는 뷰(sal_view)를 생성
create view sal_view as select dname, max(sal) MAX, min(sal) MIN
from dept, emp where dept.deptno = emp.deptno group by dname;
-- 뷰 데이터 확인
select * from sal_view;
