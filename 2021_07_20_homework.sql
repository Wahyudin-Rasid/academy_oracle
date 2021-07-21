--과제
select * from emp;
--Q1. 사원테이블(EMP)에서 입사일(HIREDATE)을 4자리 연도로 출력 되도록 SQL문을 작성하세요? (ex. 1980/01/01)
select hiredate, to_char(hiredate,'yyyy-mm-dd') from emp;
--Q2. 사원테이블(EMP)에서 MGR컬럼의 값이 null인 데이터의 MGR의 값을  CEO 로  출력하는 SQL문을 작성 하세요?
select nvl(to_char(mgr),'CEO') from emp;
--Q3. 사원 테이블(EMP)에서 가장 최근에 입사한 사원명을 출력하는 SQL문을 작성 하세요?
select ename from emp where hiredate = (select max(hiredate) from emp);
--Q4. 사원 테이블(EMP)에서 최대 급여를 받는 사원명과 최대급여 금액을 출력하는 SQL문을 작성 하세요?
select ename, sal from emp where sal = (select max(sal) from emp);