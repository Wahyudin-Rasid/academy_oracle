--2021_07_21 (수)




---------------------------------------------------

-- ANSI OUTER JOIN
-- select * from table [ left | right | full ] outer join table2 using(공통컬럼);

--1. dept01 테이블 생성
create table dept01(deptno number(2), dname varchar2(14));
insert into dept01 values(10,'ACCOUNTING');
insert into dept01 values(20,'RESEARCH');
select * from dept01;
--2. dept02 테이블 생성
create table dept02(deptno number(2), dname varchar2(14));
insert into dept02 values(10,'ACCOUNTING');
insert into dept02 values(30,'SALES');
select * from dept02;

--3. left outer join : dept01 테이블 정보만 출력됨
select * from dept01 left outer join dept02 using(deptno);
--4. right outer join : dept02 테이블 정보만 출력됨
select * from dept01 right outer join dept02 using(deptno);

--5. full outer join : dept01, dept02 테이블 모든 정보가 출력됨
select * from dept01 full outer join dept02 using(deptno) order by deptno asc;

-------------------------------------------------------------------------------
-- 서브쿼리
--Q. SCOTT 사원이 소속된 부서명을 출력하는 SQL문 작성

--1) 사원 테이블에서 SCOTT사원의 부서번호를 구한다.
select deptno from emp where ename='SCOTT';
--2) 부서 테이블에서 20번 부서의 부서명을 구한다.
select dname from dept where deptno=20;

-- JOIN으로 구하기
select dname from dept, emp where dept.deptno=emp.deptno and ename = 'SCOTT';
select dname from dept inner join emp on dept.deptno=emp.deptno where ename = 'SCOTT';
select dname from dept inner join emp using(deptno) where ename='SCOTT';
select dname from dept natural join emp where ename='SCOTT';
-- 서브쿼리로 구하기
select dname from dept where deptno =                   -- 메인쿼리
    (select deptno from emp where ename = 'SCOTT');     -- 서브쿼리
    
--1.단일행 서브쿼리
-- 1) 서브쿼리의 검색 결과가 1개만 반환되는 쿼리
-- 2) 메인쿼리의 where 조건절에서 비교 연산자만 사용 가능(=,>,>=,<,<=,!=)

--Q. 사원 테이블에서 가장 최근에 입사한 사원명을 출력하는 SQL문 작성

select ename from emp where hiredate = (select max(hiredate) from emp);

--Q. 사원 테이블에서 최대 급여를 받는 사원명과 최대급여 금액을 출력하는 SQL문 작성
select ename, sal from emp where sal = (select max(sal) from emp);

--Q. 직속사관(MGR)이 KING인 사원의 사원명과 급여를 출력하는 SQL문 작성
select ename, sal from emp where mgr = 
    (select empno from emp where ename='KING');     -- 7839

--2. 다중행 서브쿼리
-- 1) 서브쿼리에서 반환되는 검색 결과가 2개 이상인 서브쿼리
-- 2) 메인 쿼리의 WHERE 조건절에서 다중행 연산자(in, all, any, ...)를 사용해야 된다

--<in 연산자>
-- : 서브쿼리의 검색 결과 중에서 하나라도 일치되면 참이된다
--Q. 급여를 3000이상 받는 사원이 소속된 부서와 동일한 부서에서 근무하는 사원들의
--   정보를 출력하는 SQL문 작성

-- 각 부서별 최대급여 금액 구하기
select deptno, max(sal) from emp group by deptno;
-- 10 5000, 20 3000, 30 2850
select * from emp where deptno in(
select deptno from emp where sal >= 3000);

--Q. in연산자를 이용하여 부서별로 가장 많은 급여를 받는
-- 사원의 정보(사원번호, 사원명, 급여, 부서번호)를 출력하는 SQL문 작성
select empno, ename, sal, deptno from emp where sal in 
(select max(sal) from emp group by deptno) order by sal desc;

--<all 연산자>
-- : 메인 쿼리의 비교 조건이 서브쿼리의 검색 결과와 모든 값이 일치하면 참이된다
--Q. 30번 부서에 소속된 사원 중에서 급여를 가장 많이 받는 사원보다 더 많은 급여를 
-- 받는 사원의 이름과 급여를 출력하는 SQL문 작성

--1) 단일행 서브쿼리로 구하기
select ename,sal from emp where sal > 
all(select max(sal) from emp where deptno = '30');
--2) 다중행 서브쿼리로 구하기
select ename, sal from emp where sal >
all(select sal from emp where deptno = '30');

--<any 연산자>
-- : 메인 쿼리의 비교조건이 서브 쿼리의 검색 결과와 하나 이상이 일치되면 참이됨
-- Q. 부서번호가 30번인 사원들의 급여중 가장 낮은 급여(950)보다 높은 급여를 받는
-- 사원명과 급여를 출력하는 SQL문 작성
select ename, sal from emp where sal > 
any(select sal from emp where deptno = 30);


