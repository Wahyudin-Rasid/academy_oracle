--2021_07_21 과제
select * from emp;
select * from dept;
--과제.
--       Q1. 직급이 MANAGER인 사원의 이름, 부서명을 출력하는 SQL문을
--             작성 하세요? (JOIN을 사용하여 처리)
select e.ename, d.dname from emp e, dept d where e.job='MANAGER' and e.deptno = d.deptno;
--   
--       Q2. 매니저가 KING 인 사원들의 이름과 직급을 출력하는 SQL문 작성?
select employee.ename, employee.job from emp employee, emp manager where employee.mgr = manager.empno and manager.empname = 'KING';
--
--       Q3. SCOTT과 동일한 근무지에서 근무하는 사원의 이름을 출력하는 SQL문 작성?
select ename from emp where deptno = (select deptno from emp where ename = 'SCOTT');

