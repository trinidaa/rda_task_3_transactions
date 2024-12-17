DELIMITER $$
USE ShopDB;
CREATE PROCEDURE CreateOrder()
BEGIN

    DECLARE last_order_id INT;
    DECLARE warehouse_amount INT;
    INSERT INTO Orders (CustomerID, Date) VALUES (1, '2023-01-02');
    SET last_order_id = LAST_INSERT_ID();
    START TRANSACTION;
    SET warehouse_amount = (SELECT WarehouseAmount FROM Products WHERE ID = 1);
    IF warehouse_amount >= 1 THEN
        INSERT INTO OrderItems (OrderID, ProductID, Count)
        VALUES (@last_order_id, 1, 1);
        UPDATE Products SET WarehouseAmount = WarehouseAmount - 1 WHERE ID = 1;
        COMMIT;
    ELSE
        ROLLBACK;
        SELECT 'No more products' AS ErrorMessage;
    END IF;

END $$

DELIMITER ;