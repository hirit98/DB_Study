-- 1. 사원이름과 사업직책 조회
-- 조회 -> SELECT
-- ENAME -> 사원이름 	/ 	JOB -> 직책
-- 컬럼 == 변수명
SELECT 
	ENAME,
	JOB,
	EMPNO,		-- 추가로 사원번호, 입사날짜 조회
	HIREDATE
FROM emp
-- 부서이름과 부서번호를 조회
SELECT
	DEPTNO,
	DNAME
FROM dept
-- SELECT 다음엔 컬럼이름이 오고, FROM 다음엔 테이블 이름이 온다.

-- Q. 사원번호, 사원이름, 사원 사수번호, 직책을 조회하시오
SELECT  
	EMPNO as "사원번호",
	ENAME as "사원이름",
	MGR as "사수번호",
	JOB as "맡은직책"
FROM EMP
-- AS : 별칭

-- Q1. 사원이름만 조회
SELECT 
	ENAME
FROM emp

-- Q2. 사원번호, 사원이름을 조회, AS 이용해서 풀것
-- AS는 생략 가능
-- 실무에서는 생략하는 곳도 있고, 다 작성하는 곳도 있다.
SELECT 
	empno "사원번호",
	ename as "사원이름"
FROM emp

-- Q3. 사원 테이블에 있는 모든 컬럼 조회
-- *(애스터리스크) 를 사용하면 전체 컬럼을 조회 할 수 있다.
-- 실무에서는 모든 컬럼을 조회할 때 *을 사용하지 않고 모든 컬럼을 적는다.
SELECT *
FROM emp

-- SELECT, FROM, AS
-- WHERE 내가 원하는 데이터를 추출할 때 사용 (조건)
-- ex) 사원이름이 SMITH인 사람의 급여를 알고 싶을 때 : SELECT SAL FROM emp WHERE ENAME = "SMITH"

-- JOB이 'SALESMAN' 인 사원의 이름, 번호, 입사날짜 조회
SELECT 
	ENAME, 
	EMPNO, 
	HIREDATE,
	JOB
FROM emp 
WHERE JOB = "SALESMAN"

-- Q. 사원번호가 7782인 사원의 번호, 이름, 직업 조회
SELECT 
	EMPNO,
	ENAME,
	JOB
FROM EMP
WHERE EMPNO = 7782

-- 급여가 2000 이상 받는 사원이름, 직책 조회
SELECT 
	ENAME,
	JOB,
	SAL
FROM emp
WHERE SAL >= 2000

-- Q. 1981-12-03 이후에 입사한 사원 이름, 직책, 급여, 사수번호, 입사날짜 조회
SELECT 
	ENAME,
	JOB,
	SAL,
	MGR,
	HIREDATE
from EMP
WHERE HIREDATE >= '1981-12-03'

-- JOB이 MANAGER 이고 급여가 2000 이상인 사원의 이름, 직책, 급여, 입사날짜 조회
SELECT 
	ENAME ,
	JOB ,
	SAL ,
	HIREDATE 
FROM EMP
WHERE JOB = 'MANAGER' AND SAL >= 2000

-- Q. 입사날짜가 '1981-12-03' 이고 직업이 ANALYST인 사원의 이름, 직책, 입사날짜, 급여 조회
SELECT 
	ENAME ,
	JOB ,
	HIREDATE ,
	SAL 
FROM EMP
WHERE HIREDATE = '1981-12-03' AND JOB = 'ANALYST'



