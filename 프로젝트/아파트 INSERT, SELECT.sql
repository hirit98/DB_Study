INSERT INTO APT_MANGEMENT (APT_BRAND, APT_COMPLEX, APT_ALL) VALUES ('주공', 1, 8);
INSERT INTO APT_MANGEMENT (APT_BRAND, APT_COMPLEX, APT_ALL) VALUES ('주공', 2, 9);
INSERT INTO APT_MANGEMENT (APT_BRAND, APT_COMPLEX, APT_ALL) VALUES ('롯데캐슬', 1, 5);
INSERT INTO APT_MANGEMENT (APT_BRAND, APT_COMPLEX, APT_ALL) VALUES ('롯데캐슬', 2, 3);
INSERT INTO APT_MANGEMENT (APT_BRAND, APT_COMPLEX, APT_ALL) VALUES ('푸르지오', 2, 10);

INSERT INTO HOUES_REGIST (APT_OWNER, PHONE, APT_CD, APT_DONG, APT_HOSU, REGIST_DATE) VALUES ('홍길동', '010-1111-2222', 1, 101, 303, '2022-05-22');
INSERT INTO HOUES_REGIST (APT_OWNER, PHONE, APT_CD, APT_DONG, APT_HOSU, REGIST_DATE) VALUES ('김철수', '010-1234-1234', 1, 109, 201, '2022-06-30');
INSERT INTO HOUES_REGIST (APT_OWNER, PHONE, APT_CD, APT_DONG, APT_HOSU, REGIST_DATE) VALUES ('박영희', '010-5678-5678', 2, 203, 1001, '2022-10-12');
INSERT INTO HOUES_REGIST (APT_OWNER, PHONE, APT_CD, APT_DONG, APT_HOSU, REGIST_DATE) VALUES ('강진영', '010-1234-5678', 2, 202, 902, '2022-12-05');
INSERT INTO HOUES_REGIST (APT_OWNER, PHONE, APT_CD, APT_DONG, APT_HOSU, REGIST_DATE) VALUES ('박지철', '010-5555-7777', 5, 107, 204, '2023-02-02');

INSERT INTO CAR_REGIST (CAR_NO, CAR_TYPE, MAKER, COLOR, CAR_REGIST_DATE) VALUES ('03차1111', 'SUV', '현대', 'BLACK', '2022-05-22');
INSERT INTO CAR_REGIST (CAR_NO, CAR_TYPE, MAKER, COLOR, CAR_REGIST_DATE) VALUES ('29부2222', '승합차', '기아', 'WHITE', '2022-06-30');
INSERT INTO CAR_REGIST (CAR_NO, CAR_TYPE, MAKER, COLOR, CAR_REGIST_DATE) VALUES ('11바3333', '승용차', '르노삼성', 'BLUE', '2022-12-05');
INSERT INTO CAR_REGIST (CAR_NO, CAR_TYPE, MAKER, COLOR, CAR_REGIST_DATE) VALUES ('80허4444', '세단', 'BMW', 'BLACK', '2022-12-05');

INSERT INTO CAR_REPORT (CAR_NO, RG_NO, OWNER, REPORT_DATE) VALUES ('03차1111', 1, '홍길동', '2022-05-22');
INSERT INTO CAR_REPORT (CAR_NO, RG_NO, OWNER, REPORT_DATE) VALUES ('29부2222', 2, '김철수', '2022-06-30');
INSERT INTO CAR_REPORT (CAR_NO, RG_NO, OWNER, REPORT_DATE) VALUES ('80허4444', 5, '박지철', '2023-02-02');

INSERT INTO APT_ACCESS (ACCESS_DATE, CAR_NO, ACCESS_TYPE) VALUES ('2023-10-02 12:05:12', '03차1111', '입');
INSERT INTO APT_ACCESS (ACCESS_DATE, CAR_NO, ACCESS_TYPE) VALUES ('2023-10-02 12:07:33', '29부2222', '출');
INSERT INTO APT_ACCESS (ACCESS_DATE, CAR_NO, ACCESS_TYPE) VALUES ('2023-10-03 15:57:13', '29부2222', '입');


SELECT
	APT_MG.APT_BRAND AS '아파트 브랜드',
	COUNT(HOUES.APT_CD) AS '브랜드 별 등록 수'
FROM APT_MANGEMENT AS APT_MG
LEFT JOIN HOUES_REGIST AS HOUES
ON APT_MG.APT_CD = HOUES.APT_CD
GROUP BY APT_MG.APT_CD
ORDER BY 2 DESC;


SELECT
	DISTINCT AA.CAR_NO AS '차 번호',
	CR.OWNER AS '소유주'
FROM CAR_REPORT AS CR
INNER JOIN APT_ACCESS AS AA
ON CR.CAR_NO = AA.CAR_NO 
WHERE AA.CAR_NO IN (SELECT CAR_NO FROM APT_ACCESS AA WHERE ACCESS_TYPE = '입')
ORDER BY 2 ASC;




