-- MySql에서 가장 많이 사용하는 문자열 함수 정리
-- 실무에서는 DB 내장함수는 잘 사용하지 않음.

-- SUBSTRING : 특정 범위 문자 자르기
-- 사원이름 첫번째 부터 세번째까지만 출력하기
SELECT SUBSTRING(ENAME,1,3) FROM EMP 

-- 사원 입자날짜 년-월까지만 출력
SELECT SUBSTRING_INDEX(HIREDATE, '-', 2) FROM EMP

-- LEFT 왼쪽으로 3번째 까지만 문자 추출
SELECT LEFT(ENAME, 3) FROM EMP

-- RIGHT 오른쪽으로 3번째 까지만 문자 추출
SELECT RIGHT(ENAME, 3) FROM EMP

-- 소문자 -> 대문자 변환
SELECT UPPER(ENAME) FROM EMP;
-- 대문자 -> 소문자 변환
SELECT LOWER(ENAME) FROM EMP;
-- 문자열 길이 반환
SELECT LENGTH(ENAME) FROM EMP;
-- 한글 문자열 길이 반환
SELECT CHAR_LENGTH('홍길동') FROM DUAL;

-- DATEDIFF, 날짜와 날짜 사이 일 수 구하기
SELECT DATEDIFF('2023-12-25',NOW()) FROM DUAL;

-- DDL (CREATE, DROP, ALTER)

-- 데이터 타입
-- 1. INTEGER = 정수
-- 2. BIGINT (= LONG)
-- 3. BOOL = TRUE, FALSE
-- 4. DECIMAL
-- 5. DATE, TIMESTAMP
-- 6. VARCHAR (= STRING)
-- 7. BLOB (엄청 많은 문자열 저장 할 때) ex) 게시판 글 내용 저장할 때

-- 테이블 생성 해보기
CREATE TABLE STUDENT(
	STUDENT_ID INT COMMENT '학생번호',
	NAME VARCHAR(20) COMMENT '학생이름',
	ADDR VARCHAR(50) COMMENT '주소',
	AGE INT COMMENT '나이',
	CREATE_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '생성날짜'
);
-- DEFAULT(기본값) : INSERT 할 때 해당 컬럼 값을 입력하지 않아도 자동으로 기본값이 설정 됨.
INSERT INTO STUDENT (STUDENT_ID, NAME, ADDR, AGE) VALUES (100,'홍길동', '서울 강남구', 20);

COMMIT;
-- *****COMMIT
-- INSERT, DELETE, UPDATE 다음엔 COMMIT 명령어를 실행 해야한다.
-- COMMIT은 최종 저장을 의미한다.
-- 디비버 같은 데이터베이스 연동 프로그램은 자동으로 COMMIT 명령어를 처리해 준다.

-- 테이블 삭제
DROP TABLE STUDENT;

-- 테이블 생성 (여러가지 옵션 추가)
-- PRIMARY KEY 는 고유한 값을 가진 컬럼에 사용한다. (중복 방지)
-- PRIMARY KEY 는 NOT NULL 과 INDEX 기능도 가지고 있다.
CREATE TABLE STUDENT(
	STUDENT_ID INT PRIMARY KEY COMMENT '학생번호',
	NAME VARCHAR(20) NOT NULL COMMENT '이름',
	ADDR VARCHAR(50) NOT NULL DEFAULT '일본 도쿄' COMMENT '주소',
	AGE INT DEFAULT 20 COMMENT '나이',
	CREATE_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '생성날짜'
);

INSERT INTO STUDENT (STUDENT_ID, NAME, ADDR) VALUES (1, '홍길동', '서울 강남구');

DROP TABLE STUDENT;

-- AUTO_INCREMENT : 증감 연산자
CREATE TABLE STUDENT(
	STUDENT_ID INT AUTO_INCREMENT PRIMARY KEY COMMENT '학생번호',
	NAME VARCHAR(20) NOT NULL COMMENT '이름',
	ADDR VARCHAR(50) NOT NULL DEFAULT '일본 도쿄' COMMENT '주소',
	AGE INT DEFAULT 20 COMMENT '나이',
	CREATE_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '생성날짜'
);
INSERT INTO STUDENT (NAME, ADDR) VALUES ('홍길동', '서울 강남구');

