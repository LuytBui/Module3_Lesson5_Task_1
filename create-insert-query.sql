
create table Products(
id int auto_increment primary key,
productCode varchar(20),
productName varchar(50),
productPrice int,
productAmount int default 1,
productDesciption varchar(80) default "",
productStatus bit default 1
);

insert into Products (productCode, productName, productPrice, productAmount) values
	("COCA1.5L", "Cocacola 1.5l", 15000, 100),
	("COCA330ML", "Cocacola 330mll", 8000, 500),
	("KITKAT324A", "KitKat Socola 324A", 15000, 100),
	("OMAIBAHUONG101", "Ô mai Bà Hương - Mơ sấy - hộp 200g", 25000, 100),
	("OMAIBAHUONG102", "Ô mai Bà Hương - Nho khô - hộp 500g", 60000, 100),
	("MILIKET101", "Mì Miliket 800 tôm", 3300, 100),
	("CUNGDINH112", "Mì Cung đình khoai tây", 6500, 100)
;
select * from products;

#Tạo Unique Index trên bảng Products (sử dụng cột productCode để tạo chỉ mục)
alter table Products
add index index_productCode (productCode);


#Tạo Composite Index trên bảng Products (sử dụng 2 cột productName và productPrice)
alter table Products
add index index_productName_productPrice (productName, productPrice);

#Sử dụng câu lệnh EXPLAIN để biết được câu lệnh SQL của bạn thực thi như nào
explain select * from products where productCode = "COCA330ML";
explain select * from products where productName = "Cocacola 1.5l";



#Tạo view lấy về các thông tin: productCode, productName, productPrice, productStatus từ bảng products
create view product_info as
select productCode, productName, productPrice, ProductStatus
from Products;

#Tiến hành sửa đổi view
update product_info
set productPrice = 20000
where productCode = "COCA1.5L";
select * from product_info;
select * from Products;

#Tiến hành xóa view
drop view product_info;

#Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product
delimiter //
create procedure getInfo()
begin
	select productCode, productName, productPrice, ProductStatus
	from Products;
end
// delimiter ;

call getInfo();

#Tạo store procedure thêm một sản phẩm mới
delimiter //
create procedure addNewProduct
	(in inputProductCode varchar(20),
	in inputProductName varchar(50),
	in inputProductPrice int,
	in inputProductAmount int
    )
begin
	insert into Products (productCode, productName, productPrice, productAmount) values
		(inputProductCode, inputProductName, inputProductPrice, inputProductAmount);
end
// delimiter ;

call addNewProduct("CHOCOPIE", "Orion Chocopie hộp 500g", 62000, 200);

#Tạo store procedure sửa thông tin sản phẩm theo id
drop procedure editProduct;
delimiter //
create procedure editProduct
	(
    in searchProductID int,
    in newProductCode varchar(20),
	in newProductName varchar(50),
	in newProductPrice int,
	in newProductAmount int
    )
begin
	update Products
    set productCode = newProductCode, 
		productName = newProductName, 
        productPrice = newProductPrice, 
        productAmount = newProductAmount
    where Products.ID = searchProductID;
end
// delimiter ;

select * from products;
call editProduct(8, "CHOCOPIE", "Orion Chocopie hộp 500g", 65000, 50);

#Tạo store procedure xoá sản phẩm theo id
delimiter //
create procedure deleteProduct
	(in searchProductID int)
begin
	delete from Products
    where ID = searchProductID;
end
// delimiter ;

select * from products;
call deleteProduct(8);