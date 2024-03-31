
-- Cоздайте процедуру, которая выведет только числа, делящиеся на 15 или 33 в промежутке от 1 до 1000.
-- Пример: 15,30,33,45...
DROP PROCEDURE IF EXISTS numbers;
DELIMITER $$ 

CREATE PROCEDURE numbers (IN max_number int, OUT result varchar(255)) -- Создаем процедуру с двумя параметарми.
BEGIN
  DECLARE i int DEFAULT 15; -- по умолчанию устанавливаем первое значение i = 15 (так как нам нужно проверить / на 15)
  SET result = ''; -- устанваливаем изначально результат в NULL
  WHILE i < max_number DO -- создаем цикл, проверяющий параметр i  до нашего задаваемого максимального параметра 
	IF i MOD 15 = 0 OR i MOD 33 = 0 -- проверяем наше условие деления на 15 и на 33 
		THEN SET result = CONCAT(result, CAST(i AS char), ', '); --  соединяем в строчку для вывода
	END IF; 
    SET i = i + 1; -- увеличиваем наш i для следующей проверки в цикле while
  END WHILE;

END
$$

DELIMITER ;
SET @res = '';
CALL numbers(500, @res); -- здесь уставаливаем макс параметр
SELECT @res;



