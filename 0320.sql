/*
	한국 도시 중, 인구수가 가장 적은 도시의 인구수보다 
	많은 인구수를 가지는 세계의 도시 이름과 인수구 조회
*/
SELECT
	c.Name,
	c.Population
FROM
	city AS c
WHERE
	c.Population > (	-- 서브 쿼리 
							SELECT
								MIN(c.Population)
							FROM
								city AS c
							WHERE
								c.CountryCode = 'KOR'
						);

/*
	회원 레벨 2인 회원 중, 판매 상품 가격 60만원 이상인
	판매자 정보 조회
*/
SELECT
	g.g_seller_id,
	g.g_name,
	g.g_price
FROM	
			(SELECT
				m.m_id,
				m.m_name
			FROM
				tb_member AS m
			WHERE
				m.m_level = 2) AS s
			INNER JOIN 
			tb_goods AS g
			ON 
			s.m_id = g.g_seller_id							
WHERE 
	g.g_price > 600000;

/* 
	구매자 회원 중, 구매이력 있는 (주문내역 있음) 구매자 조회
*/
SELECT
	*
FROM
	tb_member AS m 
WHERE
	EXISTS (	SELECT *  
				FROM tb_order AS o 
				WHERE o.o_id = m.m_id)

/*
	USA도시 중 한국의 도시 ULSAN의 인구수보다 하나라도 큰
	도시이름/인구수 조회
*/
SELECT 
	c.Name,
	c.Population
FROM 
	city AS c
WHERE
	c.CountryCode = 'USA' and
	c.Population > ANY ( SELECT
									c.Population
								FROM
									city AS c
								WHERE
									c.Name = 'ulsan');