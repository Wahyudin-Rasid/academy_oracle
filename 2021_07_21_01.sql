--2021.07.21(수)
select * from emp;
-- 그룹함수
-- count() : 총 데이터 갯수를 구해주는 함수
select count(sal) from emp;     -- 14
select count(mgr) from emp;     -- 13 : null값은 counting을 하지 않는다.
select count(comm) from emp;    -- 4 : null값은 counting을 하지 않는다.
select count(empno) from emp;   -- 14 : ename컬럼은 기본키로 설정되어 있다.
select count(*) from emp;       -- 14

--Q. 사원 테이블에서 JOB의 갯수
select count(job) from emp;     -- 14 : 중복 데이터도 counting 한다.
select job from emp;
select distinct job from emp;   -- 중복행을 제거한 JOB 출력

-- 중복행을 제거한 JOB의 갯수 구하기?
select count(distinct job) from emp;  -- 5

--Q. 가장 최근 입사한 사원의 입사일과 가장 먼저 입사한 사원의 입사일을 구하는 SQL문 작성?
select max(hiredate) 최근입사, min(hiredate) 먼저입사 from emp;

--Q. 30번 부서 소속 사원 중에서 커미션을 받는 사원수를 구하는 SQL문 작성?
select count(comm) from emp where deptno=30;


-- group by 절
-- : 특정 컬럼을 기준으로 테이블에 존재하는 데이터를 그룹으로 구분하여 처리해주는 
--   역할을 한다.

--Q. 각 부서(10,20,30)의 급여의 합, 평균급여, 최대급여, 최소급여를 구하는 SQL문 작성?
select sum(sal), avg(sal), max(sal), min(sal) from emp where deptno=10;
select sum(sal), avg(sal), max(sal), min(sal) from emp where deptno=20;
select sum(sal), avg(sal), max(sal), min(sal) from emp where deptno=30;

-- 그룹함수와 일반 컬럼은 같이 사용할 수 없다.
select ename, max(sal) from emp;    -- 오류 발생

-- 그룹함수와 일반컬럼은 같이 사용할 수 없지만, 예외적으로 group by절에 사용되는 컬럼은
-- 그룹함수와 같이 사용할 수 있다.
select deptno, sum(sal), avg(sal), max(sal), min(sal) from emp
    group by deptno order by deptno asc;
--Q. JOB컬럼을 기준으로 급여의 합, 평균, 최대, 최소급여를 구하는 SQL문 작성
select job, sum(sal), avg(sal), max(sal), min(sal) from emp group by job;
--Q. 각 부서(10,20,30)별 사원수와 커미션을 받는 사원의 수를 구하는 SQL문 작성
select deptno, count(deptno) 사원수 , count(comm) "커미션 받는 사원 수" from emp group by deptno order by deptno asc;

-- having 조건절
-- : group by절이 사용되는 경우에 데이터 제한을 가하기 위해서는 where 조건절 대신
--   having 조건절을 사용해야 한다

--Q. 각 부서별 평균급여 금액이 2000 이상인 부서만 출력하는 SQL문
select deptno,avg(sal) from emp group by deptno having avg(sal) >= 2000;
--Q. 각 부서별 최대급여 금액이 2900 이상인 부서만 출력하는 SQL문 작성
select deptno, max(sal) from emp group by deptno having max(sal) >= 2900;
-------------------------------------------------------------------------
-- 조인(join)
-- : 2개 이상의 테이블을 결합해서 정보를 구해오는 것

--Q. SCOTT 사원이 소속된 부서명을 출력하는 SQL문 작성
--1. 사원테이블(EMP)에서 SCOTT사원의 부서번호를 구한다.
select deptno from emp where ename = 'SCOTT';   -- 20
--2. 부서테이블(DEPT)에서 20번 부서의 부서명을 구한다.
select dname from dept where deptno = 20;   -- RESEARCH

-- CROSS JOIN
select * from dept, emp;        -- 4 * 14 = 56개 데이터 검색
select * from emp, dept;        -- 14 * 4 = 56개 데이터 검색

-- CROSS JOIN 종류
-- 1.등가 조인 (Equi Join)
-- 2.비등가 조인 (Non-Equi Join)
-- 3.자체조인 (Self Join)
-- 4.외부조인 (Outer Join)

--1.등가 조인(Equi Join)
--  : 두 테이블에 동일한 컬럼을 기준으로 조인
select * from dept, emp where dept.deptno = emp.deptno;  -- 14개의 데이터 검색

--Q. SCOTT 사원이 소속된 부서명을 출력하는 SQL문 작성? (조인 이용)
select ename, dname from dept, emp 
    where dept.deptno=emp.deptno and ename='SCOTT';
 
