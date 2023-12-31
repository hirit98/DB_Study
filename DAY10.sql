-- 인덱스
-- PRIMARY KEY (기본키)
-- 테이블 EMP 기준으로 EMPNO 컬럼에 PK가 설정되어 있음.
-- PK가 설정된 컬럼은 DEFAULT로 'NOT NULL'과 '인덱스'가 생성됨.

-- 인덱스(INDEX)란?
-- 데이터베이스가 데이터를 빨리 찾을 수 있게 도와줌
-- SELECT를 사용할 때 데이터를 더 빨리 찾을 수 있게 도와줌
-- 데이터가 적으면 오히려 인덱스는 성능저하의 원인이 된다.
-- 인덱스는 데이터가 많은 컬럼을 조회 할 때 사용해야 한다.

-- 데이터베이스에서 인덱스 종류는 크게 2가지
-- 1. 클러스터 인덱스(PRIMARY KEY 인덱스)
-- 2. 보조 인덱스(UNIQUE)

-- ***MySQL은 FK컬럼에도 INDEX를 부여한다. (오라클은 해당 없음)

-- 인덱스는 ***B-Tree라는 자료구조를 베이스로 실행 된다.
-- 보조 인덱스는 일반 책의 목차와 같고,
-- 클러스터 인덱스는 영어사전 처럼 정렬되어 있다.

SHOW INDEX FROM EMP;

-- EMPNO를 조회하는 쿼리, EMPNO에는 인덱스가 설정되어 있기 때문에 EMPNO를 잘 활용해야 한다.

SELECT EMPNO FROM EMP;
-- 인덱스 생성
-- 보조 인덱스
-- SAL 컬럼에 보조 인덱스 생성
CREATE INDEX IDX_EMP_SAL ON EMP (SAL);
CREATE INDEX IDX_EMP_HIREDATE ON EMP (HIREDATE);

-- 보조 인덱스는 여러개 만들 수 있지만, 클러스터 인덱스는 한개만 만들 수 있다.

-- 급여컬럼과 입사날짜 컬럼에 인덱스를 부여한 상태, 인덱스를 활용 하자
-- 인덱스를 활용하기 위해서는 서술 논리절에 인덱스를 사용해야 한다.
-- 서술 논리절은 WHERE, ORDER BY, GROUP BY, HAVING을 의미한다.
-- 서술 논리절에 인덱스를 활용하는 SQL문을 *****사거블(Sargable) 쿼리라고 한다.
-- 1. WHERE절을 이용해 인덱스를 활용하기
SELECT SAL, HIREDATE FROM EMP WHERE SAL > 1000;

-- ***주의할 점, 신입개발자들이 자주 실수하는 사거블 쿼리 모음
-- 1. LIKE %를 앞에 붙이는 경우
-- ENAME 컬럼에 인덱스를 부여했다고 가정
-- LIKE '%H' 처럼 앞에 %를 사용하는 경우 인덱스가 실행 실행불가
SELECT ENAME FROM EMP WHERE ENAME LIKE '%H';
-- 하지만 아래 쿼리는 인덱스 실행 됨
SELECT ENAME FROM EMP WHERE ENAME LIKE 'H%';

-- 2. WHERE절에 수치 연산을 하는 경우
-- 즉, WHERE 절에 인덱스 컬림인 SAL과 수치연산을 함. SAL * 1.10
SELECT EMPNO, ENAME FROM EMP WHERE SAL * 1.10 > 3000;

-- 3. 1개 이상의 필드의 대해 연산하는 함수를 사용하는 쿼리
-- DATE_FORMAT은 1개 이상의 필드에 연산하는 함수
SELECT EMPNO, ENAME FROM EMP WHERE DATE_FORMAT(HIREDATE, '%y') >= '1981';

-- CAST라는 함수를 이용해 HIREDATE에 직접 함수를 사용하지 않고 1981도 이후 입사한
-- 사원번호, 이름을 조회.
SELECT EMPNO, ENAME FROM EMP WHERE HIREDATE >= CAST('1981-01-01' AS DATE);

-- 4. 전체 조회 할 때
-- 데이터베이스가 판단 할 때 인덱스가 있더라도 전체 테이블을 검색하는게 낫겠다고 판단 함
SELECT EMPNO, ENAME FROM EMP WHERE SAL >= 0;

