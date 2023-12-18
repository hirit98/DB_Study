-- 부서번호가 20번인 사원의 이름, 직책, 입사날짜, 부서이름, 부서위치
SELECT
	E.ENAME,
	E.JOB,
	E.HIREDATE,
	D.DNAME,
	D.LOC
FROM EMP AS E
INNER JOIN DEPT AS D
ON E.DEPTNO = D.DEPTNO
WHERE E.DEPTNO = 20

-- JOIN은 FROM절로 간주
-- SELF JOIN
-- SELF JOIN 하나의 테이블에서 JOIN
-- EMP에 MGR 번호는 사수의 사원번호임
-- MGR과 EMPNO를 이용해서 사원의 사수이름을 출력해본다
SELECT
	BUSASU.ENAME AS '부사수 이름',
	BUSASU.EMPNO AS '부사수 사원번호',
	SASU.ENAME AS '사수 이름',
	SASU.EMPNO AS '사수 사원번호'
FROM EMP AS SASU
INNER JOIN EMP AS BUSASU
ON SASU.EMPNO = BUSASU.MGR

-- OUTTER JOIN (LEFT, RIGHT)
-- 대형 프로젝트에서 OUTER JOIN을 정말 많이 사용함
-- 사원이 없는 부서번호와 부서이름, 근무지 출력
SELECT
	D.DEPTNO ,
	D.DNAME,
	D.LOC
FROM EMP AS E
RIGHT JOIN DEPT AS D
ON E.DEPTNO = D.DEPTNO
WHERE E.EMPNO IS NULL

-- 실무에서 NULL 값을 따로 SELECT 하진 않는다

-- Q. 직책이 'MANAGER'인 사원의 번호와 이름, 부서위치를 출력하시오. 단, 사원이 없는 부서까지 조회하시오
SELECT 
	E.EMPNO,
	E.ENAME,
	D.LOC
FROM EMP AS E
RIGHT JOIN DEPT AS D
ON E.DEPTNO = D.DEPTNO 
WHERE E.JOB = 'MANAGER' OR E.EMPNO IS NULL

-- 서브쿼리
-- 하나의 쿼리 문장 내에 포함 된 또 하나의 쿼리 문장
-- 서브쿼리는 ()를 묶어서 실행한다.
-- 서브쿼리가 먼저 실행 된 후, 외부 쿼리와 비교/연산 된다.
-- 서브쿼리가 가능한 곳
-- SELECT, FROM, WHERE, HAVING, ORDER BY, INSERT, UPDATE
-- SELECT와 FROM, WHERE 절에 서브쿼리를 종종 사용하며, 특히 *******FROM절에서 서브쿼리를 많이 사용한다.
-- 서브쿼리는
-- 1. 데이터를 필터링 할 때
-- 2. 통계 데이터를 추출 할 때

-- SELECT 서브쿼리 (스칼라 서브쿼리)
-- EX)
SELECT 
	(SELECT COUNT(*) FROM EMP) AS '사원 수',
	(SELECT SUM(SAL) FROM EMP) AS '사원 총 급여'
FROM EMP

-- FROM 서브쿼리 (인라인 뷰)
-- EX) FROM절에 서브쿼리 이용
-- SQL 실행 순서
-- 서브쿼리 안의 (FROM) -> (WHERE) -> (SELECT) -> 외부 쿼리 FROM -> WHERE -> ...
SELECT
	*
FROM EMP AS E INNER JOIN
(SELECT EMPNO FROM EMP WHERE JOB = 'MANAGER') AS MANAGER_EMP
ON E.EMPNO = MANAGER_EMP.EMPNO

-- WHERE 서브쿼리 (중첩 서브쿼리)
-- Q. 급여를 가장 많이 받는 사원의 이름과 급여 조회
SELECT 
	ENAME,
	SAL
FROM EMP
WHERE SAL = (SELECT MAX(SAL) FROM EMP)

-- WHERE절에 서브쿼리 결과가 여러 행일 때는 '='가 아니라 'IN'을 사용해야한다.
-- EXISTS, NOT EXISTS
SELECT ENAME, SAL FROM EMP
WHERE SAL IN (SELECT SAL FROM EMP WHERE SAL > 2000)


-- INSERT, DELETEM, UPDATE, SELECT
-- 신입 개발자는 INSERT(Create), SELECT(Read), UPDATE(Update), DELETE(Delete)만 잘 하면 됨.
-- 'CRUD'(실무 용어) =  DML(학문적 용어)

-- 사원번호, 사원이름 추가
INSERT INTO EMP (EMPNO, ENAME) VALUES (8000, '황정민')
INSERT INTO EMP (EMPNO, ENAME) VALUES (8001, '정우성')

-- 황정민, 정우성 입사날짜와 급여 UPDATE하기
UPDATE EMP
SET SAL = 3000,
	HIREDATE = NOW()
WHERE EMPNO = 8000

UPDATE EMP
SET SAL = 4000,
	HIREDATE = NOW()
WHERE EMPNO = 8001
-- UPDATE할 때 WHERE을 사용하지 않으면 전체 행이 수정된다.

-- 삭제
-- 황정민 데이터 삭제
DELETE FROM EMP WHERE EMPNO = 8000

-- DELETE 또한 WHERE을 사용하지 않으면 전체 행이 삭제된다.

DELETE FROM EMP
-- 전체 행을 삭제 할 때는 DELETE를 사용하는게 아니라,
-- TRUNCATE를 이용해서 삭제한다.
-- EMP테이블에 들어있는 모든 데이터 삭제.
TRUNCATE TABLE EMP
-- TRUNCATE와 DELETE 성능 차이
-- DELETE는 한 줄 한줄 지운다.
-- TRUNCATE는 통으로 지운다.
-- ***** UPDATE : 데이터베이스(MYSQL, ORACLE)에서 UPDATE란 존재하지 않는다.
-- 실제 데이터베이스는 UPDATE문을 UPDATE하는게 아니라 DELETE 후 INSERT 하는 것


