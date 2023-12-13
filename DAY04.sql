-- GROUP BY, HAVING
-- GROUP BY : 컬럼 그룹핑 할 때
-- HAVING : 그룹핑 한 결과를 필터링 할 때

SELECT SUM(SAL) AS '부서 별 급여 합', DEPTNO FROM EMP GROUP BY DEPTNO HAVING SUM(SAL) >= 9000

-- *** 쿼리 실행 순서 (실무 혹은 SQL 시험에서 아래 순서에 맞게 쿼리 해석)
-- 1. FROM 2. WHERE 3. GROUP BY 4. HAVING 5. SELECT 6. ORDER BY

-- 12월 13일
-- ROUND, TRUNCATE
-- ROUND : 반올림
-- TRUNCATE : 특정 자릿수 버림
-- DUAL : 가상 테이블(연습용)
SELECT ROUND(500.5) FROM DUAL
-- 특정 자릿수 반올림도 가능
SELECT ROUND(500.56789, 4) FROM DUAL

-- 특정 자릿수 이하를 버림
SELECT TRUNCATE(1234.56789, 1) FROM DUAL

-- 실무에서 ROUND, TRUNCATE는 자주 사용하지 않는다.

-- IF
-- 만약 SAL이 3000 이하면 A를 출력하고 초과면 B를 출력한다
SELECT IF(SAL < 3000, 'A', 'B'), SAL FROM EMP

-- SWITCH CASE
SELECT CASE WHEN(SAL BETWEEN 1000 AND 2000) THEN 'A' WHEN (SAL BETWEEN 3000 AND 5000) THEN 'B' ELSE 'C' END, SAL FROM EMP

-- IF, SWITCH문 실무에서 자주 사용하지 않는다.

-- ***현재 시각 출력하기
SELECT DATE_FORMAT(NOW(), '%Y-%m-%d') AS '오늘 날짜는?' FROM DUAL

-- JOIN이란 N개의 테이블을 서로 묶어서 하나의 결과를 만들어 내는 것을 의미.
-- 즉, DEPT(부서테이블), EMP(사원테이블)을 묶어서 결과를 조회하고 싶을 때 JOIN을 사용
-- 테이블을 한개로 관리하면 컬럼 수가 늘어나고 이는 데이터베이스 성능저하로 이어짐.
-- 실무에선 여러 테이블을 나누어 관리하며, JOIN을 이용해 테이블을 묶어 사용한다.
-- 이는 *****관계형 데이터베이스(RDBMS)에 큰 특징 중 하나
-- 번외) JOIN이 있으면 관계형 데이터베이스는 JOIN이 없으면 NOSQL(MongoDB, DynamoDB)
-- JOIN을 하려면 교집합 컬럼을 찾아야 함.

-- 부서 테이블에서 부서번호 조회
SELECT DEPTNO FROM DEPT

-- 사원 테이블에서 부서번호 조회
SELECT DEPTNO FROM EMP 

-- 사원들 부서이름과 근무지 조회
-- 부서이름과 근무지는 DEPT 테이블에 존재
-- DEPTNO를 이용해서 테이블을 묶는다.
SELECT 
	E.ENAME AS '사원이름',
	E.JOB AS '사원직책',
	D.DNAME AS '부서이름',
	D.LOC AS '근무지',
	E.DEPTNO AS '부서번호'
FROM EMP AS E INNER JOIN DEPT AS D 
ON E.DEPTNO = D.DEPTNO

-- 교집합 컬럼(DEPTNO)은 이름만 같다고 JOIN이 되는게 아닌, 데이터타입이 같아야 한다.
-- EMP에 있는 DEPTNO와 DEPT에 있는 DEPTNO는 데이터타입이 같다.

-- Q1. 부서번호가 10번인 사원들의 이름, 입사날짜, 부서이름 조회
SELECT E.ENAME, E.HIREDATE, D.DNAME FROM EMP AS E INNER JOIN DEPT AS D ON E.DEPTNO = D.DEPTNO WHERE E.DEPTNO = 10

-- Q2. JOB이 MANAGER인 사원의 번호, 근무지 조회
SELECT E.EMPNO, D.LOC FROM EMP AS E INNER JOIN DEPT AS D ON E.DEPTNO = D.DEPTNO WHERE E.JOB = 'MANAGER'

-- Q3. 급여가 2000이상인 사원의 번호, 이름, 부서번호, 부서이름, 근무지 조회
SELECT E.EMPNO, E.ENAME, E.DEPTNO, D.DNAME, D.LOC FROM EMP AS E INNER JOIN DEPT AS D ON E.DEPTNO = D.DEPTNO WHERE E.SAL >= 2000

-- INNER JOIN (내부조인, 실무에선 조인이라고 함)
-- SELF JOIN
-- EMP 테이블에 사수번호 MGR와 사원번호는 교집함

-- FROM 먼저 실행하기 때문에 SELECT절에서 FROM절에 사용한 별칭을 사용 할 수 있다.
SELECT
	BUSASU.EMPNO AS '부사수 사원번호',
	BUSASU.ENAME AS '부사수 이름',
	SASU.EMPNO AS '사수 사원번호',
	SASU.ENAME AS '사수 이름'
FROM EMP AS BUSASU INNER JOIN EMP AS SASU ON BUSASU.MGR = SASU.EMPNO

-- Q1. 사원 보너스가 NULL이 아닌 사원이름, 사원의 사수이름 조회
SELECT 
	BUSASU.ENAME, 
	SASU.ENAME 
