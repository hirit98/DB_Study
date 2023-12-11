-- 12월 11일
-- 관계 연산자 : >=, <=, >, <, =, != ...
-- 논리 연산자 : AND, OR, ISNULL, NOT, LIKE, IN, BETWEEN ...

-- LIKE : 특정 단어를 검색 할 때 사용
-- EX) 사원 이름에 a가 한번이라도 들어간 사원이름, 번호 조회
SELECT ENAME, EMPNO FROM EMP WHERE ENAME LIKE '%A%'

-- EX) A로 시작하는 사원이름, 번호 조회
SELECT ENAME, EMPNO FROM EMP WHERE ENAME LIKE 'A%'

-- EX) A로 끝나는 사원이름, 번호 조회
SELECT ENAME, EMPNO FROM EMP WHERE ENAME LIKE '%A'

-- 세번째 문자에 'R'이 들어간 사원이름, 번호 조회
SELECT ENAME, EMPNO FROM EMP WHERE ENAME LIKE '__R%'
-- LIKE 실무에서 많이 사용 SELECT A FROM COUPANG WHERE SEARCH LIKE '후%'

-- IN
-- 부서번호가 10, 20인 사원이름, 부서번호, 조회
SELECT ENAME, DEPTNO FROM EMP WHERE DEPTNO = 10 OR DEPTNO = 20

SELECT ENAME, DEPTNO FROM EMP WHERE DEPTNO IN (10,20)

-- DISTINCT : 중복 제거
SELECT DISTINCT JOB FROM EMP

-- GROUP BY
-- GROUP BY : 특정 컬럼을 그룹화 할 때 사용
-- EMP 테이블에서 그룹이 가능한 컬럼은 : JOB, SAL, DEPTNO, HIREDATE

-- 직책별 GROUP BY
SELECT JOB FROM EMP GROUP BY JOB
-- 집계함수 SUM, AVG, MAX, MIN, COUNT 와 같이 많이 사용

-- 직책별 사원 수 조회
SELECT JOB, COUNT(*) AS '사원 수' FROM EMP GROUP BY JOB

-- 부서 별 급여가 가장 높은 사람 조회
SELECT DEPTNO, MAX(SAL) FROM EMP GROUP BY DEPTNO

-- 부서번호로 그룹핑하고 부서 별 평균 급여 조회
SELECT DEPTNO, AVG(SAL) FROM EMP GROUP BY DEPTNO

-- 직책 별로 그룹핑하고, 그룹핑된 직책 중 SAL이 5000 넘는 사원 직책, 총합급여 조회
-- WHERE에는 집계함수를 사용 할 수 없다. -> HAVING 사용
-- HAVING은 GROUP BY 뒤에 오고, 그룹화 된 결과 집합에서 조건을 걸 때 사용한다.
SELECT JOB, SUM(SAL) FROM EMP GROUP BY JOB HAVING SUM(SAL) >= 5000

-- 직업이 매니저이고, 직책별로 그룹핑 후 그룹핑 된 결과 평균 급여가 200 이상인 사원직책, 평균 급여 조회
SELECT JOB, AVG(SAL) FROM EMP WHERE JOB = 'MANAGER' GROUP BY JOB HAVING AVG(SAL) >= 200

-- SQL 실행 순서 최종 정리
-- 1. FROM 2. WHERE 3. GROUP BY 4. HAVING 5. SELECT 6. ORDER BY
-- SELECT - FROM - WHERE - GROUP BY - HAVING - ORDER BY 순으로 SELECT문 작성

-- WHERE 과 HAVING 의 차이점
-- 1. WHERE에는 SUM, MAX, MIN, COUNT, AVG 집계함수 사용불가
-- 2. HAVING은 GROUP BY 뒤에 오고, WHERE은 FROM 뒤에 온다.
-- 3. *WHERE은 특정 조건을 만족하는 행을 필터링 할 때, HAVING은 그룹화 된 결과에 조건을 적용할 때
-- 4. *시간적 순서도 다르다. WHERE은 행을 필터링 하기 전 실행, HAVING은 그룹핑 후 실행
-- 5. HAVING을 WHERE처럼 사용 할 수 있음
SELECT ENAME, SAL FROM EMP HAVING SAL > 2000
-- WHERE과 HAVING 목적이 다르기에 그룹화 된 결과를 필터링 할 때만 HAVING을 쓰자.
-- ** GROUP BY는 그룹핑 뿐만아니라 정렬작업도 같이 이루어지기 때문에 데이터가 많을 땐 신중하게 사용!
-- DISTINCT와 GROUP BY 차이는 정렬작업이 이루어지냐 아니냐 차이
-- 

-- 1. 사원이름에 A가 들어간 모든 사원 번호, 이름, 직업 조회.
SELECT EMPNO, ENAME, JOB FROM EMP WHERE ENAME LIKE '%A%'

-- 2. 부서번호별 최대급여, 최소급여, 인원수, 부서번호 조회.
SELECT MAX(SAL), MIN(SAL), COUNT(*), DEPTNO FROM EMP GROUP BY DEPTNO

-- 3. 직책별 직책수, 직책 조회 단, 직책에 인원 수가 2명 이상
SELECT COUNT(*), JOB FROM EMP GROUP BY JOB HAVING COUNT(*) >=2

-- 4. 직책별 평균급여와 직책 조회 단, MANAGER는 제외.
SELECT AVG(SAL), JOB FROM EMP WHERE JOB != 'MANAGER' GROUP BY JOB

-- 5. 부서번호별 급여합계, 부서번호 조회 단, 10번 부서만.
SELECT SUM(SAL), DEPTNO FROM EMP WHERE DEPTNO = 10 GROUP BY DEPTNO

-- 6. 부서번호별 급여합계, 부서번호 조회 단, 급여합계가 5000 이상인 부서만.
SELECT SUM(SAL), DEPTNO FROM EMP GROUP BY DEPTNO HAVING SUM(SAL) >= 5000

-- 7. 입사년도별 입사한 사원 수와 입사날짜 조회 단, 2월에서 6월사이 입사한 사원만.
SELECT COUNT(*), HIREDATE FROM EMP WHERE DATE_FORMAT(HIREDATE, '%m') BETWEEN 2 AND 6 GROUP BY HIREDATE

-- 8. 부서별 직책별 최대급여와 인원수, 최소급여 조회 단, 10번 부서제외하고, 인원수는 3명 이하, 인원수가 적은 순서대로 정렬하시오. 
SELECT MAX(SAL), COUNT(*), MIN(SAL) FROM EMP WHERE DEPTNO != 10 GROUP BY DEPTNO, JOB HAVING COUNT(*) <= 3 ORDER BY 2 ASC

-- 9. SQL 실행순서로 올바른 것은?
   2) FROM - WHERE - GROUP BY - HAVING - SELECT - ORDER BY

-- 10. 다음 보기 중 세번째 문자가 'N'인 문자열을 검색하는 조건으로 적절한 것은?
   4) SELECT*FROM 테이블명 WHERE like '__N%';
   
  
  







