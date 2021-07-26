-- 2021.07.26(월)
--1. primary key(기능키)
--   primary key = not null + unique
--   반드시 중복되지 않는 값을 입력 해야된다

--   ex) 부서테이블(DEPT) - deptno(pk)
--       사원테이블(EMP)  - empno(pk)

select * from dept;
insert into dept values(10,'개발부','서울'); -- unique 제약조건 위배
insert into dept values(null,'개발부','서울');   -- not null 위배
-- DEPT 테이블의 DEPTNO 컬럼은 primary key 제약조건이 설정되있어서
-- 중복된 값과 null 값을 입력할 수 없다

select * from emp;
insert into emp(empno, ename) values(7788,'송윤호');   -- unique 제약조건 위배
insert into emp(empno, ename) values(null,'송윤호');   -- not null 위배

drop table emp05 purge;

create table emp05(
    empno number(4) primary key,
    ename varchar2(12) not null,
    job varchar2(12),
    deptno number(2) );
    
select * from emp05;
insert into emp05 values (1111,'송윤호','개발자','10');
--  primary key로된 컬럼에는 not null, unique를 위배해서 insert하면 안됨

-- 제약조건 이름(constraint_name)을 설정해서 테이블을 생성
drop table emp04 purge;
create table emp04(
    empno number(4) constraint emp04_empno_pk primary key,
    ename varchar2(20) constraint emp04_ename_nn not null,
    job varchar2(20),
    deptno number(2));
    
--4. foreign key (외래키)
-- dept(부모테이블) - deptno(pk,부모키) : 10, 20, 30, 40
-- emp(자식테이블) = deptno(fk) : 10,20,30

--1) 상원테이블(emp)의 deptno 컬럼이 foreign key 제약조건이 설정되어 있다
--2) foreign key 제약조건이 가지고 있는 의미는 부모테이블(dept)의 부모가
--   (deptno)의 값만 참조할 수 있다. (10,20,30,40번 부서번호만 참조가능)
--3) 부모키가 되기 위한 조건은 primary key나 unique 제약조건으로 설정되있어야함

--Q. 사원테이블(emp)에 제약조건을 위배해서 사원정보 등록해보기
-- 외래키는 부모키(dept - deptno)안에 있는 값(10,20,30,40)만 참조할 수 있다
insert into emp(empno,deptno) values(1111,50);  -- 오류발생

--[실습]
drop table emp06 purge;
create table emp06(
    emmpno number(4) primary key,
    ename varchar2(10) not null,
    job varchar2(10),
    deptno number(2) references dept(deptno) );
    
select * from emp06;
insert into emp06 values(1111,'송윤호','개발자',10);
insert into emp06 values(1112,'송윤호','개발자',20);
insert into emp06 values(1113,'송윤호','개발자',30);
insert into emp06 values(1114,'송윤호','개발자',40);
insert into emp06 values(1115,'송윤호','개발자',50);  -- 오류 발생

--5.check 제약조건
-- : 데이터가 입력될때 특정 조건을 만족하는 데이터만 입력되도록 만들어주는 제약조건

create table emp07(
    empno number(4) primary key,
    ename varchar2(10) not null,
    sal number(7,2) check(sal between 500 and 5000), -- sal : 500~5000
    gender varchar2(1) check(gender in('M','F')));  -- gender : 'M','F'

select * from emp07;
insert into emp07 values(1111,'송윤호','3000','M');
insert into emp07 values(1112,'송윤호','8000','M');    -- 오류발생
insert into emp07 values(1112,'송윤호','8000','m');    -- 오류발생

--6. default 제약조건
-- default 제약조건이 설정된 컬럼이 값이 입력되지 않으면 default로 설정된
-- 값이 자동으로 입력된다

drop table dept01 purge;
create table dept01(
    deptno number(2) primary key,
    dname varchar2(14),
    loc varchar2(13) default 'SEOUL');
    
select * from dept01;
insert into dept01 values(10, 'ACCOUNTING', 'NEWYORK');
insert into dept01(deptno,dname) values(20,'RESEARCH'); -- loc에 SEOUL 자동 입력


--제약 조건 설정 방식
--1. 컬럼레벨 방식으로 제약조건 설정
--2. 테이블레벨 방식으로 제약조건 설정

