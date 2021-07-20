-- 2021.07.20(화)

-- 2. 문자 처리 함수

-- substr() : 문자열의 일부를 추출하는 함수
-- 형식 : substr( 대상 문자열, 시작위치, 추출할 문자갯수 )
-- 시작 위치 번호는 왼쪽부터 1번부터 시작한다.

select substr('Welcome to Oracle', 4, 3) from dual;     -- com 출력
select substr('Welcome to Oracle', -4, 3) from dual;    -- acl 출력    

--Q. 사원 테이블에서 입사일(hiredate)을 년, 월, 일을 추출해서 출력하는 SQL문 작성?
select substr(hiredate,1,2) as "년", 
       substr(hiredate,4,2) as "월",
       substr(hiredate,7,2) as "일"  from emp;
       
--Q. 사원테이블에서 87년도에 입사한 사원을 검색하는 SQL문 작성?
select * from emp where substr(hiredate, 1, 2) = '87';

--Q. 사원테이블에서 사원명이 E로 끝나는 사원을 검색하는 SQL문 작성? (2가지 방법)
select * from emp where substr(ename, -1, 1) = 'E';
select * from emp where ename like '%E';

-- instr() : 특정 문자의 위치를 구해주는 함수
-- instr(대상, 찾을 문자) : 가장 먼저 나오는 문자의 위치를 찾아준다.
-- instr(대상, 찾을 문자, 시작 위치, 몇번째 발견)

--Q. 가장 먼저 나오는 'o' 의 위치를 찾아준다.
select instr('Welcome to oracle', 'o') from dual;

--Q. 6번 이후에 2번째로 발견된 'o' 의 위치를 찾아준다.
select instr('Welcome to oracle', 'o', 6, 2) from dual;

--Q. 사원테이블에서 사원명의 3번째 자리가 R로 되어있는 사원을 검색하는 SQL문 작성?
--   3가지 방법 : like 연산자, substr(), instr()
select * from emp where ename like '__R%';
select * from emp where substr(ename, 3, 1) = 'R';
select * from emp where instr(ename, 'R') = 3;
select * from emp where instr(ename, 'R', 3, 1) = 3;

-- lpad() / rpad() : 특정 기호로 채워주는 함수
select lpad('Oracle', 20, '#') from dual;   -- ##############Oracle
select rpad('Oracle', 20, '#') from dual;   -- Oracle##############

-- ltrim() : 왼쪽 공백을 삭제하는 함수
-- rtrim() : 오른쪽 공백을 삭제하는 함수
select  '  Oracle  ',  ltrim('  Oracle ') from dual;
select rtrim(' Oracle ') from dual;

-- trim() : 문자열 좌.우의 공백을 삭제하는 함수
--          특정 문자를 잘라내는 함수
select trim('  Oracle  ') from dual;
select trim('a' from 'aaaaaOracleaaaa') from dual;
---------------------------------------------------------------------

-- 3. 날짜 함수
-- sysdate : 시스템의 날짜를 구해주는 함수
select sysdate from dual;       -- 21/07/20

select sysdate-1 어제, sysdate 오늘, sysdate+1 내일 from dual;

--Q. 사원테이블에서 각 사원들의 현재까지 근무일수를 구하는 SQL문 작성?
select sysdate - hiredate from emp;
select round(sysdate - hiredate) from emp;      -- 소수 1째자리에서 반올림
select trunc(sysdate - hiredate) from emp;      -- 소숫점 자리를 버림

-- round() : 특정 기준으로 반올림 하는 함수
-- round( date, format )
-- 입사일을 기준으로 반올림
select hiredate, round(hiredate, 'month') from emp;

-- trunc() : 특정 기준으로 버리는 함수
-- trunc( date, format )
select hiredate, trunc(hiredate, 'month') from emp;

-- months_between() : 두 날짜 사이의 경과된 개월 수를 구해주는 함수
-- months_between( date1, date2 )
--Q. 사원테이블에서 각 사원들의 근무한 개월 수를 구하는 SQL문 작성?
select ename, sysdate, hiredate, months_between(sysdate, hiredate) from emp;

select  months_between(sysdate, hiredate) from emp;
select  round(months_between(sysdate, hiredate)) from emp;
select  trunc(months_between(sysdate, hiredate)) from emp;

-- add_months() : 특정 날짜에 경과된 개월의 날짜를 구해주는 함수
-- add_months( date, 개월수 )
--Q. 사원 테이블에서 각 사원들의 입사한 날짜에 6개월이 경과된 일자를 구하는 SQL문 작성?
select ename, hiredate, add_months(hiredate, 6) from emp;

--Q. 오늘 날짜에 6개월 경과된 일자를 구하는 SQL문 작성?
select sysdate, add_months(sysdate, 6) from dual;
select sysdate, add_months('21/06/15', 6) from dual;

-- next_day() : 해당 요일의 가장 가까운 날짜를 구해주는 함수
-- next_day( date, 요일 )
--Q.오늘을 기준으로 가까운 토요일이 언제인지 구하는 SQL문 작성?
select sysdate, next_day(sysdate, '토요일') from dual;
--select sysdate, next_day(sysdate, 'MONDAY') from dual;   -- 영문 OS

