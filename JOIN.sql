/* full group by 에러수정 */
SET GLOBAL sql_mode=(SELECT REPLACE (@@sql_mode,'ONLY_FULL_GROUP_BY',''));


/* INNER JOIN */
SELECT
	*
FROM
	tb_member AS m
	INNER JOIN 
	tb_order AS o
	ON
	m.m_id = o.o_id;
	
/* 구매자 회원의 구매수량, 구매자 아이디, 구매자 이름 */
SELECT
	o.o_amount AS '구매수량',
	o.o_id AS '구매자 아이디',
	m.m_name AS '구매자 이름'
FROM
	tb_member AS m
	INNER join
	tb_order AS o 
	on
	m.m_id = o.o_id;

/* continent 유럽에 속한 모든 도시이름과 continent 조회  */
SELECT
	c2.Name,
	c1.Continent	
FROM
	city AS c2
	left JOIN 
	country AS c1
	on
	c1.Code = c2.CountryCode
WHERE 
	c1.Continent = 'Europe';
	
SELECT ct.Name, cy.Continent
FROM city AS ct INNER JOIN country AS cy ON ct.CountryCode = cy.Code
WHERE	cy.Continent = 'Europe';

	
/* continent 가 ASIA인 도시의 인구수 합 조회 */
SELECT
	sum(ct.Population) AS '인구 합',
	ct.Continent
FROM
	country AS ct
	INNER join
	city AS ci
	on
	ct.Code = ci.CountryCode
WHERE
	ct.Continent = 'ASIA';
	
/* 회원권한이름 '관리자'인 회원 이름과, 권한이름, 이메일조회 */
SELECT
	ml.level_name AS '권한이름',
	m.m_name AS '회원이름',
	m.m_email AS '이메일'
FROM
	tb_member AS m
	INNER join
	tb_member_level AS ml
	ON
	ml.level_num = m.m_level
WHERE 
	ml.level_name = '관리자';
	
	
SET GLOBAL sql_mode=(SELECT REPLACE (@@sql_mode, 'only_full_group_by',''));
/* 회원 중 2월에 로그인한 회원아이디/이메일/로그인일자 조회 */
SELECT
	m.m_id AS '회원아이디',
	m.m_email AS '이메일',
	l.login_date AS '로그인일자'
FROM
	tb_member AS m
	INNER JOIN 
	tb_login AS l
	on
	m.m_id = l.login_id
WHERE
	MONTH(l.login_date) = 2
GROUP BY 
	m.m_id
ORDER BY l.login_date desc;

/* 구매자 회원의 아이디와 이름/주소/구매상품코드/구매상품이름 조회 */
SELECT
	o.o_id AS '구매자 아이디',
	m.m_name AS '구매자명',
	m.m_addr AS '구매자주소',
	o.o_g_code AS '구매상품코드',
	g.g_name AS '구매상품이름'
FROM
	tb_member AS m
	INNER JOIN 
	tb_order AS o
	ON 
	m.m_id = o.o_id
	INNER JOIN 
	tb_goods AS g
	ON 
	o.o_g_code = g.g_code;
	
/* UNION */
SELECT
FROM
UNION
SELECT
FROM

/* 회원 중 로그인하지 않은 회원 아이디/이메일/로그인일자 조회 */
-- 로그인 일자는 login_record 이름으로 조회
-- login_record에서 조회되지 않는 값은 '로그인 기록 없음'으로 조회
SELECT
	m.m_id,
	m.m_email,
	IFNULL(l.login_date, '로그인 기록 없음') AS 'Login_record'
FROM
	tb_member AS m 
	LEFT JOIN 
	tb_login AS l
	ON
	m.m_id = l.login_id
WHERE
	l.login_id IS NULL 