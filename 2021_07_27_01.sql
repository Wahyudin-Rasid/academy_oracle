-- 2021_07_27_01(화)

-- 뷰를 생성할 때 사용되는 옵션들
--1. or replace 옵션
--   기존에 뷰가 존재하지 않으면 뷰를 생성하고, 동일한 이름을 가진 뷰가 
--   있으면 내용을 수정함

select * from user_views;

-- 위에서 emp_view30이라는 뷰를 생성했는데, 
-- or replace 옵션을 붙여서 emp_view30 뷰를 생성해보기
--1) or replace 옵션없이 동일한 뷰(emp_view30)을 생성하면 오류발생
create  view emp_view30
as
select empno, ename, deptno, sal, comm from emp_copy where deptno=30;

--2) or replace 옵션을 붙여서 동일한 뷰(emp_view30)생성 : 뷰의 내용이 수정됨
create or replace view emp_view30
as 
select empno, ename, deptno, sal, comm from emp_copy where deptno=30;

select * from emp_view30;

--2. with check option
--   : where 조건절에 사용된 값을 수정하지 못하도록 만들어 주는 옵션
--1) with check option 사용하지 않은 경우
create or replace view emp_view30
as
select empno,ename,sal,comm,deptno from emp_copy where deptno=30;

-- emp_view30 뷰에서 급여가 1200 이상인 사원의 부서번호를 30 -> 20으로 수정
update emp_view30 set deptno=20 where sal>=1200;

--2) with check option 사용
create or replace view emp_view_chk30
as
select empno,ename,sal,comm,deptno from emp_copy
where deptno=30 with check option;

select * from emp_view_chk30;
-- emp_view30 뷰에서 급여가 1200 이상인 사원의 부서번호를 30 -> 20으로 수정
update emp_view_chk30 set deptno=20 where sal>=1200;

--3. with read only 옵션
--   : 뷰를 통해서 기본 테이블의 어떤 컬럼의 내용을 수정하지 못하도록 하는 옵션
create or replace view view_read30
as
select empno, ename, sal, comm, deptno from emp_copy
where deptno=30 with read only;

select * from view_read30;
select * from user views;

--Q. 생성된 뷰 view_read30을 수정해보기
update view_read30 set sal=3000;    -- with read only 옵션땜에 수정안됨

select rownum, deptno, dname, loc from dept;

select rownum, ename, sal from emp order by sal desc;

--Q1. 사원테이블에서 입사일이 빠른 사원 5명을 구해보자
--1) 입사일이 빠른 사원순으로 정렬 ( 입사일을 기준으로 오름차순 정렬 )
select empno, ename, hiredate from emp order by hiredate asc;

--2) 뷰 생성
create or replace view hire_view
as select empno, ename, hiredate from emp order by hiredate asc;

--3) 입사일이 빠른 사원 5명 출력
select rownum, empno, ename, hiredate from hire_view;

select rownum, empno, ename, hiredate from hire_view where rownum <=5;

--4) 인라인뷰( 서브쿼리로 만들어진 뷰)
-- 입상일이 빠른 사원 5명 검색
select rownum, ename, hiredate from
(select empno, ename, hiredate from emp order by hiredate asc)
where rownum <= 5;

-- 입사일이 3 ~ 5번째로 빠른 사원을 검색
select rownum, ename, hiredate from(
    select ename, hiredate from emp order by hiredate asc)
where rownum <= 5 and rownum >= 3;  -- 이런식으로는 안됨

select ename, hiredate from(
    select rownum rnum, ename, hiredate from( -- rownum 컬럼 별칭 부여
    select * from emp order by hiredate asc) )
where rnum >= 3 and rnum <= 5;

--Q2. 사원 테이블에서 사원번호(empno)가 빠른 사원 5명을 구해보기

-- 인라인 뷰로 해결
select empno, ename from (
    select rownum rnum, empno, ename from( 
    select * from emp order by empno asc) )
where rnum <= 5;

--Q3. 사원 테이블에서 급여가 3~5번째로 많이 받는 사람 구해보기
select empno, ename, sal from(
    select rownum rnum, empno, ename, sal from(
    select * from emp order by sal desc) )
where rnum <= 5 and rnum >= 3;

-- 컬럼명을 간결하게 처리
select rnum, ename, sal from(
    select rownum rnum, ename, sal from(
    select * from emp order by sal desc) board) -- 서브쿼리에 별칭부여
where rnum >= 3 and rnum <= 5;

    

