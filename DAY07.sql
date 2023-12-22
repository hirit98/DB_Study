-- 12월 22일
-- CONCAT : 문자를 합쳐주는 함수
-- 사원이름 옆에 '님'이 붙어져 출력 됨.
SELECT CONCAT(ENAME,'님') FROM EMP;

-- DDL (CREATE, ALTER, DROP)
-- DML (SELETE, DELETE, INSERT, UPDATE)
-- 책 217p ~ 
-- COMMIT (TCL)
-- DML (INSERT, DELETE, UPDATE) -> COMMIT
-- 1. INSERT INTO EMP (EMPNO, ENAME) VALUES (9000, '홍길동');
-- 2. COMMIT (최종저장); COMMIT을 입력하지 않으면 INSERT가 반영되지 않는다.
-- *****지금까지 COMMIT을 사용하지 않고 데이터가 저장,삭제,수정 되었던 이유
-- 디비버(SQL 편집기) 같은 프로그램은 자동으로 Auto Commit이 설정되어 있다. 실무에서 실수를 방지하기 위해서는 auto commit 기능을 해제 하자

-- DDL (CREATE, ALTER, DROP) COMMIT에 영향을 받지 않는다.

-- 테이블 생성
CREATE TABLE X(
	EMPNO INT COMMENT '사원번호',
	ENAME VARCHAR(30) COMMENT '사원이름'
);

CREATE TABLE Y (
	DEPTNO INT AUTO_INCREMENT PRIMARY KEY COMMENT '부서번호',
	DNAME VARCHAR(50) COMMENT '부서이름'
);

INSERT INTO Y(DEPTNO, DNAME) VALUES (1, '영업부서');
INSERT INTO Y(DEPTNO, DNAME) VALUES (2, '기술지원팀');

-- 테이블 삭제
DROP TABLE X;
DROP TABLE Y;

-- 참조키(외래키)를 넣어서 테이블 생성
-- 참조키 (FOREIGN KEY)

CREATE TABLE Y (
	DEPTNO INT PRIMARY KEY COMMENT '부서번호',
	DNAME VARCHAR(20) COMMENT '부서이름'
);

CREATE TABLE X (
	EMPNO INT PRIMARY KEY COMMENT '사원번호',
	ENAME VARCHAR(30) COMMENT '사원이름',
	DEPTNO INT COMMENT '부서번호',
	FOREIGN KEY(DEPTNO) REFERENCES Y(DEPTNO)
);

INSERT INTO Y(DEPTNO, DNAME) VALUES (1, '영업부서');
INSERT INTO Y(DEPTNO, DNAME) VALUES (2, '기술지원팀');

INSERT INTO X(EMPNO, ENAME) VALUES (100, '홍길동');
INSERT INTO X(EMPNO, ENAME) VALUES (200, '박길동');

-- TABLE X에 DEPTNO가 NULL값이 들어갈 수 있다.

-- Q. 사원번호가 100인 사원에 부서번호를 1번, 200번인 사원에 부서번호를 2번으로 수정하시오
UPDATE X SET DEPTNO = 1 WHERE EMPNO = 100;
UPDATE X SET DEPTNO = 2 WHERE EMPNO = 200;

INSERT INTO Y(DEPTNO, DNAME) VALUES (3, 'SALES');

-- 부서번호 1번 삭제하기
DELETE FROM y WHERE deptno = 1;

-- 부서번호 3번 삭제하기
DELETE FROM y WHERE deptno = 3;

-- 부서번호 2번 삭제하기
DELETE FROM y WHERE deptno = 2;

-- ***** on delete 설정 때문에 1번과 2번은 삭제 될 수 없다.
-- FK가 설정된 순간 데이터 삭제는 까다롭다.
-- 테이블 X에 있는 deptno가 1,2번 이다
-- 1번, 2번 deptno는 현재 사용 중이기 때문에 삭제할 수 없다.

-- 200번의 부서번호를 1번으로 수정 후 삭제해보기
UPDATE X SET deptno = 1 WHERE empno = 200;

-- 아무도 사용하고 있지 않기 때문에 삭제가능.
DELETE FROM y WHERE deptno = 2;

-- 즉, FK(외래키)는 테이블간 데이터를 엄격하게 다룬다. 이는 관계형 데이터베이스를 사용하는 이유 중 하나다. 
-- MySQL(관계형 데이터베이스)

-- 사용중이어도 삭제를 할 수 있게 설정 ***** on delete ********cascade

DROP TABLE X;
DROP TABLE Y;

CREATE TABLE Y (
	DEPTNO INT PRIMARY KEY COMMENT '부서번호',
	DNAME VARCHAR(20) COMMENT '부서이름'
);

CREATE TABLE X (
	EMPNO INT PRIMARY KEY COMMENT '사원번호',
	ENAME VARCHAR(30) COMMENT '사원이름',
	DEPTNO INT COMMENT '부서번호',
	FOREIGN KEY(DEPTNO) REFERENCES Y(DEPTNO) ON DELETE CASCADE
);

INSERT INTO Y(DEPTNO, DNAME) VALUES (1, '영업부서');
INSERT INTO Y(DEPTNO, DNAME) VALUES (2, '기술지원팀');
INSERT INTO Y(DEPTNO, DNAME) VALUES (3, 'QA팀');

