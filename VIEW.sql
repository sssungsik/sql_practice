/*
	city 테이블서 지역구가 England에 속한 도시이름/코드 조회하는 뷰 생성
	뷰 호출 시 도시 이름만 조회
*/
CREATE VIEW v_v1	-- 뷰 생성
AS
	SELECT
		c.Name,
		c.CountryCode
	FROM
		city AS c 
	WHERE 
		c.District = 'england';
		
SELECT	-- 뷰 호출
	v.Name
FROM
	v_v1 AS v
		
DROP VIEW v_v1	-- 뷰 삭제

/*
	회원 별 구매 이력 중 구매금액 가장 높은 금액의 상품이름/가격/이메일
	조회 뷰 생성
	뷰 조회 시 구매자 아이디/제품명/가격 조회
*/
CREATE VIEW v_v6
AS 
SELECT
	o.o_id,
	g.g_name,
	max(g.g_price),
	m.m_email
FROM
	tb_goods AS g
	INNER JOIN 
	tb_order AS o
	ON 
	o.o_g_code = g.g_code
	INNER JOIN 
	tb_member AS m
	ON
	o.o_id = m.m_id
GROUP BY o.o_id


SELECT
	*
FROM
	v_v6

/* WITH절  */
WITH cte_test(도시명, 주,인구)
AS (
		SELECT
			c.Name,
			c.District,
			c.Population 
		FROM
			city AS c
		WHERE 
			c.CountryCode = 'usa'
	)
SELECT 
	*
FROM
	cte_test
ORDER BY c.Population DESC;


/*
	가장 인구수가 많은 도시의 인구수,
	가장 인구수가 적은 도시의 인구수 조회 CTE 제작 후 
	가장 인구수가 많은 도시 이름과 인구수,
	가장 인구수가 적은 도시 이름과 인구수 조회
*/
WITH cte_p
AS (
		SELECT 
			max(c.Population) AS mxp,
			MIN(c.Population) AS mnp
		FROM 
			city AS c	
	)
SELECT
	c.Name AS '이름',
	c.Population '인구'
FROM
	city AS c    
	INNER JOIN
	cte_p AS p 
WHERE
	c.Population = p.mxp
	or
   c.Population = p.mnp;
	
/* GROUP_CONCAT */
SELECT
	c.District,
	GROUP_CONCAT(c.Name SEPARATOR  ' 와 ')
FROM
	city AS c

/* 
	cte
	구매자 별 구매이력 중, 
	단 구매 상품 별 구매 수량 20개 이상 상품 목록 조회
	
	조회시 구매자, 구매리스트 / 이름 , 품명 으로 조회
*/ 
WITH cte_ord1
AS (
		SELECT
			o.o_id,
			g.g_code,
			m.m_name,
			g.g_name
		FROM
			tb_order AS o 
			INNER JOIN 
			tb_member AS m 
			ON 
			m.m_id = o.o_id
			INNER JOIN 
			tb_goods AS g 
			ON 
			g.g_code = o.o_g_code
		GROUP BY o.o_id, g.g_code
		HAVING SUM(o.o_amount) >= 20
	)
SELECT
	o1.m_name AS '구매자',
	group_concat(o1.g_name) AS '구매리스트' 
FROM
	cte_ord1 AS o1
GROUP BY o1.o_id;

/* 국가코드별 도시개수 단 100개 이상 속한 국가 코드만 */
SELECT
	*
FROM	
	city AS c 
GROUP BY 	
	c.CountryCode
HAVING 
	COUNT(c.Name) >= 100
	
/* 판매자 아이디와 판매자 이름 조회 */
SELECT
	g.g_seller_id,
	m.m_name,
	group_concat(g.g_name)
FROM
	tb_goods AS g
INNER JOIN 
	tb_member AS m 
ON 
	g.g_seller_id = m.m_id
GROUP BY g.g_seller_id

