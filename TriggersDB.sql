create database TriggersDB
use triggersdb
create table products(
product_id int identity,
    product_name varchar(255) , 
    brand_id int, 
    category_id int, 
    model_year smallint, 
    list_price dec(10,2)
)


----DML triggers---
CREATE TABLE productsauditslog(
    change_id INT IDENTITY PRIMARY KEY,
    product_id INT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    brand_id INT NOT NULL,
    category_id INT NOT NULL,
    model_year SMALLINT NOT NULL,
    list_price DEC(10,2) NOT NULL,
    updated_at DATETIME NOT NULL,
    operation CHAR(3) NOT NULL,
    CHECK(operation = 'INS' or operation='DEL')
);

CREATE TRIGGER trg_product_audit
ON products
AFTER INSERT, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO productsauditslog(
        product_id, 
        product_name,
        brand_id,
        category_id,
        model_year,
        list_price, 
        updated_at, 
        operation
    )
    SELECT
        i.product_id,
        product_name,
        brand_id,
        category_id,
        model_year,
        i.list_price,
        GETDATE(),
        'INS'
    FROM
        inserted i
    UNION ALL
    SELECT
        d.product_id,
        product_name,
        brand_id,
        category_id,
        model_year,
        d.list_price,
        GETDATE(),
        'DEL'
    FROM
        deleted d;
END


INSERT INTO products(
    product_name, 
    brand_id, 
    category_id, 
    model_year, 
    list_price
)
VALUES (
    'Test product',
    1,
    1,
    2018,
    599
);
select * from productsauditslog


INSERT INTO products(
    product_name, 
    brand_id, 
    category_id, 
    model_year, 
    list_price
)
VALUES (
    'bike product',
    2,
    2,
    2019,
    599
);

delete from products
where product_id=1





-----DDL Triggers-------
create trigger trgpreventtable
on database
for create_table,alter_table,drop_TABLE
as 
begin 
print 'You cannor create,alter,drop database'
end 
rollback transaction

create table bill(inta int)

drop table products

select * from productsauditslog

select * from products
