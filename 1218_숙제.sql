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
DELETE FROM EMP WHERE EMPNO = 5000 OR EMPNO = 5001

-- 8. 다음 중 데이터베이스 시스템 언어의 종류와 해당하는 명령어를 바르게 연결한 것을 2개 고르시오.
    1. DML - SELECT
    2. TCL - COMMIT
    
-- 9. 다음 중 NULL의 설명으로 가장 부적절한 것은?
    3. 공백 문자(Empty String) 혹은 숫자 0을 의미한다.
    
-- 10. 서브쿼리가 가능하지 않는 곳은?
    4. GROUP BY