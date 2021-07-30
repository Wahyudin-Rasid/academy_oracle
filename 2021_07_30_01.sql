-- 2021.07.30(금)

-- 저장 함수
--Q2. 사원명을 저장함수의 매개변수로 전달하여 해당 사원의 직급을 구해오는 함수
--1. 저장함수 생성
create or replace function job_emp(vename in emp.ename%type)
    return varchar2
is
    vjob emp.job%type;  -- 로컬 변수
begin
    select job into vjob from emp where ename = vename;
    return vjob;
end;
/
--2. 저장 함수 목록 확인
select * from user_source;
--3. 바인드 변수 생성
variable varr_job varchar2(10);

execute :varr_job := job_emp('SCOTT');
print varr_job;

-- 저장 함수를 SQL문에 포함해서 실행
select ename, job_emp('KING') from emp where ename = 'KING';

-- 카사(cursor)
-- : 2개 이상의 데이터를 처리할 때 커서를 사용함

--Q1. 부서 테이블의 모든 데이터를 출력하기 위한 PL/SQL 작성
--1. 저장 프로시저 생성
set serveroutput on
create or replace procedure cursor_sample01
is
    vdept dept%rowtype;
    cursor c1
    is
    select * from dept;
begin
    dbms_output.put_line('부서번호 / 부서명 / 지역명');
    dbms_output.put_line('--------------------------');
    
    open c1;
        loop
            fetch c1 into vdept.deptno, vdept.dname, vdept.loc;
            exit when c1%notfound;
        dbms_output.put_line(vdept.deptno||'/'||vdept.dname||'/'||vdept.loc);
        end loop;
    close c1;
end;
/
--2. 프로시저 목록 확인
select * from user_source;

--3. 프로시저 실행
execute cursor_sample01;

--Q2. 부서 테이블의 모든 내용을 출력하기 : For Loop문으로 처리
-- 1. open - fetch - close 없이 처리할 수 있다
-- 2. for loop문을 사용하게 되면 각 반복문 마다, cursor를 열고, 각 행을 인출(Fetch)

--1. 저장 프로시저 생성
create or replace procedure cursor_sample02
is
    vdept dept%rowtype;
    
    cursor c1
    is
    select* from dept;
begin
    dbms_output.put_line('부서번호 / 부서명 / 지역명');
    DBMS_OUTPUT.PUT_line('----------------');
    
    for vdept in c1 loop
        exit when c1%notfound;
        dbms_output.put_line(vdept.deptno||'/'||vdept.dname||'/'||vdept.loc);
    end loop;
end;
/
--2. 프로시저 목록 확인
select * from user_source;
--3. 프로시저 실행
execute cursor_sample02;

--Q3. 부서번호를 전달하여 해당 부서에 소속된 사원의 정보를 출력하는 프로시저를 
--    커서를 이용해서 처리하세요
--1. 저장 프로시저 생성
create or replace procedure info_emp(vdeptno in emp.deptno%type)
is
    vemp emp%rowtype;
    
    cursor c1
    is
    select * from emp where deptno = vdeptno;
begin
    dbms_output.put_line('부서번호 / 사원번호 / 사원명 / 직급 / 급여');
    dbms_output.put_line('-------------------------------------');
    for vemp in c1 loop
        DBMS_OUTPUT.PUT_LINE(vemp.deptno||'/'||vemp.empno||'/'||vemp.job||'/'||vemp.sal);
        exit when c1%notfound;
    end loop;
end;
/
execute info_emp(10);
---------------------------------------------------------------

-- 패키지(package) = 저장 함수 : 저장 프로시저

-- 패키지(package) = 저장 함수 + 저장 프로시저
 
--1. 패키지 헤드 생성
create or replace package exam_pack
is
    function cal_bonus(vempno in emp.empno%type)        --  저장 함수
        return number;
    procedure cursor_sample02;                          -- 저장 프로시저 
end; 
 
