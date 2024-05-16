-- 프로시저 작성 
DELIMITER $$
CREATE PROCEDURE sp_test( )
BEGIN

END $$

DELIMITER ;

/* 회원의 이름으로 회원 아이디/이름/이메일 조회 프로시저 작성 */
DELIMITER $$
CREATE PROCEDURE userInfo(IN name_n VARCHAR(10))
	BEGIN 
	SELECT m.m_id, m.m_name, m.m_email 
	FROM tb_member AS m
	WHERE m.m_name = name_n;
END $$
DELIMITER ;

CALL userInfo('홍03'); -- 실행
DROP procedure userInfo; -- 삭제

/* 회원 아이디/비밀번호 입력 시 회원이메일 조회 프로시저 생성 */
DELIMITER $$
CREATE PROCEDURE login(IN m_login VARCHAR(10), m_password VARCHAR(10))
	BEGIN 
	SELECT m.m_email 
	FROM tb_member AS m
	WHERE m.m_id = m_login and
			m.m_pw = m_password;
END $$
DELIMITER ;

/* case 문 */
SELECT g.g_name,
		(case when g.g_price > 50000 then '비쌈'
				when g.g_price > 10000 then '쌈'
				ELSE '그냥저냥' END) AS '평가'
FROM tb_goods AS g
-- 2번째 방법 
SELECT c.Name,
	c.CountryCode,
	(case c.CountryCode
	when 'JPN' then '쪽빨'
	when 'CHN' then '짱께'
	ELSE '외국' END) AS '호칭'
FROM city AS c

/* 회원아이디 받아 회원권한조회 프로시저 생성_case사용  */
DROP PROCEDURE userInfo;
DELIMITER $$
CREATE PROCEDURE userInfo(IN idInsert VARCHAR(10) )
BEGIN
	SELECT
		(case m.m_level
		when 1 then '관리자'
		when 2 then '판매자'
		when 3 then '구매자'			
		ELSE '없다' END) AS '권한'
	FROM 
		tb_member AS m
	WHERE 
		 m.m_id = idInsert;
END $$

DELIMITER ;


