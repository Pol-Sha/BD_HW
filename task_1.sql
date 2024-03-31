
DROP FUNCTION IF EXISTS func_to_count_day;
DELIMITER $$

CREATE FUNCTION func_to_count_day(seconds int) -- задаем функцию, с входной переменной в секундах
  RETURNS varchar(250) -- тип возвращаемой переменной
  DETERMINISTIC
  -- декларируем наши переменные, которые будем выводить
BEGIN
  DECLARE res varchar(250);
  DECLARE days int DEFAULT 0;
  DECLARE hours int DEFAULT 0;
  DECLARE minutes int DEFAULT 0;

  -- выделяем дни
  IF seconds >= 86400 THEN   -- 24 ч * 60 мин * 60 сек ( в одном дне 86 400 секунд)
    SET days = seconds DIV 86400; -- узнаем сколько полных дней (целочисленное деление)
    SET seconds = seconds % 86400; -- узнаем какой остаток от деления (сколько секунд у нас осталось после выделения полных дней)
  END IF;

  -- выделяем часы
  IF seconds >= 3600 THEN  -- 60 м * 60 сек ( в одном часе 3600 секунд)
    SET hours = seconds DIV 3600; -- узнаем сколько часов
    SET seconds = seconds % 3600; -- узнаем какой остаток от деления после выделения часов
  END IF;

  -- считаем минуты / секунды
  IF seconds >=60 THEN --  60 сек 
    SET minutes = seconds DIV 60;
    SET seconds = seconds % 60;
  END IF;
  
  SET res = CONCAT(
                    CAST(days AS CHAR), ' days ',
                    CAST(hours AS CHAR), ' hours ',
                    CAST(minutes AS CHAR), ' minutes ');

  SET res = CONCAT(res, CAST(seconds AS CHAR), ' seconds');
  
  RETURN res;
END$$

DELIMITER ;
SELECT func_to_count_day(123456);