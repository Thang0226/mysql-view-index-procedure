create database demo;

use demo;

create table Products (
	id int auto_increment primary key,
	productCode varchar(20) not null,
	productName varchar (50) not null,
	productPrice decimal(10,2),
	productAmount int,
	productDescription text,
	productStatus bit
);

insert into Products (productCode, productName, productPrice, productAmount, productDescription, productStatus)
values
	('P001', 'Laptop Dell Inspiron', 750.00, 15, 'High-performance laptop with 15-inch screen.', 1),
	('P002', 'Wireless Mouse Logitech', 25.99, 100, 'Ergonomic wireless mouse with long battery life.', 1),
	('P003', 'Keyboard Mechanical Razer', 89.50, 50, 'Mechanical keyboard with customizable RGB lighting.', 0),
	('P004', 'Monitor Samsung 24"', 199.99, 20, '24-inch HD monitor with adjustable stand.', 1),
	('P005', 'Smartphone iPhone 14', 999.99, 30, 'Latest Apple iPhone with A15 Bionic chip.', 1),
	('P006', 'Bluetooth Speaker JBL', 49.99, 70, 'Portable speaker with deep bass and waterproof design.', 1),
	('P007', 'External SSD 1TB Samsung', 149.00, 40, '1TB portable SSD with fast data transfer.', 1),
	('P008', 'Gaming Chair Secretlab', 399.00, 10, 'Comfortable gaming chair with adjustable features.', 0),
	('P009', 'Graphics Card NVIDIA RTX 3080', 699.99, 8, 'High-end graphics card for gaming and rendering.', 0),
	('P010', 'USB-C Hub Anker', 34.99, 120, 'Multiport USB-C hub with HDMI and power delivery.', 1);
    
select * from products;



-- Indexes
create unique index idx_productCode on Products(productCode);
alter table Products add unique index idx_name_price (productName, productPrice);

alter table Products drop index idx_productCode;
alter table Products drop index idx_name_price;

explain select * from products
where productCode >= 'P008';

explain select * from products
where productPrice > 200 and productName = 'Smartphone iphone 14';



-- Views
create view products_view as
select productCode, productName, productPrice, productStatus
from products;

select * from products_view;

create or replace view products_view as
select productCode, productName, productPrice
from products;

select * from products
where productCode >= 'P009';

update products_view
set productPrice = 50
where productCode = 'P010';

drop view products_view;



-- Stored Procedures
delimiter //

create procedure showAllProducts()
begin
	select * from products;
end //

delimiter ;

call showAllProducts();


delimiter //

create procedure addProduct(
	in in_productCode varchar(20), 
    in in_productName varchar(50), 
    in in_productPrice decimal(10,2),
	in in_productAmount int,
	in in_productDescription text,
	in in_productStatus bit
    )
begin
	insert into Products(productCode, productName, productPrice, productAmount, productDescription, productStatus) values
		(in_productCode, in_productName, in_productPrice, in_productAmount, in_productDescription, in_productStatus);
end //

delimiter ;

call addProduct('P011', 'Smartwatch Garmin Venu 2', 349.99, 25, 'Fitness-focused smartwatch with AMOLED display.', 1);


delimiter //

create procedure updateProductByID(
	in p_id int,
    in p_productCode varchar(20),
    in p_productName varchar(50),
    in p_productPrice decimal(10,2),
    in p_productAmount int,
    in p_productDescription text,
    in p_productStatus bit
)
begin
	update products
    set
		productCode = p_productCode,
        productName = p_productName,
        productPrice = p_productPrice,
        productAmount = p_productAmount,
        productDescription = p_productDescription,
        productStatus = p_productStatus
	where
		id = p_id;
end //

delimiter ;

call UpdateProductById(
    5, 
    'P005-NEW', 
    'iPhone 14 Pro', 
    1099.99, 
    20, 
    'Latest iPhone model with advanced features.', 
    1
);


delimiter //

create procedure deleteProductByID(in p_id int)
begin
	delete from products
    where id = p_id;
end //

delimiter ;

call deleteProductByID(5);
call showAllProducts();











