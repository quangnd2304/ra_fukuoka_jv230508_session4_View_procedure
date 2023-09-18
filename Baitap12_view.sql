use quanly_banhang;
/*
Thống kê tổng số lượng sản phẩm đã bán theo từng tháng trong năm, gồm 
thông tin: năm, tháng, mã sản phẩm, tên sản phẩm, đơn vị tính, tổng số 
lượng
*/

-- Thống kê số lượng sản phẩm bán theo mã sản phẩm
select * from ctphieuxuat;
select * from sanpham;
select substring_index(a.yearmonth,'-',1) as 'Year',substring_index(a.yearmonth,'-',-1) as 'Month',
a.soPx,a.masp,a.Donvitinh,a.TenSP,a.tongsoluongban
from (select px.SoPX, concat(year(px.NgayBan),'-',month(px.NgayBan)) as 'YearMonth', 
ctpx.MaSP,sp.Donvitinh, sp.TenSP, sum(ctpx.SoLuong) as 'TongSoLuongBan'
from phieuxuat px join ctphieuxuat ctpx on px.SoPX = ctpx.SoPX 
join sanpham sp on ctpx.MaSP=sp.MaSP
group by YearMonth,MaSP
order by YearMonth DESC) a;
-- Tạo view
create view vw_doanhthuthang
as
select px.NgayBan,px.SoPX,ctpx.MaSP,sp.Donvitinh,sp.TenSP,ctpx.SoLuong
from phieuxuat px join ctphieuxuat ctpx on px.SoPX = ctpx.SoPX 
join sanpham sp on ctpx.MaSP=sp.MaSP;
select * from vw_doanhthuthang;
update ctphieuxuat
set soluong = 20
where sopx = 'PX001' and Masp = 'P001';

