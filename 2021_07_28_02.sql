-- 2021.07.28

-- PL/SQL

--Q. Hello World~!! 출력
set SERVEROUTPUT on
begin
DBMS_OUTPUT.PUT_LINE('Hello World~!!');
end;

-- 변수 사용하기
set SERVEROUTPUT on
declare                                 -- 선언부 시작
    vempno number(4);                   -- 변수 선언 : 스칼라 변수 
    vename varchar2(10);
begin                                   -- 실행부 시작
    vempno := 7788;                     -- 변수명은 대.소문자를 구분하지 않는다.
    vename := 'SCOTT';
    DBMS_OUTPUT.PUT_LINE('사번 / 이름');
    DBMS_OUTPUT.PUT_LINE(VEMPNO || '/' || VENAME);
end;                                    -- 실행부 끝

-- 사번과 이름 검색하기
set SEVEROUTPUT on
declare
    vempno emp.empno&type;  -- 레퍼런스 변수(emp 테이블의 empno 타입으로)
    vename emp.ename&type;
begin
    select empno, ename into vempno, vename from emp where ename='SCOTT';
    DBMS_OUTPUT.PUT_LINE('사번/이름');
    DBMS_OUTPUT.PUT_LINE(vempno || '/' || vename);
end;
