-- 함수작성
/* 주문테이블에서 상품판매이익 구하는 함수 */
DELIMITER $$
CREATE FUNCTION sf_profit(goods_price INT)
RETURNS INT -- 반환값 데이터 타입 지정 
BEGIN 
	DECLARE myProfit INT;
	IF goods_price >= 12000
		SET myProfit = goods_price * 0.1
		....
	END IF; 

END $$

DELIMITER ;

/* 함수생성권한부여 */
SET GLOBAL log_bin_trust_function_creators = 1; 

/* 두 수의 합 구하는 함수 */
DELIMITER $$
DROP FUNCTION IF EXISTS sf_add$$ 
CREATE FUNCTION sf_add(x INT, y INT) -- 함수 이름과 매개변수, 데이터타입
RETURNS INT -- 반환데이터타입
BEGIN 
	DECLARE result INT; -- 지역변수선언
	SET result := x + Y; 
	RETURN result;	-- result 반환 
END $$
DELIMITER ;
SELECT sf_add(122, 44) AS '합';

/* 회원 이름 입력시 이메일 조회 함수,
	조회결과 없을 때 조회결과없습니다 출력 */
DELIMITER $$
DROP FUNCTION IF EXISTS sf_userEma$$ 
CREATE FUNCTION sf_userEma(userName VARCHAR(50))
RETURNS VARCHAR(50)
BEGIN 
	DECLARE result VARCHAR(50);
	SELECT CONCAT(m.m_name, ':', m.m_email) INTO result;
	FROM tb_member AS m
	WHERE m.m_name = userName;
	IF result IS NULL then
		SET result = '없다';
	END IF;
	RETURN result;
END $$
DELIMITER ;

/* 판매자 아이디입력받아 취급상품목록 출력 함수 작성
	결과는 한 줄로 조회 */
DELIMITER $$
DROP FUNCTION IF EXISTS sf_itemList$$ 
CREATE FUNCTION sf_itemList(userId VARCHAR(50))
RETURNS VARCHAR(50)
BEGIN 
	DECLARE result VARCHAR(50);
	SELECT  GROUP_CONCAT(g.g_name) into result
	FROM tb_goods AS g
	WHERE g.g_seller_id = userId;
	IF result IS NULL then
		SET result = '없다';
	END IF;
	RETURN result;
END $$
DELIMITER ;	
SELECT sf_itemList('id007') AS '결과';

/* 도시이름 입력 시 
   city name : country name : kor, citypop : 9981619
   로 출력
*/
DELIMITER $$
DROP FUNCTION IF EXISTS sf_cityInfo$$ 
CREATE FUNCTION sf_cityInfo(cityName VARCHAR(50))
RETURNS VARCHAR(50)
BEGIN 
	DECLARE result VARCHAR(50);
	SELECT CONCAT('시티이름 : ', c.Name, ' 국가이름 : ', c.CountryCode, ' 시티인구 : ', cast(c.Population AS CHAR)) INTO result
	FROM city AS c
	WHERE c.Name = cityName;
	RETURN result;
END $$
DELIMITER ;
SELECT sf_cityInfo('new york') AS '결과';

-- 트리거 
DROP TRIGGER if EXISTS 
DELEMITER $$
CREATE TRIGGER trigger_name
trigger_time trigger_event
AFTER DELETE -- delete가 발생하면, 트리거가 작동된다는 의미
ON tabble_name -- 부착할 테이블 이름 
FOR EACH ROW -- 각 행마다 적용한다는 의미 
BEGIN 
END $$


DROP TRIGGER if EXISTS member_del_trig
DELIMITER $$
CREATE TRIGGER member_del_trig
AFTER DELETE 
ON tb_member2
FOR EACH ROW 
BEGIN 
	INSERT INTO tb_member2backup
	(memId,memName,memAdd,modType,modDate,modUser)
	VALUES (OLD.m_id, OLD.m_name, OLD.m_addr, '삭제', CURDATE(),CURRENT_USER());
END $$
DELIMITER ;

DELETE 
FROM
 tb_member2 AS m 
WHERE 
 m.m_id = 'id003';
 
/* 회원 이름 변경되면 발동하는 트리거 만들고 테스트 */
DROP TRIGGER if EXISTS member_update_trig;
DELIMITER $$
CREATE TRIGGER member_update_trig
AFTER UPDATE  
ON tb_member2
FOR EACH ROW 
BEGIN 
	if OLD.m_name <> NEW.m_name 
	then 
	INSERT INTO tb_member2backup
	(memId,memName,memAdd,modType,modDate,modUser)
	VALUES (OLD.m_id, OLD.m_name, OLD.m_addr, '수정', CURDATE(),CURRENT_USER());
END IF;
END $$
DELIMITER ;

UPDATE tb_member2
SET 
	m_name = '홍덕철'
WHERE 
 	m_id = 'id006';
 	
-- 오토커밋 
SELECT @@autocommit; 
SET @@autocommit := 1;

START TRANSACTION;

SELECT 
	m.m_id,
	m.m_name
FROM 
	tb_member2 AS m
WHERE 
	m.m_id = 'id012';
	
UPDATE 
	tb_member2 AS m
SET 
	m.m_name = '배광수'
WHERE 
	m.m_id = 'id012';
SAVEPOINT save012;

DELETE 
FROM
	tb_member2 AS m 
WHERE 
	m.m_id = 'id012';
ROLLBACK TO SAVEPOINT save012;
COMMIT;