-- 인덱스는 구현 했지만 데이터베이스가 인덱스를 활용하지 못하는 쿼리 (논 사거블 쿼리)
-- 1. LIKE에서 맨 앞에 %가 있는 경우
-- 2. 사칙연산을 사용 한 경우
-- 3. 함수를 사용 한 경우
-- 4. 전체 조회하는 구문을 실행 할 경우

-- 사거블 쿼리이지만 성능 향상 목적으로는 사용하지 않는 것
-- 1. IN
-- 2. OR
-- ex) 아래 쿼리는 인덱스를 사용하지만 성능 향상 목적은 아님.
-- WHY? IN을 사용했기 때문에
SELECT EMPNO, ENAME FROM EMP WHERE SAL IN (1250, 3000);

-- 사거블 쿼리이면서 성능 향상 목적
-- 1. >, <, >=, <=, =
-- 2. BETWEEN
-- 3. LIKE(%를 앞에 붙이지 않는 경우)
-- 4. IS [NOT] NULL

-- ex)아래 쿼리는 사거블 쿼리이면서 성능 향상이 된다.
SELECT EMPNO, ENAME FROM EMP WHERE SAL IS NULL;


SHOW INDEX FROM EMP;

-- 인덱스 삭제, 삭제는 있지만 수정은 없음.
ALTER TABLE EMP DROP INDEX IDX_EMP_HIREDATE;

-- 인덱스를 생성하는 다른 방법
-- 1. CREATE INDEX ~~ (보조 인덱스)
-- 2. PRIMARY KEY (클러스터 인덱스)
-- 3. CREATE TABLE EMP (SAL INT(4) UNIQUE) --> UNIQUE를 뒤에 붙음. (보조 인덱스)

-- 인덱스는 데이터가 많을 때 사용하며, 자주 이용하는 컬럼에 생성해 주면 된다
-- 사거블 쿼리와 논 사거블 쿼리를 주의한다.
-- 데이터가 없을 때 인덱스는 성능 낭비다.


-- 프로시저
-- 프로그래밍에서 함수와 같은 개념, 파리머터와 리턴값이 존재
-- 프로시저는 DB에 저장되어 필요 할 때 호출되어 실행
-- 동일한 로직을 여러 번 사용 할 필요가 있을 때 사용 (재사용성)
-- 네트워크 비용이 감소하고 선능이 향상된다. (프로시저는 메모리에 계속 저장되어 있다)
-- 빈도 수가 적은 SQL문은 굳이 프로시저로 두면 X (대규모 프로젝트 많이 사용함, 은행에서 자정에 점검 때 많이 사용됨)

-- 프로시저 호출하기
-- () 매개변수, 즉 매개변수가 없는 프로시저를 호출함.

CALL study.test_proce(1500);
-- CREATE PROCEDURE study.test_proce(X INTEGER)
-- BEGIN
-- 	SELECT EMPNO, SAL FROM EMP WHERE SAL > X;
-- END

CALL study.test_proce2();
-- CREATE PROCEDURE study.test_proce2()
-- BEGIN
-- 	DECLARE X INT;
-- 	SET X = 10;
-- 	IF X = 10 THEN
-- 		SELECT ENAME, SAL FROM EMP;
-- 	ELSE
-- 		SELECT COUNT(*) FROM EMP;
-- 	END IF;
-- END

CALL study.test_proce3(20);
-- CREATE PROCEDURE study.test_proce3(X INTEGER)
-- BEGIN
-- 	IF X = 20 THEN
-- 		UPDATE EMP SET SAL = SAL*1.3;
-- 	ELSE
-- 		SELECT SAL, EMPNO FROM EMP;
-- 	END IF;
-- END

CALL study.test_proce4();
-- CREATE PROCEDURE study.test_proce4()
-- BEGIN
-- 	DECLARE I INT DEFAULT 0;
-- 	DECLARE RES INT DEFAULT 0;
-- 
-- 	LOOP_TEST:LOOP
-- 		IF(I > 10) THEN
-- 			LEAVE LOOP_TEST;
-- 		END IF;
-- 		SET RES = RES+I;
-- 		SET I = I + 1;
-- 	END LOOP;
-- 
-- 	SELECT RES;
-- END




