FROM EMP AS BUSASU 
INNER JOIN EMP AS SASU 
ON BUSASU.MGR = SASU.EMPNO 
WHERE BUSASU.COMM IS NOT NULL

-- Q2. 부서번호(부사수)가 20번인 사원의 사원번호, 사원이름, 사수이름 조회
SELECT
	BUSASU.EMPNO, 
	BUSASU.ENAME, 
	SASU.ENAME 
FROM EMP AS BUSASU 
INNER JOIN EMP AS SASU 
ON BUSASU.MGR = SASU.EMPNO 
WHERE BUSASU.DEPTNO = 20

-- *****여러 JOIN 사용하기
-- 부사수 이름, 부서번호, 부서이름, 사수이름 조회
-- JOIN을 총 2번 사용함.
SELECT
	BUSASU.ENAME AS '부사수 이름',
	BUSASU.DEPTNO AS '부사수 부서번호',
	D.DNAME AS '부사수 부서 이름',
	SASU.ENAME AS '사수 이름'
FROM EMP AS BUSASU
INNER JOIN DEPT AS D
ON BUSASU.DEPTNO = D.DEPTNO
INNER JOIN EMP AS SASU
ON BUSASU.MGR = SASU.EMPNO

-- INNER JOIN(여러 테아블 조인), SELF JOIN(한 테이블에서 조인)

-- ***** 실무에서 상당히 많이 사용하는 조인
-- RIGHT JOIN, LEFT JOIN => 둘을 아우터 조인이라고 함
-- 대형 SI 프로젝트에서 외부조인(아우터조인)을 '매우' 많이 사용함

SELECT 
	컬럼이름 
FROM 테이블 AS 별칭
RIGHT JOIN 테이블 AS 별칭
ON 별칭.컬럼 = 별칭.컬럼

SELECT 
	컬럼이름 
FROM 테이블 AS 별칭
LEFT JOIN 테이블 AS 별칭
ON 별칭.컬럼 = 별칭.컬럼

-- 언제 사용하는지
SELECT DEPTNO FROM DEPT
-- DISTINCT : 중복제거
-- GROUP BY 컬름 그룹핑(중복 제거)
-- 차이점 - GROUP BY는 그룹핑 후 정렬함, DISTINCT는 중복제거만 함
SELECT DISTINCT DEPTNO FROM EMP


-- 요구사항 => EMP와 DEPTNO 조인 할 때 40번 부서도 이름과 위치를 알고싶다
-- 이럴 때 아우터 조인을 사용함
-- *****************원하는 데이터가 들어있는 테이블이 'JOIN' 기준으로 어느쪽에 있냐에 RIGHT, LEFT 사용한다
SELECT
	E.ENAME AS '사원 이름',
	D.DNAME AS '부서 이름',
	D.DEPTNO AS '부서 번호'
FROM EMP AS E RIGHT JOIN DEPT AS D -- 40번 부서는 DEPT 테이블에 있고 JOIN 기준으로 오른쪽에 있기 때문에 RIGHT JOIN을 사용.
ON E.DEPTNO = D.DEPTNO

-- Q. 위 JOIN 상태에서 해당 부서에 사원이 없는 부서 이름, 부서 번호 조회
SELECT
	E.ENAME AS '사원 이름',
	D.DNAME AS '부서 이름',
	D.DEPTNO AS '부서 번호'
FROM EMP AS E RIGHT JOIN DEPT AS D 
ON E.DEPTNO = D.DEPTNO
WHERE E.ENAME IS NULL

-- Q1. 사원이름, 사원직책, 사원급여 조회.
SELECT ENAME, JOB, SAL FROM EMP

-- Q2. 사수번호가 7839인 사원 번호, 이름, 입사날짜 조회.
SELECT EMPNO, ENAME, HIREDATE FROM EMP WHERE MGR = 7839

-- Q3. 급여가 3000 이하인 사원의 모든 정보 조회.
SELECT * FROM EMP WHERE SAL <= 3000

-- Q4. 사원이름, 부서번호, 부서이름, 부서 근무지 조회.
SELECT 
	E.ENAME,
	E.DEPTNO,
	D.DNAME,
	D.LOC
FROM EMP AS E
INNER JOIN DEPT AS D
ON E.DEPTNO = D.DEPTNO

-- Q5. 부서별 급여합계, 부서이름 조회.
SELECT SUM(E.SAL), D.DNAME FROM EMP AS E INNER JOIN DEPT AS D ON E.DEPTNO = D.DEPTNO GROUP BY E.DEPTNO

-- Q6. 부서 근무지가 NEW YORK이고, 직책이 MANAGER인 사원의 이름, 급여 조회.
SELECT
	E.ENAME,
	E.SAL
FROM EMP AS E
INNER JOIN DEPT AS D
ON E.DEPTNO = D.DEPTNO
WHERE D.LOC = 'NEW YORK' AND E.JOB = 'MANAGER'

-- Q7. 1983년 이후 입사한 사원의 보너스가 null이면 100 주고, 사원의 이름, 부서이름, 직업 조회.
SELECT
	E.COMM,
	E.ENAME,
	D.DNAME,
	E.JOB
FROM EMP AS E
INNER JOIN DEPT AS D
ON E.DEPTNO = D.DEPTNO
WHERE DATE_FORMAT(E.HIREDATE, '%Y') >= 1983