-- Q. 테이블 이름 MOVIE
--	컬럼이름 MOVIE_ID(INT), MOVIE_NAME(VARCHAR), GENRE(VARCHAR), MOVIE_TIME(TIMESTAMP)
-- MOVIE_ID는 고유한 값이고, MOVIE_NAME과 GENRE는 NULL이 올수 없다.
-- MOVIE_TIME에 기본값은 현재시각이다.

CREATE TABLE MOVIE(
	MOVIE_ID INT AUTO_INCREMENT PRIMARY KEY COMMENT '영화아이디',
	MOVIE_NAME VARCHAR(20) NOT NULL COMMENT '영화이름',
	GENRE VARCHAR(20) NOT NULL COMMENT '장르',
	MOVIE_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '상영시간'
);

DROP TABLE MOVIE;

INSERT INTO MOVIE (MOVIE_NAME, GENRE) VALUES ('전우치', '코미디');

INSERT INTO MOVIE (MOVIE_NAME, GENRE) VALUES ('신세계', '느와르');

INSERT INTO MOVIE (MOVIE_NAME, GENRE) VALUES ('존 윅', '액션');

INSERT INTO MOVIE (MOVIE_NAME, GENRE) VALUES ('아저씨', '액션')

-- 테이블 2개 생성하기
-- FOREIGN KEY : 외래키(참조키) 설정
-- 참조키는 NULL이 올 수 있고, INDEX 기능 없음
-- *****고유키는 NULL이 올 수 없다.

CREATE TABLE PLAYER(
	PLAYER_ID INT AUTO_INCREMENT PRIMARY KEY COMMENT '선수 고유번호',
	NAME VARCHAR(20) NOT NULL COMMENT '선수이름',
	TEAM_ID INT COMMENT '팀 번호',
	FOREIGN KEY(TEAM_ID) REFERENCES TEAM(TEAM_ID)
);

-- 팀 테이블
CREATE TABLE TEAM (
	TEAM_ID INT AUTO_INCREMENT PRIMARY KEY COMMENT '팀 고유번호',
	NAME VARCHAR(20) NOT NULL COMMENT '팀 이름'
);

INSERT INTO TEAM (NAME) VALUES ('한화이글스');
INSERT INTO TEAM (NAME) VALUES ('두산베어스');
INSERT INTO TEAM (NAME) VALUES ('롯데자이언츠');

INSERT INTO PLAYER (NAME, TEAM_ID) VALUES ('문동주', 1);
INSERT INTO PLAYER (NAME, TEAM_ID) VALUES ('류현진', 1);
INSERT INTO PLAYER (NAME, TEAM_ID) VALUES ('오재원', 2);
INSERT INTO PLAYER (NAME, TEAM_ID) VALUES ('이대호', 3);

-- Q. 문동주 선수의 팀 이름을 조회하는 SQL문을 작성하시오.
SELECT
	P.NAME AS '선수이름',
	T.NAME AS '팀 이름'
FROM PLAYER AS P
INNER JOIN TEAM AS T
ON P.TEAM_ID = T.TEAM_ID
WHERE P.NAME = '문동주';

-- TEAM_ID 1번은 이미 한화이글스가 사용하고 있기 때문에
-- 다른 팀이 TEAM_ID로 1번을 사용할 수 없다.

-- PLAYER 와 TEAM 관계를 *****N:1 관계라고 정의하며, 실무에서 매우 중요하다.

-- 1:N (one to many)
-- ex) 선수와 팀 관계, 사원과 부서 관계, 유저와 서버 관계

-- 1:1 (one to one)
-- ex) 결혼, 군인-총 

-- *****M:N (many to many)
-- ex) 학생과 수강관계(학생 테이블, 과목 테이블, 수강 테이블)
-- M:N는 3개 이상 테이블이 생긴다.

















