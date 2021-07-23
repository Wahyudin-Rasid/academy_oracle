-- 2021.07.23(금)

-- 트랜잭션(Transaction) 
-- 1.논리적인 작업 단위
-- 2.데이터의 일관성을 유지하면서, 데이터를 안정적으로 복구하기 위해서 사용한다. 

-- TCL(Transaction Control Langage)
-- commit : 트랜잭션을 종료
-- rollback : 트랜잭션을 취소
-- savepoint : 복구할 시점(저장점)을 지정하는 역할

--[실습]
drop table dept01 purge;
create table dept01 as select * from dept;      -- 복사본 테이블 생성
select * from dept01;

-- rollback : 트랜잭션을 취소(데이터 복구)
delete from dept01;
rollback;

-- commit : 트랜잭션을 종료
delete from dept01 where deptno=20;
commit;     -- 트랜잭션 종료
rollback;   -- 트랜잭션이 종료 되었기 때문에 삭제된 20번 데이터는 복구하지 못한다.

-- 자동 커밋 : 자동으로 커밋이 수행
-- 1) 정상적인 종료 : quit, exit, con.close()
-- 2) DDL(create, alter, rename, drop, truncate), DCL(grant, revoke)
--    명령이 수행
--예1.
select * from dept01;   -- 10, 30, 40
delete from dept01 where deptno=40;         -- 40번 데이터 삭제

create table dept03 as select * from dept;  -- 자동 커밋 수행(DDL) 

rollback;       -- 삭제된 40번 데이터는 복구하지 못한다.

--예2.
-- DML(delete), DDL(truncate)
select * from dept01;    -- 10, 30
delete from dept01 where deptno = 30;   -- DML(delete)
rollback;               --삭제된 30번 데이터를 복구한다

truncate table dept01;  -- 자동 커밋 수행(DDL)
rollback;               -- dept01 테이블의 데이터를 복구하지 못한다

-- 자동 롤백
-- : 비정상적인 종료 ( 강제로 창을 닫거나, 컴퓨터가 다운되는 경우)

-- savepoint : 임시 저장점을 지정할 때 사용되는 명령
-- [실습]
drop table dept01 purge;

--1. dept01 테이블 생성
create table dept01 as select * from dept;
select * from dept01;

--2. 40번 부서 삭제
delete from dept01 where deptno = 40;

--3. commit 수행 : 트랜잭션 종료
commit;

--4. 부서 삭제 및 savepoint 지정
delete from dept01 where deptno = 30;
savepoint c1;
delete from dept01 where deptno = 20;
savepoint c2;
delete from dept01 where deptno = 10;

--5. 복구
rollback to c2;
select * from dept01;

rollback to c1;
select * from dept01;

rollback;   -- 이놈은 이전 트랜잭션 종료(commit했을때) 이후에 것까지 싹다 복구
select * from dept01;

--------------------------------------------------------------------------
-- 무결성 제약조건
-- : 테이블에 부적절한 데이터가 입력되는 것을 방지하기 위해서 테이블을 생성할 때 
--   각 컬럼에 대해서 정의하는 여러가지 규칙을 말한다.
--   ex) not null, unique, primary key, foreign key, check, default

--1. not null 제약조건
--   null 값을 허용하지 않는다. (반드시 값을 입력해야함)
--[실습]
drop table emp02 purge;
create table emp02(
    empno number(4) not null,
    ename varchar2(12) not null,
    job varchar2(12),
    deptno number(2));
    
insert into emp02 values(1111,'송윤호','MANAGER',30);
select * from emp02;
insert into emp02 values(null,null,'MANA',20);

--2. unique 제약 조건
--   유일한 값만 입력 가능, 중복된 값은 입력 불가, null값은 입력가능
drop table emp03 purge;
create table emp03(
    empno number(4) unique,
    ename varchar2(12) not null,
    job varchar2(12),
    deptno number(2) );
    
insert into emp03 values(1111,'송윤호','개발자',10);
-- unique 제약 조건 위배
insert into emp03 values(1111,'안화수','매니저',20);

insert into emp03 values(null,'홍길동','개발자',20);  -- 입력 잘 됨
select * from emp03;