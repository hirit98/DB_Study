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

-- Q8. 부서명이 RESEARCH인 사원의 이름, 급여, 근무 지역 조회.
SELECT 
	E.ENAME,
	E.SAL,
	D.LOC
FROM EMP AS E
INNER JOIN DEPT AS D
ON E.DEPTNO = D.DEPTNO
WHERE D.DNAME = 'RESEARCH'

-- Q9. 보너스를 받은 사원 이름, 직책, 급여, 부서명 조회.
SELECT 
	E.ENAME,
	E.JOB,
	E.SAL,
	D.DNAME
FROM EMP AS E
INNER JOIN DEPT AS D
ON E.DEPTNO = D.DEPTNO
WHERE COMM != 0
   
-- Q10. 이름 첫글 A자를 가진 사원 이름, 직책, 부서명, 부서 위치 조회.
SELECT 
	E.ENAME,
	E.JOB,
	D.DNAME,
	D.LOC
FROM EMP AS E
INNER JOIN DEPT AS D
ON E.DEPTNO = D.DEPTNO
WHERE E.ENAME LIKE 'A%'

-- Q11. 사원명, 사수번호, 사수 이름 조회. 단, 사수가 없는 사원도 포함
SELECT 
	BUSASU.ENAME,
	BUSASU.MGR,
	SASU.ENAME
FROM EMP AS BUSASU
LEFT JOIN EMP AS SASU
ON BUSASU.MGR = SASU.EMPNO

-- Q12. 사원명, 사수번호, 사수 이름 조회. 단, 사수가 없는 사원만
SELECT 
	BUSASU.ENAME AS '사원 이름',
	BUSASU.MGR AS '사수 번호',
	SASU.EMPNO AS '사수 이름'
FROM EMP AS BUSASU
LEFT JOIN EMP AS SASU
ON BUSASU.MGR = SASU.EMPNO
WHERE BUSASU.MGR IS NULL

-- Q13. 상사번호가 7698인 사원의 이름, 사원번호, 상사번호, 상사이름 조회.
SELECT 
	BUSASU.ENAME AS '사원 이름',
	BUSASU.EMPNO AS '사원 번호',
	BUSASU.MGR AS '상사 번호',
	SASU.ENAME AS '상사 이름'
FROM EMP AS BUSASU
LEFT JOIN EMP AS SASU
ON BUSASU.MGR = SASU.EMPNO
WHERE BUSASU.MGR = 7698

-- Q14. 상사보다 먼저 입사한 사원의 사원이름, 사원의 입사일, 상사 이름, 상사 입사일 조회.
SELECT 
	BUSASU.ENAME AS '사원 이름',
	BUSASU.HIREDATE AS '입사일',
	SASU.ENAME AS '상사 이름',
	SASU.HIREDATE AS '입사일'
FROM EMP AS BUSASU
LEFT JOIN EMP AS SASU
ON BUSASU.MGR = SASU.EMPNO
WHERE BUSASU.HIREDATE < SASU.HIREDATE

-- Q15. 업무가 MANAGER이거나 CLERK고 입사날짜가 1982년에 입사한 사원의 사원번호, 이름, 급여, 직업, 부서명 조회.
SELECT 
	E.EMPNO,
	E.ENAME,
	E.SAL,
	E.JOB,
	D.DNAME
FROM EMP AS E
INNER JOIN DEPT AS D
ON E.DEPTNO = D.DEPTNO
WHERE (E.JOB = 'MANAGER' OR E.JOB = 'CLERK') AND DATE_FORMAT(HIREDATE, '%Y') = '1982'

-- Q16. 부서별 급여 총합 조회. 단, 사원이 존재하지 않는 부서도 포함해서 급여 순으로 내림차순 하시오.
SELECT
	D.DNAME,
	SUM(E.SAL)
FROM EMP AS E
RIGHT JOIN DEPT AS D
ON E.DEPTNO = D.DEPTNO
GROUP BY D.DEPTNO
ORDER BY 2 DESC

-- Q17. 사원 이름, 상사 이름, 사원 부서번호, 사원 부서명, 사원 근무지역 조회. 단, 사원이 존재하지 않는 부서번호와 부서명도 조회.
SELECT 
	E.ENAME,
	E.MGR,
	E.DEPTNO,
	D.DNAME,
	D.LOC
