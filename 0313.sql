-- db 생성
CREATE DATABASE ksmart51db DEFAULT CHARACTER SET UTF8;

-- id 생성
CREATE USER 'ksmart51id'@'%'IDENTIFIED BY 'ksmart51pw';

-- 권한부여
GRANT ALL PRIVILEGES ON kmart51db.* TO 'ksmart51id'@'%';

-- MySQL의 캐시를 지우고 새로운 설정
FLUSH PRIVILEGES;

-- 테이블생성
CREATE TABLE tb_user (
	u_id VARCHAR(100) NOT NULL PRIMARY KEY COMMENT '아이디',
	u_pw VARCHAR(100) NOT NULL COMMENT '비밀번호',
	u_name VARCHAR(100) NOT NULL COMMENT '이름',
	u_birth DATE COMMENT '생년월일',
	u_addr VARCHAR(100) NOT NULL COMMENT '주소',
	u_mob1 VARCHAR(100) NOT NULL COMMENT '휴대폰',
	u_mob2 VARCHAR(100) NOT NULL COMMENT '집전화',
	u_date DATE COMMENT '등록일자'
);

-- 컬럼 이름 변경
ALTER TABLE tb_member CHANGE COLUMN u_mob2 u_reg_date2 DATE;

-- 컬럼 순서 변경
ALTER TABLE tb_user MODIFY u_mob1 VARCHAR(100) AFTER u_mob2;

-- 컬럼 데이터 타입변경
ALTER TABLE tb_user MODIFY u_name CHAR(50);

-- 새 컬럼 추가
ALTER TABLE tb_user ADD COLUMN u_gender CHAR(10) AFTER u_birth; 

-- 컬럼 삭제
ALTER TABLE tb_member DROP COLUMN u_mob1; 

-- 테이블 이름변경
ALTER TABLE tb_user RENAME TO tb_member;

-- 데이터베이스 삭제
DROP DATABASE 이름;

-- 테이블 삭제
DROP table 이름;
TRUNCATE TABLE 이름;
 
-- 존재 시  삭제
DROP TABLE if EXISTS 이름;

-- 데이터추가
INSERT INTO tb_member
	(u_id, u_pw, u_name, u_birth, u_addr, u_mob2, u_mob1, u_reg_date2)
	VALUES 
		('VAL12', 'qwerert', '조광철', '24.03.23', '관악구', '2811', '4222', NOW());

-- 데이터수정
UPDATE tb_member
SET
	u_birth = '88/12/24'
WHERE
	u_addr = '강남구';

-- 데이터삭제
DELETE 
FROM
	tb_member
WHERE
	u_id = 'VAL11';

-- 테이블복제
CREATE TABLE tb_member_bkup2 (
	SELECT
		*
	from
		tb_member
);

-- 데이터 선택
SELECT
	u_id,
	u_name,
	u_addr
FROM
	tb_member
WHERE
	u_id = 'aa445';



SELECT 
	m.u_id AS '아이디',
	m.u_name AS '이름'
FROM
	tb_member AS m;



-- 참거짓 표현
SELECT FALSE;
SELECT TRUE;

-- city 테이블 모든 데이터 조회
SELECT
	* 
FROM
	city;

-- city 테이블 모든 도시이름 조회
SELECT
	NAME
FROM
	city;


-- 국가코드 USA도시 이름과 인구수 조회
SELECT
	NAME,
	Population
FROM
	city
WHERE
	CountryCode = 'USA';

-- 도시 seoul 조회, '한국의 수도' 이름으로 조회
SELECT
	c.Name AS '한국의 수도'
from
	city AS c
WHERE 
	NAME = 'seoul';


-- city 에서 인구수 500만 이상인 도시의 이름 지역 인구 조회
SELECT
	NAME,
	District,
	CountryCode,
	population
FROM
	city
WHERE
	population > 5000000;




-- 인구수 200만 이상이고 한국에 속한 도시이름, 코드, 지역, 인구 조회

SELECT
	NAME,
	CountryCode,
	District,
	Population
FROM
	city
WHERE
	population > 2000000 and
	CountryCode = 'kor';
	
-- 인구가 3백만 이상 5백만 이하 이름/인구/코드
SELECT
	c.Name,
	c.CountryCode,
	c.Population
FROM
	city AS c
WHERE
	c.Population BETWEEN 6789479 AND 8000000;

-- 국가코드 kor 이거나 afg 이거나 nld인 이름/코드 조회

SELECT
	c.Name,
	c.CountryCode
FROM
	city AS c
WHERE
	c.CountryCode IN ('kor', 'usa', 'chn');

-- 도시 이름이 seo로 시작하는 모든 도시 데이터조회
SELECT
	c.Name
FROM
	city AS c
WHERE
	c.Name LIKE 'seo%';
	