--1. 컬럼레벨 방식으로 제약조건 설정
drop table emp01 purge;

create table emp01(
    empno number(4) primary key,
    ename varchar2(15) not null,
    job varchar2(10) unique,
    deptno number(2) references dept(deptno) );

--2. 테이블레벨 방식으로 제약조건 설정
drop table emp02 purge;

create table emp02(
    empno number(4),
    ename varchar2(15) not null,
    job varchar2(10),
    deptno number(2),
    primary key(empno),
    unique(job),
    foreign key(deptno) references dept(deptno) );
    
-- 제약 조건을 결정할 때 테이블 레벨 방식만 가능한 경우(2가지)
--1. 기본기를 복합키로 설정하는경우 ( 한 테이블에서 pk키를 2개)
drop table member01 purge;

-- 컬럼 레벨 방식으로는 2개의 컬럼을 pk로 설정 불가
create table member01(
    id varchar2(20) primary key,
    passwd varchar2(20) primary key);   -- 오류 발생
    
--2. alter table로 제약조건을 추가할 경우

-- 테이블 레벨 방식으로는 pk 2개 가능
create table member01(
    id varchar2(20),
    passwd varchar2(20),
    primary key(id,passwd));
    
--2. alter table로 제약 조건을 추가할 경우
drop table emp01 purge;
-- 일단 제약조건이 없는 테이블로 만들고
create table emp01(
    empno number(4),
    ename varchar2(14),
    job varchar2(10),
    deptno number(2));
    
-- primary key 제약 조건 추가 : empno
alter table emp01 add primary key(empno);

-- not null 제약 조건 추가 : ename
alter table emp01 modify ename not null;

-- unique 제약 조건 추가 : job
alter table emp01 add unique(job);

-- foreign key 제약 조건 추가 : deptno
alter table emp01 add foreign key(deptno) references dept(deptno);

-- 제약조건 제거
-- 형식 : alter table 테이블명 drop constraint constraint_name;

-- primary key 제약조건 제거
-- constraint_name값은 확인해야함 ex)SYS_C007031
alter table emp01 drop constraint SYS_C007031; 
alter table emp01 drop primary key;

-- unique 제약조건 제거
alter table emp01 drop constraint SYS_C007033;
alter table emp01 drop unique(job);
-- not null 제약조건 제거
alter table emp01 drop constraint SYS_C007032;

-- foreign key 제약 조건 제거
alter table emp01 drop constraint SYS_C007034;


-- 제약 조건의 활성화 / 비활성화
--1. 부모 테이블 생성
drop table dept01 purge;
create table dept01(
    deptno number(2) primary key,
    dname varchar2(14),
    loc varchar(13));
    
insert into dept01 values(10,'ACCOUNTING','NEW YORK');
select * from dept01;

--2. 자식 테이블 생성
drop table emp01 purge;
create table emp01(
    empno number(4) primary key,
    ename varchar2(10) not null,
    job varchar2(10) unique,
    deptno number(2) references dept01(deptno) );
    
insert into emp01 values(1111, '송윤호','SALESMAN',10);
select * from emp01;
    
--3. 부모 테이블 데이터 삭제
delete from dept01; -- 참조하고 있는 자식이 있어서 안지워짐. 
-- 자식의 제약조건을 비활성화 시켜서 참조하는 데이터가 없는 상태로 만들어야함
-- alter table 테이블명 disablle constraint constraint_name;
alter table emp01 disable constraint SYS_C007067;

--cf. foreign key 제약조건을 활성화
alter table emp01 enable constraint SYS_C007067;   

-- CASCADE 옵션을 붙여서 부모 테이블(DEPT01)의 제약조건을
-- 비활성화 시키면, 참조하고 있는 자식 테이블(EMP01)의 foreign key 
-- 제약조건도 같이 비활성화 됨
alter table dept01 disable constraint SYS_C007063 cascade;
alter table dept01 enable constraint SYS_C007063 cascade;

-- cascade 옵션을 붙여서 부모 테이블(dept01)의 제약조건을 비활성화 시키면,
-- 참조하고 있는 자식 테이블(emp01)의 foreign key 제약조건도 같이 비활성화됨
alter table dept01 drop primary key cascade;