-- last_day() : 해당 달의 마지막 날짜를 구해주는 함수
--Q. 각 사원들이 입사한 달의 마지막 날짜를 구하는 SQL문 작성?
select hiredate, last_day(hiredate) from  emp;

--Q.이번달의 가장 마지막 날짜를 구하는 SQL문 작성?
select sysdate, last_day(sysdate) from dual;    -- 21/07/20	 21/07/31
select last_day('21/02/01') from dual;          -- 21/02/28
---------------------------------------------------------------------------

-- 형변환 함수 : to_char(), to_date(), to_number()

--1. to_char() : 날짜형, 숫자형 데이터를 문자형으로 변환시켜주는 함수
--   to_char( 날짜 데이터, '출력형식' )

--  1) 날짜형 데이터를 문자형으로 변환
-- Q. 현재 시스템의 날짜를 년, 월, 일, 시, 분, 초, 요일을 출력
      select sysdate from dual;        -- 21/07/20

select sysdate, to_char(sysdate,'yyyy-mm-dd am hh:mi:ss dy') from  dual;
select sysdate, to_char(sysdate,'yyyy-mm-dd hh24:mi:ss day') from  dual;

--Q. 사원테이블에서 각 사원들의 입사일을 년,월,일,시,분,초,요일을 출력하는 SQL문 작성?
select hiredate, to_char(hiredate,'yyyy-mm-dd hh24:mi:ss day') from emp;

--  2) 숫자형 데이터를 문자형으로 변환
--     to_char( 숫자 데이터, '구분기호' )

--Q. 숫자 1230000 을 3자리씩 컴마로 구분해서 출력
select 1230000 from dual;

-- 0으로 자리수를 지정하면,데이터 길이가 9자리가 되지 않으면 0으로 채운다.
select 1230000, to_char(1230000, '000,000,000') from dual; --  001,230,000

-- 9으로 자리수를 지정하면,데이터 길이가 9자리가 되지 않아도 채우지 않는다.
select 1230000, to_char(1230000, '999,999,999') from dual; -- 1,230,000

--Q. 사원테이블의 각 사원들의 급여를 3자리씩 컴마(,)로 구분해서 출력하는 SQL문 작성?
select ename, sal, to_char(sal, '9,999') from emp; 
select ename, sal, to_char(sal, 'L9,999') from emp;


-- 2. to_date() : 문자를 날짜형으로 변환해 주는 함수
--    to_date( '문자', 'format' )
--Q. 2021년 1월 1일 부터 현재까지 경과된 일수를 구하는 SQL문 작성?
select sysdate - '2021/01/01' from dual;        -- 오류발생

select sysdate - to_date('2021/01/01','yyyy/mm/dd') from dual; 
select round(sysdate - to_date('2021/01/01','yyyy/mm/dd')) from dual;
select trunc(sysdate - to_date('2021/01/01','yyyy/mm/dd')) from dual;

--Q. 2021년 12월 25일 크리스마스까지 남은 일수를 구하는 SQL문 작성?
select '2021/12/25' - sysdate from dual;        -- 오류 발생

select to_date('2021/12/25','yyyy/mm/dd') - sysdate from dual;
select round(to_date('2021/12/25','yyyy/mm/dd') - sysdate) from dual;
select trunc(to_date('2021/12/25','yyyy/mm/dd') - sysdate) from dual;

--3. to_number() : 문자형을 숫자형으로 변환해주는 함수
--   to_number( '문자 데이터', '구분기호')
select  '20,000' - '10,000' from dual;      -- 오류 발생
select to_number('20,000','99,999') - to_number('10,000','99,999') from dual;
--------------------------------------------------------------------------------

-- nvl() : null값을 다른값으로 변환해주는 함수
-- 1.null 값은 정해지지 않은 값을 의미
-- 2.null 값은 산술연산(+,-,*,/)이 되지 않는다.

--Q. 사원테이블에 있는 각 사원들의 연봉을 계산하는 SQL문 작성?
--   연봉 = 급여(SAL) * 12 + COMM
--   NVL(COMM, 0) : COMM 이 NULL값인 데이터를 0으로 

select sal*12 + nvl(comm, 0) as "연봉" from emp;

----------------------------------------------------------------------
-- decode() : switch ~ case 구문과 유사
-- decode( 컬럼명,  값1, 결과1,
--                 값2, 결과2,
--                 값3, 결과3, 
--                 ...........)

--Q. 사원테이블에서 부서번호(deptno)를 부서명으로 바꿔서 출력하는 SQL문 작성?
select ename, deptno, decode( deptno, 10, 'ACCOUNTING',
                                      20, 'RESEARCH',
                                      30, 'SALES',
                                      40, 'OPERATION') as dname from emp;
------------------------------------------------------------------------------
-- case() : if ~ else if 문과 유사
-- case when 조건1 then 결과1
--      when 조건2 then 결과2
--      else 결과3
-- end
--Q. 사원테이블에서 부서번호(deptno)를 부서명으로 바꿔서 출력하는 SQL문 작성?
select ename, deptno, case when deptno=10 then 'ACCOUNTING'
                           when deptno=20 then 'RESEARCH'
                           when deptno=30 then 'SALES'
                           else 'OPERATION' end from emp;