-- 도시 이름에 eo 들어가는 도시 이름 조회
SELECT
	c.Name,
	c.CountryCode
FROM
	city AS c
WHERE
	c.Name LIKE '%los%';
	
-- 도시 이름에 eo, 앞에 1글자,  뒤에 어떤문자전부
SELECT
	c.Name,
	c.CountryCode
FROM
	city AS c
WHERE
	c.Name LIKE 'san%';
	
	
-- 국가 코드가 k /u / a 시작하는 이름 국가코드
SELECT
	c.Name,
	c.CountryCode
FROM
	city AS c
WHERE
	c.CountryCode LIKE 'K%' or
	c.CountryCode LIKE 'U%' or
	c.CountryCode LIKE 'a%'; 
	



-- 국가코드 A,E,I로 시작하지않고 A,O,U로 끝나지 않는 이름, 코드
SELECT
	c.name,
	c.CountryCode
FROM
	city AS c
WHERE
	c.CountryCode NOT LIKE 'A%' and
	c.CountryCode NOT LIKE 'E%' and
	c.CountryCode NOT LIKE 'I%' and
	c.CountryCode NOT LIKE '%A' and
	c.CountryCode NOT LIKE '%O' and
	c.CountryCode NOT LIKE '%U';

-- 중복 데이터 제거

SELECT DISTINCT
	c.Population
FROM
	city AS c

-- LIMIT 
SELECT DISTINCT
	c.Population
FROM
	city AS c
LIMIT 30;


-- 도시이름조회, 오름차순
SELECT
	c.Name
FROM
	city AS c
ORDER BY c.Name;

-- 도시이름조회, 내림차순
SELECT
	c.Name
FROM
	city AS c
ORDER BY c.Name DESC;

-- 인구수 기준 오름차순, 도시이름/인구수 조회
SELECT
	c.Name,
	c.Population
FROM
	city AS c
ORDER BY c.Population;

-- 인구 100만이상 도시이름/인구수조회, 인구수 오름차순
SELECT
	c.Name AS '도시이름',
	c.Population AS '인구수'	
FROM
	city AS c
WHERE
	c.Population >= 1000000 
ORDER BY c.Population;

-- 코드 usa 면서 인구 200백만보다 많은 도시 이름/인구수조회
-- 도시이름 기준 내림차순
SELECT
	cc.Name AS '이름',
	cc.Population AS '인구수'
FROM
	city AS cc
WHERE
	cc.CountryCode = 'usa' 
	and
	cc.Population > 2000000
ORDER BY cc.Name;

-- 인구수 조회, 인구수 가장 많은 도시이름,인구수 출력
SELECT
	c.Name,
	c.Population
FROM
	city AS c
ORDER BY c.Population DESC
LIMIT 1; 



-- 인구수 조회, 인구수 가장 적은 도시이름,인구수 출력

SELECT
	c.Name,
	c.Population
FROM
	city AS c
ORDER BY c.Population
LIMIT 1; 

-- 
SELECT
	c.CountryCode,
	COUNT(c.name),
	c.ID
FROM
	city AS c
GROUP BY c.CountryCode; 
 
SET GLOBAL sql_mode=(SELECT REPLACE (@@sql_mode,'ONLY_FULL_GROUP_BY',''));
-- SUM
SELECT
	SUM(c.Population) AS '대한민국 인구 합계'
FROM
	city AS c
where
	c.CountryCode = 'kor';

-- AVG
SELECT
	avg(c.Population)
FROM
	city AS c;
	
-- COUNT
SELECT
	COUNT()
FROM
	city AS c
WHERE
	c.CountryCode = 'kor';
	
-- COUNT에 DISTINCT 이용

SELECT
	COUNT(DISTINCT c.CountryCode)
FROM
	city AS c;
	
-- 지역구 캘리포니아의 인구 평균
SELECT
	AVG(c.Population) AS '캘리포니아 인구 평균'
FROM
	city AS c
WHERE
	c.District = 'California';

-- 인구수 800만 이상 도시의 수
SELECT
	COUNT(c.CountryCode)
FROM
	city AS c
WHERE
	c.Population >= 8000000;
	
-- 국가코드개수, 중복제거한 국가코드개수의 차이
SELECT
	COUNT(c.CountryCode) - COUNT(DISTINCT c.CountryCode) AS 차이	
FROM
	city AS c;	

-- 가장 많은 인구수와 가장 적은 인구수의 차이
SELECT
	MAX(c.Population) - MIN(c.Population) AS 차이
FROM
	city AS c;

-- 국가코드별 인구수 평균
SELECT
	c.CountryCode,
	AVG(c.Population) AS '국가코드별 인구수 평균'
FROM
	city AS c
GROUP BY c.CountryCode
HAVING AVG(c.Population);

-- 국가코드별 도시 개수 조회, 도시개수 100개 이상인 국가만 해당
SELECT 
	c.CountryCode, 
	count(c.Name)