INSERT INTO X(EMPNO, ENAME) VALUES (100, '홍길동');
INSERT INTO X(EMPNO, ENAME) VALUES (200, '박길동');

DELETE FROM Y WHERE deptno = 2;

-- 면접 단골 on delete cascade
-- 부모 테이블은 dept 자식 테이블은 emp 구조를 가지게 됨.
-- on delete : 부모 테이블에서 삭제 이벤트가 발생하면 자식 테이블 데이터에 이벤트 발생
-- on update : 부모 테이블에서 수정 이벤트가 발생하면 자식 테이블 데이터에 이벤트 발생

-- 이벤트 종류
-- 1. cascade : 자식 테이블 데이터 삭제 or 수정
-- 2. set null : 자식 테이블 데이터 null 업데이트
-- 3. set default : 자식 테이블 데이터 default 값으로 변경
-- 4. restrict(default) : 자식 테이블에서 데이터 사용중 일 때 삭제 or 수정 불가능 (기본값)
-- 5. no action : 자식 테이블 데이터는 변경되지 않는다.

-- 4번 부서 추가
INSERT INTO Y (deptno, dname) VALUES (4, '개발부서');

-- 사원 추가
INSERT INTO X (empno, ename, deptno) VALUES (400, 'KING', 4);

DELETE FROM Y WHERE deptno = 4;
-- on delete cascade로 설정되어 있기 때문에 테이블 X에서 부서번호가 4번인 사원도 삭제된다

-- 1:N, M:N, 1:1 관계
-- 테이블 emp 와 테이블 dept 관계를 1:N관계
-- 여러명의 사원(N)이 한 개의 부서(1)에 소속 될 수 있기 때문

-- Q. 주제는 영화 1:N 관계를 가지는 테이블 2개를 만들어 보시오.
CREATE TABLE movie(
	movie_no int AUTO_INCREMENT PRIMARY KEY comment '영호번호',
	name varchar(20) comment '영화이름',
	genre_num int comment '장르번호',
	FOREIGN key(genre_num) REFERENCES genre(genre_num)
);

CREATE TABLE genre(
	genre_num int AUTO_INCREMENT PRIMARY KEY comment '장르번호',
	genre_name varchar(20) comment '장르명' 
);


----------------------------------------------------------------------
CREATE TABLE actor (
	actor_id int PRIMARY KEY comment '배우 고유아이디',
	actor_name varchar(20) comment '배우 이름',
	movie_id int comment '영화 고유아이디',
	FOREIGN KEY(movie_id) REFERENCES movie_info(movie_id) ON DELETE NO ACTION
);


CREATE TABLE movie_info (
	movie_id int PRIMARY KEY comment '영화 고유아이디',
	movie_name varchar(20) comment '영화 이름',
	genre varchar(20) comment '장르'
);

INSERT INTO movie_info (movie_id, movie_name, genre) VALUES (1, 'Avengers', 'Action');

INSERT INTO actor (actor_id, actor_name, movie_id) VALUES (1, 'Chris Evans', 1);
INSERT INTO actor (actor_id, actor_name, movie_id) VALUES (2, 'Robert Downey', 1);
INSERT INTO actor (actor_id, actor_name, movie_id) VALUES (3, 'Mark Ruffalo', 1);
INSERT INTO actor (actor_id, actor_name, movie_id) VALUES (4, 'Scarlett Johansson', 1);

-- 어벤져스에 출연 한 영화 배우 이름, 배우 아이디 조회하는 SQL 문

SELECT 
	a.actor_name, 
	a.actor_id 
FROM movie_info AS m
INNER JOIN actor AS a
ON m.movie_id = a.movie_id
WHERE m.movie_name = 'Avengers';

ALTER TABLE movie_info ADD COLUMN actor_id int comment '배우 아이디';

INSERT INTO movie_info (movie_id, movie_name, genre) VALUES (1, 'Avengers-Endgame', 'Action');
-- ****** 오류 나는 이유? 1번은 이미 사용중이여서

INSERT INTO movie_info (movie_id, movie_name, genre, actor_id) VALUES (2, 'Avengers-Endgame', 'Action',1);


-- movie_id가 아닌 actor_id 로 조인하기
-- join은 데이터타입만 같으면 모두 가능
-- 테이블 생성 할 때 foreign key를 설정하지 않아도 조인은 가능.
-- foreign key를 설정하면
-- 장점) 테이블 관계를 쉽게 파악 할 수 있다.
-- 단점) 데이터를 삭제&수정 하는데 제약사향이 있다. on delete 같은 설정이 추가로 필요함

-- foreign key 없이 join (데이터 타입만 같다면 join이 됨) <- 종종 대형 프로젝트에서 이런식으로 운영함
-- 장점) 데이터를 쉽게 삭제&수정 할 수 있다.
-- 단점) 테이블 관계를 파악하기 어렵다.

SELECT 
	m.movie_name,
	a.actor_name
FROM movie_info AS m
INNER JOIN actor AS a
ON m.actor_id = a.ACTOR_ID;




-- 한 테이블에 컬럼이 많으면 성능저하로 이어짐.

-- 대표적인 1:N 관계
-- 1. 사원 - 부서
-- 2. 팀 - 선수


-- *****M:N 관계 테이블 생성하기

-- 대표적인 M:N 관계
-- 1. 학생, 과목, 수강
-- 2. 회원, 물품, 구매이력
