-- 공통컬럼(deptno)은 테이블.공통컬럼명 형식으로 출력해야 한다.
-- 공통컬럼이 아닌 컬럼들은 앞에 테이블명을 생략할 수 있다.
select deptno, ename, dname from dept, emp 
    where dept.deptno=emp.deptno and ename='SCOTT';   -- 오류 발생 

select dept.deptno, emp.ename, dept.dname from dept, emp    -- dept.deptno
    where dept.deptno=emp.deptno and emp.ename='SCOTT'; 
    
select emp.deptno, emp.ename, dept.dname from dept, emp    -- emp.deptno
    where dept.deptno=emp.deptno and emp.ename='SCOTT';  
    
-- 테이블에 별칭 부여하기
--1.테이블에 대한 별칭이 부여된 다음 부터는 테이블명은 사용할 수 없고, 
--  별칭명만 사용해야 된다.
--2. 별칭명은 대.소문자를 구분하지 않는다.
--3. 공통 컬럼(deptno)은 별칭명.공통컬럼명 형식으로 사용해야 된다. ex) D.deptno
--4. 공통 컬럼이 아닌 컬럼들은 앞에 별칭명을 생략 할 수 있다.
select D.deptno, E.ename, D.dname from dept D, emp E
    where D.deptno=E.deptno and E.ename='SCOTT';
 
select DEPT.deptno, E.ename, D.dname from dept D, emp E
    where D.deptno=E.deptno and E.ename='SCOTT';   -- 오류발생 : 테이블명은 사용할 수 없다. 
    
select d.deptno, E.ename, D.dname from dept D, emp E
    where D.deptno=E.deptno and E.ename='SCOTT';  -- 별칭명은 대.소문자를 구분하지 않는다 
    
-- 2. 비등가 조인
-- : 동일한 컬럼없이 다른 조건을 사용하여 조인
--Q. 사원테이블에 있는 각 사원들의 급여가 몇 등급인지를 출력하는 SQL문 작성
--  EMP(SAL) - SALGRADE(GRADE)
select ename, sal, grade from emp, salgrade
    where sal between losal and hisal;

select e.ename, e.sal, s.grade from emp e, salgrade s 
    where e.sal between s.losal and s.hisal;
    
--3. 자체조인(Self Join)
-- : 한 개의 테이블 내에서 컬럼과 컬럼 사이의 관계를 이용해서 조인
--Q. 자체조인을 이용해 사원 테이블의 각 사원들의 사원명과 매니저를 출력하는 SQL문 작성
-- EMP(EMPNO)-EMP(MGR)

select employee.ename || '의 매니저는 ' || manager.ename
    from emp employee, emp manager
    where employee.mgr = manager.empno;
    
-- 13개의 검색 결과가 출력된다.
-- KING 사원은 직속상관이 없기 때문에 출력되지 않는다.   

--4.외부조인(Outer Join)
-- : 조인 조건을 만족하지 않는 데이터를 출력해주는 조인
-- 1) 테이블을 조인할 때 어느 한쪽의 테이블에는 데이터가 존재하지만, 다른 테이블에는
--    데이터가 존재하지 않는 경우에, 그 데이터가 출력되지 않는 문제를 해결하기 위해서
--    사용되는 조인방법
-- 2) 정보가 부족한 곳에 (+)를 추가한다.

--Q1. 위의 자체조인(Self Join)의 결과,KING사원은 직속상관이 없기 때문에 출력되지 
-- 않았는데, King 사원도 외부조인을 이용해서 출력하세요
select employee.ename || '의 매니저는' || manager.ename 
from emp employee, emp manager
where employee.mgr = manager.empno(+);

--Q2. 부서테이블(DEPT)의 40번 부서는 조인할 사원테이블(EMP)의 부서번호에는 나타나지
-- 않지만, 40번 부서의 부서명을 출력하는 SQL문 작성
-- 1) DEPT - EMP 등가 조인 : 40번 부서가 출력안됨
select ename, d.deptno, dname from dept d, emp e
where d.deptno = e.deptno;

-- 2) 외부조인 : 출력되지 않는 40번 부서를 출력해주는 조인
select ename, d.deptno, dname from dept d, emp e
where d.deptno = e.deptno(+);

-------------------------------------------------------------------
-- ANSI JOIN
-- : ANSI(미국 표준 협회) 표준안에 따라서 만들어진 JOIN 방법
select * from dept cross join emp;
select * from emp cross join dept;

-- ANSI INNER JOIN
--Q. SCOTT사원이 소속된 부서명을 출력 SQL문 작성
select ename, dname from dept inner join emp
    on dept.deptno = emp.deptno where ename='SCOTT';

-- using을 이용해서 조인
select ename, dname from dept inner join emp
    using(deptno) where ename='SCOTT';
    
-- ANSI NATURAL JOIN
-- : DEPT와 EMP 테이블 사이의 공통컬럼이 같다는 의미를 가지고 있음.
select ename, dname from dept natural join emp where ename='SCOTT';