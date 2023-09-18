-- 1. Xây dựng procedure cho phép lấy ra tất cả các loại sản phẩm
/*
	Khi tạo procedure để phân tách vùng nhớ database để lưu trữ procedure sử
    dụng DELIMITER
*/
DELIMITER //
create procedure get_all_types(
	-- Khai báo các tham số vào và tham số ra của procedure
)
BEGIN
	select * from loaisp;
END //
DELIMITER ;
-- Gọi procedure: call procedureName(argumentIn,register argumentOut)
call get_all_types();
-- Tạo procedure cho phép thêm mới một loại sản phẩm
DELIMITER //
Create procedure insert_types(
	in type_id varchar(100),
    in type_name varchar(30),
    type_des varchar(100) -- không viết in/out thì mặc định là in
)
BEGIN
	insert into loaisp
    values(type_id,type_name,type_des);
END //
DELIMITER ;
call insert_types('TP03','Quần áo trẻ em','Hàng tháng 12');
-- Tạo procedure cho phép cập nhật loại sản phẩm theo mã loại sản phẩm
DELIMITER //
Create procedure update_types(
	type_id varchar(4),
    type_name varchar(30),
    type_des varchar(100)
)
BEGIN
	update loaisp
    set tenloaisp = type_name,
		ghichu = type_des
	where maloaisp = type_id;
END //
DELIMITER ;
call update_types('TP03','Trẻ em','Tháng 12');
-- Tạo procedure cho phép xóa loại sản phẩm theo mã loại sản phẩm
DELIMITER //
create procedure delete_types(
	type_id varchar(4)
)
BEGIN
	delete from loaisp where maloaisp = type_id;
END //
DELIMITER ;
call delete_types('TP03');
-- Tạo procedure cho phép lấy thông tin loại sản phẩm theo mã loại sản phẩm
DELIMITER //
create procedure get_types_by_id(
	type_id varchar(4)
)
BEGIN
	select * from loaisp where maloaisp = type_id;
END //
DELIMITER ;
call get_types_by_id('TP01');
-- Tạo procedure cho phép tính số lượng loại sản phẩm trong db
DELIMITER //
drop procedure if exists get_count_types;
create procedure get_count_types(
	out cnt_type int
)
BEGIN
	-- set cnt_type = (select count(*) from loaisp);
    select count(*) into cnt_type from loaisp;
END //
DELIMITER ;
-- Khai báo biến để chứa dữ liệu trả ra của procedure - tiền tố @
-- Biến hệ thống @@
call get_count_types(@output);
select @output;
-- Tạo procedure cho phép lấy các loại sản phẩm theo tên sản phẩm (tìm gần đúng)
DELIMITER //
create procedure search_types(
	type_name_search varchar(30)
)
BEGIN
	-- khai báo biến name_search
    declare name_search varchar(32);
    set name_search = concat('%',type_name_search,'%');
	select * from loaisp where tenloaisp like name_search;
END //
DELIMITER ;
call search_types('Áo');