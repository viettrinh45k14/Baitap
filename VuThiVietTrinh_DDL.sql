Create Database OTO_FORRENT
Use OTO_FORRENT
CREATE TABLE KHACHTHUE(MaKhach char(12) not null primary key,
TenKhach varchar(50) not null,
GioiTinh bit not null,
NgaySinh Date not null,
DiaChi varchar(120),
DienThoai char(10) not null)
Insert into KHACHTHUE (MaKhach, TenKhach, GioiTinh, NgaySinh, DiaChi, DienThoai)
Values ('202025101','Nguyen Van Hoang Nha', 0,'1998-1-3',' Da Nang', '0935812567'),
('202025102','Nguyen Van Khoi', 1,'1999-12-24',' Da Nang', '0943762513'),
('202025103','Pham Yen Nhi', 0,'1995-6-12',' Da Nang', '0975862495'),
('202025104','Dinh Hoang Phuong', 0,'1988-4-19',' Da Nang', '0938862527'),
('202025105','Cao Hong Phuc', 1,'1991-10-5',' Da Nang', '0983562103')

Select * from KHACHTHUE
CREATE TABLE XECHOTHUE(BienSo char(9) not null primary key,
SoChoNgoi int not null, HangSanXuat varchar(50) not null, DonGiaThue int not null)
Insert into XECHOTHUE(BienSo, SoChoNgoi,HangSanXuat, DonGiaThue)
Values ('43K2.1235', 5, 'Suzuki', 1100000),
('43K2.1236', 6, 'Toyota', 700000),
('43K2.1237', 4, 'Honda', 900000),
('43K2.1234', 7, 'Kia', 800000),
('43K2.1238', 6, 'Huyndai', 700000)

select * from XECHOTHUE

CREATE TABLE HOPDONGCHOTHUE( SoHopDong char(7) not null primary key,
MaKhach char(12) not null, BienSo char(9) not null,
NgayThue date not null, NgayTra date not null,
ThoiGianThue int, GiaTriHopDong int, DatTruoc int, ConLai int,
Constraint FK_KhachThue foreign key(MaKhach) References KHACHTHUE(MaKhach),
Constraint FK_XeChoThue foreign key(BienSo) References XECHOTHUE(BienSo))

Insert into HOPDONGCHOTHUE(SoHopDong, MaKhach, BienSo, NgayThue, NgayTra)
Values ('HD001','202025101', '43K2.1235', '2021-1-20', '2021-1-25'),
('HD002','202025102', '43K2.1236', '2021-1-13', '2021-1-17'),
('HD003','202025103', '43K2.1237', '2021-1-10', '2021-1-16'),
('HD004','202025104', '43K2.1234', '2021-1-8', '2021-1-12'),
('HD005','202025105', '43K2.1238', '2021-1-5', '2021-1-11')


--Update Query
Select * from XECHOTHUE
--Q1.Up Price to 15%
Update XECHOTHUE
Set DonGiaThue=DonGiaThue*1.15
--Q2.Down price to 20% for car 4 seats
Update XECHOTHUE
Set DonGiaThue=DonGiaThue*0.8
where SoChoNgoi=4
--Set number of seats of CarID = '45K4.3101' to 7
Update XECHOTHUE
set SoChoNgoi=7
where BienSo = '45K4.3101'
/*
Set price by seats
4: 120
7: 180
12: 250
others: 300
*/
--iif functions
Update XECHOTHUE
set DonGiaThue=iif(SoChoNgoi=4, 120,
	iif(SoChoNgoi=7, 180, iif(SoChoNgoi=12, 250, 300)))
--Case...when...then
Update XECHOTHUE
set DonGiaThue =
	Case 
	When SoChoNgoi=4 then 120
	When SoChoNgoi=7 then 180
	When SoChoNgoi=12 then 250
	Else 300
end
--
Select * from HOPDONGCHOTHUE
Update HOPDONGCHOTHUE
set ThoiGianThue=0, GiaTriHopDong=0, DatTruoc=0, ConLai=0
--Q Compute ThoiGianThue, note; Using Datediff in SQL
Update HOPDONGCHOTHUE
set ThoiGianThue= iif(Datediff(day,NgayThue,NgayTra)=0,1,
Datediff(day,NgayThue,NgayTra))
--Q Compute GiaTriHopDong=ThoiGianThue*DonGiaThue
--Join Tables on Foreign key
Update HOPDONGCHOTHUE
set GiaTriHopDong = ThoiGianThue * DonGiaThue
from HOPDONGCHOTHUE inner join XECHOTHUE on
HOPDONGCHOTHUE.BienSo = XECHOTHUE.BienSo
--
Select * from HOPDONGCHOTHUE
/*
Update DatTruoc by ThoiGianThue:
<3: 100%GiaTriHopDong
3-5: 70%GiaTriHopDong
5: 50%GiaTriHopDong

*/
Update HOPDONGCHOTHUE
set DatTruoc= GiaTriHopDong*iif(ThoiGianThue>5,0.5,
iif(ThoiGianThue>=3,0.7,1))
--Conlai
Update HOPDONGCHOTHUE
set ConLai= GiaTriHopDong*1.1-DatTruoc
--
Select * from HOPDONGCHOTHUE