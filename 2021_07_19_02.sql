-- 2021.07.19(월)

-- SQL함수

select 10+20 from dept;     -- 4개 출력
select 10+20 from emp;      -- 14개 출력

select 10+20 from dual;     -- 1개 출력

-- dual 테이블
--1. sys 계정 소유의 테이블로 공개 동의어로 설정 되어 있음.
--2. dual 테이블은 공개가 되어 있기 때문에 누구나 사용 가능하다.
--3. dual 테이블은 데이터가 1개 밖에 없기 때문에, 연산 결과를 1번만 출력한다.

desc dual;                  --  dummy 컬럼 1개 있음
select * from dual;         -- X  데이터 1개 있음
select 10+20 from sys.dual;
select 10+20 from dual;

select * from sys.tab;
select * from tab;

--1. 숫자 함수
-- abs() : 절대값을 구해주는 함수
select -10, abs(-10), ABS(-20) from dual;
--  함수명을 대.소문자를 구분하지 않는다.

-- floor() : 소숫점 이하를 버리는 역할
select 34.5678, floor(34.5678) from dual;

-- round() : 특정 자리에서 반올림을 하는 역할
-- round( 대상값, 자리수 )
select 34.5678, round(34.5678) from dual;    -- 35출력 : 소수 첫번째 자리에서 반올림
select 34.5678, round(34.5678, 2) from dual; -- 34.57출력 : 3자리에서 반올림
select 34.5678, round(34.5678, -1) from dual;-- 30출력
select 34.5678, round(35.5678, -1) from dual;-- 40출력

-- trunc() : 특정 자리에서 잘라내는 역할
select trunc(34.5678, 2), trunc(34.5678, -1), trunc(34.5678) from dual;
--         34.56                 30                  34   

-- mod() : 나머지를 구해주는 함수
select mod(27, 2), mod(27, 5), mod(27, 7) from dual;
--          1            2           6

--Q. 사원테이블에서 사원번호가 홀수인 사원들을 검색하는 SQL문 작성?
select * from emp where mod(empno, 2) = 1;

---------------------------------------------------------------------
--2. 문자 처리 함수

-- upper() : 대문자로 변환해주는 함수
select 'Wecome to Oracle', upper('Welcome to Oracle') from dual;

-- lower() : 소문자로 변환해주는 함수
select 'Wecome to Oracle', lower('Welcome to Oracle') from dual;

-- initcap() : 이니셜을 대문자로 변환해주는 함수
select 'Wecome to Oracle', initcap('welcome to oracle') from dual;

--Q. 사원 테이블에서 job이 manager인 사원을 검색하는 SQL문 작성?
select empno, ename, job from emp where job='manager';      -- 검색안됨
select empno, ename, job from emp where lower(job)='manager';
select empno, ename, job from emp where job=upper('manager');

-- length() : 문자의 길이를 구해주는 함수(글자수)
select length('oracle'), length('오라클') from dual;
--            6                3 

-- lengthb() : 문자열의 길이를 바이트로 구해주는 함수
-- 영문 1글자 : 1Byte,  한글 1글자 : 3Byte
select lengthb('oracle'), lengthb('오라클') from dual;
--             6