--2. 패키지 바디 생성 
create or replace package body exam_pack
is

-- 저장 함수 : cal_bonus()
function cal_bonus(vempno in emp.empno%type)        --  저장 함수
    return number
is
    vsal number(7,2);
begin
    select sal into vsal from emp where empno = vempno;
    return vsal * 2;
end;

-- 저장 프로시저 : cursor_sample02
procedure cursor_sample02
is
    vdept dept%rowtype;
    
    cursor c1                   -- 커서 선언
    is
    select * from dept;
begin
    DBMS_OUTPUT.PUT_LINE('부서번호  /  부서명  /  지역명');    
    DBMS_OUTPUT.PUT_LINE('---------------------------');
    
    for vdept in c1 loop
        exit when c1%notfound;
        DBMS_OUTPUT.PUT_LINE(vdept.deptno||'/'||vdept.dname||'/'||vdept.loc);
    end loop;
end;

end;
/
--3. 저장 프로시저 실행 : cursor_sample02
execute  exam_pack.cursor_sample02;

--4. 저장 함수 실행 : cal_bonus()
-- 바인드 변수 생성
variable var_res number;

execute :var_res := exam_pack.cal_bonus(7788);
print var_res;

select ename, exam_pack.cal_bonus(7788) from emp where empno = 7788;

-- 트리거(trigger)
--Q1. 사원 테이블에 사원이 등록되면, "신입사원이 입사했습니다" 를 출력하는 트리거
--1. emp01 테이블 생성
drop table emp01 purge;
create table emp01(
    empno number(4) primary key,
    ename varchar2(20),
    job varchar2(20) );

--2. 트리거 생성
set serveroutput on
create or replace trigger trg_01
    after insert on emp01
begin
    dbms_output.put_line('신입사원이 입사했습니다');
end;
/
select * from user_triggers;
--3. emp 테이블에 사원 입사시키기
insert into emp01 values(1111,'윤호','개발자');

--Q2. 사원 테이블(EMP01)에 신입사원이 등록되면, 급여 테이블(SAL01)에
--    급여정보를 자동으로 추가해주는 트리거

--1. 사원 테이블 생성 : EMP01
delete from emp01;
commit;

--2. 급여 테이블 생성 : SAL01
create table sal01(
    salno number(4) primary key,
    sal number(7,2),
    empno number(4) references emp01(empno) ); 

select * from tab;

--3. 시퀀스 생성
create sequence sal01_salno_seq;
select * from seq;

--4. 트리거 생성
create or replace trigger trg_02
    after insert on emp01           -- 이벤트 발생
    for each row                    -- 행레벨 트리거
begin
    insert into sal01 values(sal01_salno_seq.nextval, 100, :new.empno);
end;
/
--5. 트리거 목록 확인
select * from user_triggers;

--6. 이벤트 발생 : 회원가입
insert into emp01 values(1111,'안화수','프로그래머');
insert into emp01 values(1112,'홍길동','관리자');
insert into emp01 values(1113,'이순신','ANALYST');

--7. 데이터 확인
select * from emp01;
select * from sal01;






--Q3. 회원 정보가 삭제되면, 급여 정보를 자동으로 삭제하는 트리거 생성
delete from emp01 where empno=1111;     -- 삭제 안됨

--1. 트리거 생성
create or replace trigger trg_03
    after delete on emp01           -- 이벤트
    for each row
begin
    delete from sal01 where empno = :old.empno; 
end;
/
--2. 트리거 목록 확인
select * from user_triggers;

--3. 이벤트 발생
--  : 사원 테이블(EMP01)의 사원번호 1111번 사원을 삭제(탈퇴)하면 연쇄적으로 
--    급여 테이블(SAL01)의 급여 정보도 같이 삭제된다.
delete from emp01 where empno = 1111;
delete from emp01 where empno = 1112;
delete from emp01 where empno = 1113;

--4. 결과 확인
select * from emp01;
select * from sal01;