FROM EMP AS E
RIGHT JOIN DEPT AS D
ON E.DEPTNO = D.DEPTNO

-- Q18. 부서 위치가 CHICAGO이고 사수 급여가 5000 미만인 사원 번호,사원 이름,사수 번호, 사수 이름, 사수 급여, 부서명 조회.
-- 단, 사원의 입사날짜로 오름차순.
SELECT 
	E.EMPNO,
	E.ENAME,
	E.MGR,
	SASU.EMPNO,
	SASU.ENAME,
	SASU.SAL,
	D.DNAME
FROM EMP AS E
JOIN EMP AS SASU ON E.MGR = SASU.EMPNO
JOIN DEPT AS D ON E.DEPTNO = D.DEPTNO
WHERE D.LOC = 'CHICAGO' AND SASU.SAL < 5000
ORDER BY E.HIREDATE ASC


-- Q19. 입사날짜를 월별로 몇명이 입사했는지 카운트해서 조회.
SELECT 
	DATE_FORMAT(HIREDATE, '%m') AS Month,
	COUNT(*)
FROM EMP
GROUP BY DATE_FORMAT(HIREDATE,'%m')

-- Q20. 부서번호, 부서이름, 부서 근무지, 사원 수 조회 단, 사원이 없는 부서도 조회할 수 있게
SELECT 
	D.DEPTNO,
	D.DNAME,
	D.LOC,
	COUNT(*)
FROM EMP AS E
RIGHT JOIN DEPT AS D
ON E.DEPTNO = D.DEPTNO
GROUP BY D.DEPTNO

-- Q21. 9월에 입사한 사원의 이름, 번호, 입사날짜 조회.
SELECT 
	ENAME,
	EMPNO,
	HIREDATE
FROM EMP
WHERE DATE_FORMAT(HIREDATE,'%m') = 9

-- Q22. 직업이 SALESMAN 이고 입사날짜가 1981-02-22 이후에 들어온 사원들의 급여 총합, 급여평균 조회.
SELECT 
	SUM(SAL) AS '급여 총합',
	AVG(SAL) AS '급여 평균'
FROM EMP
WHERE JOB = 'SALESMAN' AND DATE_FORMAT(HIREDATE,'%Y-%m-%d') >= 1981-02-22

-- Q26. 사원수가 4명 이상인 부서의 번호, 사원 수, 부서 이름, 부서 위치 조회
SELECT 
	D.DEPTNO,
	COUNT(*) AS '사원 수',
	D.DNAME,
	D.LOC
FROM EMP AS E
RIGHT JOIN DEPT AS D
ON E.DEPTNO = D.DEPTNO
GROUP BY D.DEPTNO
HAVING COUNT(*) >= 4

-- 1. 사원번호가 7369인 사원의 급여를 기존 급여에 20%를 인상하시오. (update 이용)
UPDATE EMP SET SAL = SAL*0.2 WHERE EMPNO = 7369

-- 2. 사원번호가 7839, 7499인 사원의 보너스를 200씩 지급하시오. (update 이용)
UPDATE EMP SET COMM = COMM + 200 WHERE EMPNO = 7839 OR EMPNO = 7499

-- 3. 사원번호 5000, 사원이름 현상원, 직업 MANAGER, 입사날짜 오늘날짜로 사원을 추가하시오. (insert 이용)
INSERT INTO EMP (EMPNO, ENAME, JOB, HIREDATE) VALUES (5000, '현상원', 'MANAGER', NOW())

-- 4. 사원번호 5001, 사원이름 아이유, 직업 ANALYST, 입사날짜 오늘날짜로 사원을 추가하시오. (insert 이용)
INSERT INTO EMP (EMPNO, ENAME, JOB, HIREDATE) VALUES (5001, '아이유', 'ANALYST', NOW())

-- 5. 사원이름이 아이유인 사원의 급여 3000, 보너스 100을 지급하시오. (update 이용)
UPDATE EMP SET SAL = 3000, COMM = 100 WHERE ENAME = '아이유'

-- 6. 사원이름이 현상원이고 직업이 MANAGER 사원의 사수번호를 7839로 수정하시오. (update 이용)
UPDATE EMP SET MGR = 7839, JOB = 'MANAGER' WHERE ENAME = '현상원'

-- 7. 사원번호 5000, 5001인 사원을 삭제하시오. (delete 이용)





