-- 2021.07.29(목)

-- 조건문(=선택문)
--1. if ~ then ~ end if
--Q. SCOTT 사원의 부서번호를 검색해서 부서명을 출력 PL/SQL 작성?

SET SERVEROUTPUT ON
declare                             -- 선언부
    vempno number(4);
    vename varchar2(20);
    vdeptno dept.deptno%type;
    vdname varchar2(20) := null;
begin                               -- 실행부
    select empno, ename, deptno into vempno, vename, vdeptno from emp
        where ename = 'SCOTT';
    
    if vdeptno = 10 then
        vdname := 'ACCOUNTING';
    end if;
    if vdeptno = 20 then
        vdname := 'RESEARCH';
    end if;
    if vdeptno = 30 then
        vdname := 'SALES';
    end if;
    if vdeptno = 40 then
        vdname := 'OPERATIONS';
    end if;
    
    DBMS_OUTPUT.PUT_LINE('사번 / 이름 / 부서명');
    DBMS_OUTPUT.PUT_LINE(vempno || '/' || vename || '/' || vdname);
end;

--Q. 사원 테이블에서 SCOTT 사원의 연봉을 구하는 PL/SQL 작성 ?
SET SERVEROUTPUT ON
declare
    vemp emp%rowtype;           -- 레퍼런스 변수
    annsal number(7,2);         -- 스칼라 변수
begin
    select *  into vemp from emp where ename = 'SCOTT';
    
    if vemp.comm is null then
        vemp.comm := 0;
    end if;
    
    annsal := vemp.sal * 12 + vemp.comm;
    DBMS_OUTPUT.PUT_LINE('사번 / 이름 / 연봉');
    DBMS_OUTPUT.PUT_LINE(vemp.empno || '/' || vemp.ename || '/' || annsal);
end;


--2. if ~ then ~ else ~ end if
--Q. 사원 테이블에서 SCOTT 사원의 연봉을 구하는 PL/SQL 작성 ?
set SERVEROUTPUT ON
declare
    vemp emp%rowtype;           -- 레퍼런스 변수
    annsal number(7,2);         -- 스칼라 변수
begin
      select * into vemp from emp where ename = 'SCOTT';
      
      if vemp.comm is null then
        annsal := vemp.sal * 12;
      else
        annsal := vemp.sal * 12 + vemp.comm;
      end if;
        
      DBMS_OUTPUT.PUT_LINE('사번 / 이름 / 연봉');
      DBMS_OUTPUT.PUT_LINE(vemp.empno || '/' || vemp.ename || '/' || annsal);  
end;

--3. if ~ then ~ elsif ~ else ~ end if
--Q. 부서 번호를 이용해서 부서명을 구하는 PL/SQL 작성?
SET SERVEROUTPUT ON
declare
    vemp emp%rowtype;
    vdname varchar2(14);
begin
    select * into vemp from emp where ename = 'SCOTT';

    if vemp.deptno = 10 then
        vdname := 'ACCOUNTING';
    elsif vemp.deptno = 20 then
        vdname := 'RESEARCH';
    elsif vemp.deptno = 30 then
        vdname := 'SALES';
    elsif vemp.deptno = 40 then
        vdname := 'OPERATIONS';
    end if;
    
    DBMS_OUTPUT.PUT_LINE('사번 / 이름 / 부서명');
    DBMS_OUTPUT.PUT_LINE(vemp.empno || '/' || vemp.ename || '/' || vdname);
end;
    

-- 반복문
--1. Basic Loop문
-- loop
--    반복 실행될 문장;
-- end loop;

--Q1. 1 ~ 5까지 출력
SET SERVEROUTPUT ON
declare
    n number := 1;          -- 변수의 초기값 1
begin
    loop
        DBMS_OUTPUT.PUT_LINE(n);
        n := n + 1;
        if n > 5 then
            exit;
        end if;
    end loop;
end;


--Q2. 1부터 10까지 합을 구하는 프로그램 작성
SET SERVEROUTPUT ON
declare
    n number := 1;          -- 루프를 돌릴 변수
    s number := 0;          -- 합이 누적될 변수
begin
    loop
        s := s + n;
        n := n + 1;
        if n > 10 then
            exit;
        end if;        
    end loop;
    DBMS_OUTPUT.PUT_LINE('1~10까지의 합:' || s);
end;


--2. For Loop문
--Q1. For Loop문으로 1부터 5까지 출력
set SERVEROUTPUT ON
begin
    for n in 1..5 loop          --- 자동으로 1씩 증가
        DBMS_OUTPUT.PUT_LINE (n);      
    end loop;
end;

--Q2. For Loop문으로 5부터 1까지 출력
set SERVEROUTPUT ON
begin
    for n in reverse 1..5 loop          --- 자동으로 1씩 감소
        DBMS_OUTPUT.PUT_LINE (n);      
    end loop;
end;

--Q3. For Loop문을 이용해서 부서 테이블(DEPT)의 모든 정보를 출력하는 PL/SQL 작성?
SET SERVEROUTPUT ON
declare
    vdept dept%rowtype;
begin
    DBMS_OUTPUT.PUT_LINE('부서번호 / 부서명 / 지역명');
    for cnt in 1..4 loop
        select * into vdept from dept where deptno = 10 * cnt;
        
        DBMS_OUTPUT.put_line(vdept.deptno||'/'||vdept.dname||'/'||vdept.loc);
    end loop;
end;


--3. while loop문
--Q1. while loop문으로 1부터 5까지 출력
set SERVEROUTPUT ON
declare
    n number := 1;
begin
    while n<=5 loop
        DBMS_OUTPUT.PUT_LINE(n);
        n := n + 1;
    end loop;
end;

--Q2. while loop문을 별(*)을 삼각형 모양으로 출력
set SERVEROUTPUT ON
declare
    c number := 1;
    str varchar2(100) := null;
begin
    while c<=5 loop
        str := str || '*';
        DBMS_OUTPUT.put_line(str);
        c := c + 1;
    end loop;
end;





