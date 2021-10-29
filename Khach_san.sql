create database KHACH_SAN
use KHACH_SAN
create table PHONG(MaPhong char(10) not null primary key, LoaiPhong char(5) not null,
DonGia int not null)
--
select * from PHONG
create table KHACHTHUE(MaKhach char(10) not null primary key, HoTen varchar(50) not null,
DiaChi varchar(120), DienThoai char(10) not null, GioiTinh bit not null)
--
select * from KHACHTHUE
create table HOADON(SoHoaDon char(6) not null primary key, MaPhong char(10) not null, 
MaKhach char(10) not null, NgayDen date not null, NgayDi date not null, 
ThoiGianThue int, TienPhong int,  ChietKhau int,
constraint FK_PHONG foreign key(MaPhong) references PHONG(MaPhong),
constraint FK_KHACHKHUE foreign key(MaKhach) references KHACHTHUE(MaKhach))

--
Insert into PHONG(MaPhong,LoaiPhong,DonGia)
Values ('A102','A', 100), ('B101','B', 200), ('C102','C', 150), ('B102','B', 200), 
('A101','A', 100)
--
Insert into KHACHTHUE(MaKhach,HoTen,DienThoai,GioiTinh)
Values ('12341','Nguyen Thi Hoa', '0325896472',1),
('12342','Nguyen Thi Ngoc', '0956248357',1),
('12343','Vu Xuan Quang', '0325896472',0),
('12344','Tran Ngoc Son', '0983262494',0),
('12345','Nguyen Anh Thu', '0972658429',1)
--
Insert into HOADON(SoHoaDon,MaPhong, MaKhach,NgayDen, NgayDi)
Values ('HD0011','A102', '12341', '2019-1-20', '2019-1-25'),
('HD0012','B102', '12342', '2019-10-6', '2019-10-28'),
('HD0013','C102', '12343', '2019-10-9', '2019-10-29'),
('HD0014','A101', '12344', '2019-2-15', '2019-2-25'),
('HD0015','C102', '12345', '2019-3-24', '2019-4-5')
---
update PHONG
set DonGia=
	Case 
		When LoaiPhong='A' then 120
		When LoaiPhong='B' then 100
		Else 80
	end
--4
Select * from HOADON
Update HOADON
set ThoiGianThue=0, TienPhong=0, ChietKhau=0
Update HOADON
set ThoiGianThue= iif(Datediff(day,NgayDen,NgayDi)=0,1,
Datediff(day,NgayDen,NgayDi))
--5
Update HOADON
set TienPhong = ThoiGianThue * DonGia
from HOADON inner join PHONG on
HOADON.MaPhong = PHONG.MaPhong
--6
Update HOADON
set ChietKhau= TienPhong*iif(ThoiGianThue>7,0.15,
iif(ThoiGianThue<4,0,0.1))
--7. thông tin thanh toán hóa đơn có số hóa đơn là 'HD0011'
select *
from HOADON
where SoHoaDon='HD0011'
--8. cho biêt số phòng cho thuê theo từng loại phòng
select LoaiPhong, count(*) as SoPhong
from PHONG
group by LoaiPhong
--9. Cho biết thông tin gôm số lần thuê, tổng thời gian thuê, tổng tiền phòng của từng phòng ở quý 1 năm 2019
select MaPhong,count(*) as SoLanThue,sum(ThoiGianThue) as ThoiGianThue, sum(TienPhong) as TienPhong
from HOADON
where (NgayDen between '2019-1-1' and '2019-3-31') and (NgayDi between '2019-1-1' and '2019-3-31')
group by MaPhong
--10
Select MaPhong , sum(ThoiGianThue) as ThoiGianThue
From HOADON
where YEAR(NgayDen) = 2019 and YEAR(NgayDi)=2019 and MONTH(NgayDen)=10 and MONTH(NgayDi)=10
group by MaPhong
having sum(ThoiGianThue) >=10 