FROM
	city AS c
GROUP BY c.CountryCode
HAVING COUNT(c.name) > 100
ORDER BY count(c.Name) desc
LIMIT 4;

-- IFNULL 관련함수
SELECT
	IFNULL(NULL, '널'),
	IFNULL(100, '널아님')
	
-- ROUND 관련함수
SELECT 
	ROUND(3.33312323, 4);

-- LENGTH 관련함수
SELECT 
	LENGTH('ㄱㄱㄱㄱ'),
	length('asddd'),
	CHAR_LENGTH('ddd기')

-- CONCAT, TRIM 관련함수
SELECT
	CONCAT('나는', '입니다'),
	CONCAT_WS('~~~~','나는', '입','니다'),
	TRIM('   dsd    d ');

-- REPLACE 관련함수	
SELECT
	REPLACE('안녕하세요','하세요','합니다')
	
-- SUBSTR 관련함수	
SELECT
	SUBSTR('안녕하세요',3),	
	SUBSTR('안녕하세요',2,2)
	
-- 도시이름의 글자수 25보다 큰 도시의 이름/코드/지역구 조회
SELECT
	c.Name,
	c.CountryCode,
	c.District
FROM
	city AS c 
WHERE
	CHAR_LENGTH(c.Name) > 25;
	
-- 도시이름과 길이 조회. 도시이름 길이가 작은것부터 큰 순서
SELECT
	c.Name,
	CHAR_LENGTH(c.Name) AS '이름길이'
FROM
	city AS c
ORDER BY CHAR_LENGTH(c.Name) desc;


-- 국가코드 첫 글자와 마지막 글자 합쳐서 소문자로 조회, 조회 열 이름 small_code로 조회
SELECT
	lower(concat(LEFT(c.CountryCode,1), RIGHT(c.CountryCode,1))) AS 'small_code'
FROM
	city AS c

-- sakila DB의 language 테이블에서 이름에 i가 들어가는 데이터 찾고 i를 I로 조회, 조회 이름 upper_I

SELECT
	replace(l.name, 'i', 'I') AS upper_I
FROM
	language AS l
WHERE
	l.name LIKE '%i%';
	
/* 날짜 및 시간함수 */
SELECT
NOW(), CURRENT_DATE(), CURRENT_TIME(), YEAR(NOW()), MONTH(NOW())

/* 날짜 및 시간함수2 */
SELECT
	ADDDATE('2021.02.01', INTERVAL 10 DAY),
	SUBDATE('2021.02.01', INTERVAL 10 DAY),
	DATEDIFF('2023.05.02', NOW());

/* 시스템함수 */
SELECT
	VERSION(), -- 현재 버전
	DATABASE(), -- 현재 DB
	SLEEP(0.5) -- 실행 지연 

/* 문자 형 변환 함수 */
SELECT 
CONVERT('970201', UNSIGNED), CAST(970201 as CHAR(8));

/* 날짜 변환 함수 */
SELECT 
	DATE_FORMAT('970201', '%Y연%M월%D일'),
	DATE_FORMAT('970201', '%y연%m월%d일')ksmart51db
	
/* 상품 테이블에서 전체 상품 가격의 합 조회 */
SELECT
	SUM(g.g_price) AS '전체 상품 가격 합'
FROM
	tb_goods AS g

/* 상품 테이블에서 판매자별 판매상품가격 합계와 아이디 조회*/
SELECT
	SUM(g.g_price),
	g.g_seller_id
FROM
	tb_goods AS g
GROUP BY 
	g.g_seller_id;

/* 판매자별 취급 상품가격 합계가 300만원보다 많은 판매자 아이디/금액 조회 */
SELECT
	g.g_seller_id,
	SUM(g.g_price)
FROM 
	tb_goods AS g
GROUP BY 
	g.g_seller_id
HAVING
	SUM(g.g_price) > 3000000;

/* 최대구매수량, 최소구매수량, 총 구매수량 조회 */
SELECT
	MAX(o.o_amount) AS '최대구매수량',
	MIN(o.o_amount) AS '최소구매수량',
	SUM(o.o_amount) AS '총 구매수량'
FROM
	tb_order AS o;

/* 윈도우 함수 */
SELECT
	c.CountryCode,
	c.Population,
	MAX(c.Population) OVER(PARTITION BY c.CountryCode) AS '인구'
FROM
	city AS c

/* 순위 함수 */
SELECT
	c.name,
	ROW_NUMBER() OVER (ORDER BY c.Population) AS 'ROW_NUMBER',
	RANK() OVER (ORDER BY c.Population) AS 'RANK',
	DENSE_RANK() OVER (ORDER BY c.Population) AS 'DENSE_RANK'
FROM
	city AS c
WHERE
	c.CountryCode = 'kor';

