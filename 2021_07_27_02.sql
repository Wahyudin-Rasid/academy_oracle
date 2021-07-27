-- 2021.07.27(화)

-- 시퀀스(sequence)
-- : 테이블에 숫자를 자동으로 증가 시켜서 처리해주는 역할

-- 시퀀스 생ㅇ성
create sequence dept_deptno_seq 
start with 10
increment by 10;

-- 시퀀스 목록
select * from seq;
select * from user_sequences;

-- currval : 시퀀스 현재값을 반환
-- nextval : 시퀀스 다음값을 반환
select nextval from dept_deptno_seq;
select dept_deptno_seq.nextval from dual;   -- 맨처음엔 nextval로 구해와야함
select dept_deptno_seq.currval from dual;

--예1. 시퀀스를 테이블의 기본키에 적용하기
drop table emp01 purge;
create table emp01(
    empno number(4) primary key,
    ename varchar2(10),
    hiredate date);
    
create sequence emp01_empno_seq;    -- 생략하면 1부터 1씩 증가하는 시퀀스 생성

select * from tab;
select * from seq;

insert into emp01 values(emp01_empno_seq.nextval,'송윤호',sysdate);

select * from emp01;

-- 예2.
-- 테이블 생성
create table dept_example(
    deptno number(4) primary key,
    dname varchar2(15),
    loc varchar2(15));
create sequence dept_example_deptno_seq
start with 10
increment by 10;

select * from tab;
select * from seq;
select * from dept_example;

-- 데이터 입력
insert into dept_example values
(dept_example_deptno_seq.nextval,'인사과','서울');
insert into dept_example values
(dept_example_deptno_seq.nextval,'경리과','서울');
insert into dept_example values
(dept_example_deptno_seq.nextval,'총무과','대전');
insert into dept_example values
(dept_example_deptno_seq.nextval,'기술팀','인천');

-- 시퀀스 삭제
-- drop sequence 시퀀스이름;
drop sequence dept_example_deptno_seq;
-- 시퀀스 수정
-- alter sequence 시퀀스이름 
drop sequence dept_deptno_seq;

create sequence dept_deptno_seq
start with 10
increment by 10
maxvalue 30;

-- 시퀀스 등록
select * from seq;
select * from user_sequences;

select dept_deptno_seq.nextval from dual;
select dept_deptno_seq.nextval from dual;
select dept_deptno_seq.nextval from dual;
select dept_deptno_seq.nextval from dual;   -- 4번째엔 40이므로 MAX에 걸림

-- 시퀀스 수정 : maxvalue : 30 -> 1000000
alter sequence dept_deptno_seq maxvalue 1000000;

------------------------------------------------------------
-- 인덱스(Index) : 빠른 검색을 하기 위해서 사용되는 객체
-- 인덱스 목록 확인
select * from user_indexes;

-- 기본키(primary key)로 설정된 컬럼은 자동으로 고유 index로 설정됨

-- [실습]
-- 인덱스 실습 : 인덱스 사용 유무에 따라 달라지는 검색 속도
-- 1. 테이블 생성
drop table emp01 purge;
-- 복사본 테이블 생성 : 제약 조건은 복사되지 않는다
create table emp01 as select * from emp;
-- 2. emp01 테이블에 데이터 입력
insert into emp01 select * from emp01;  -- 대충 100만개의 데이터
-- 3. 검색용 데이터 입력
insert into emp01(empno, ename) values(1111,'ahn');
-- 4. 시간 측정 타이머 온
set timing on
-- 5. 인덱스 없이 검색
select * from emp01 where ename='ahn';  -- 0.61초걸림
-- 6. 인덱스 생성 : ename 컬럼에 인덱스가 적용됨
create index idx_emp01_ename on emp01(ename);
select * from user_indexes; -- 인덱스 가지고있는것들 확인
-- 7. 검색용 데이터로 검색시간을 측정 : 인덱스가 설정된 경우
select * from emp01 where ename = 'ahn';    -- 0.008초

-- 인덱스 삭제
-- 형식 : drop index index_name;
drop index idx_emp01_ename;
set timing off

-- 인덱스 종류
-- 고유 인덱스 : 중복된 데이터가 없는 컬럼에 적용할 수 있는 인덱스
-- 비고유 인덱스 : 중복된 데이터가 있는 컬럼에 적용할 수 있는 인덱스

--1. 테이블 생성
drop table dept01 purge;
create table dept01 as select * from dept where 1=0;    -- 테이블 구조만 복사
--2. 데이터 입력
select * from dept01;
insert into dept01 values(10, '인사과', '서울');
insert into dept01 values(20, '충무과', '대전');
insert into dept01 values(30, '교육팀', '대전');

--3. 고유 인덱스 생성 : deptno 컬럼에 고유 인덱스 적용
create unique index idx_dept01_deptno on dept01(deptno);

-- 고유 인덱스로 설정된 deptno 컬럼에 중복 데이터를 입력 해보기
insert into dept01 values(30,'인사과','충남');   -- 오류 발생

--4. 인덱스 목록 확인
select * from user_indexes;

--5. 비공유 인덱스 : loc 컬럼에 고유, 비고유 인덱스를 적용 해보기
-- loc 컬럼은 중복된 값이 있기 때문에 비고유 인덱스로 만들어야함
create index idx_dept01_loc on dept01(loc); 

--6. 결합 인덱스 : 2개 이상의 컬럼으로 만들어진 인덱스
create index idx_dept01_com on dept01(deptno, dname);

--7. 함수 기반 인덱스 : 수식이나 함수를 적용해서 만든 인덱스
create index idx_dept01_annsal on emp01(sal*12);
select (sal*12) from emp;

