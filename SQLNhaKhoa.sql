CREATE DATABASE SQLNhaKhoaKim
USE SQLNhaKhoaKim
drop DATABASE SQLNhaKhoaKim

GO
----------Bảng BÁC SĨ----------
CREATE TABLE BAC_SI
(
 MaBS int PRIMARY KEY NOT NULL DEFAULT 0,
 TenBS Nvarchar(100) NOT NULL Default N'Tên bác sĩ',
 NamSinh_BS Date,
 GioiTinh_BS Nvarchar(5),
 CMND_BS Varchar(9) UNIQUE,
 SĐT_BS Varchar(11),
 DiaChi_BS Nvarchar(100),
 SoPhong int CHECK (SoPhong >= 1)
)

GO
----------Bảng CA TRỰC----------
CREATE TABLE CA_TRUC
(
 MaBS int NOT NULL DEFAULT 0,
 NgayTruc datetime,
 CaTruc Nvarchar(40),

----------Khóa ngoại----------
 FOREIGN KEY(MaBS) REFERENCES dbo.BAC_SI(MaBS)
)

GO
----------Bảng BỆNH NHÂN----------
CREATE TABLE BENH_NHAN
(
 MaBN int PRIMARY KEY NOT NULL DEFAULT 0,
 TenBN Nvarchar(100) NOT NULL default N'Tên bệnh nhân' ,
 NamSinh_BN Date,
 GioiTinh_BN  Nvarchar(5),
 CMND_BN Varchar(9) UNIQUE,
 SĐT_BN Varchar(11),
 DiaChi_BN Nvarchar(100),
 BaoHiem Varchar(100),
)

----------Bảng ĐƠN THUỐC----------
CREATE TABLE DON_THUOC
(
 MaDT int PRIMARY KEY NOT NULL DEFAULT 0,
 MaBS int,
 MaBN int,
 LoiDan Nvarchar (200),

----------Khóa ngoại----------
FOREIGN KEY(MaBS) REFERENCES dbo.BAC_SI(MaBS),
FOREIGN KEY(MaBN) REFERENCES dbo.BENH_NHAN(MaBN)
)

GO
----------Bảng CHI TIẾT ĐƠN THUỐC----------
CREATE TABLE CHI_TIET_DON_THUOC
(
 MaDT int NOT NULL DEFAULT 0,
 TenThuoc Nvarchar (100) NOT NULL,
 SoLuong int CHECK (SoLuong >=1),
 TenDonVi varchar(10),
 CachDung Nvarchar(200),
 GhiChu Nvarchar(200),

----------Khóa ngoại----------
 FOREIGN KEY(MaDT) REFERENCES dbo.DON_THUOC(MaDT)
)

GO
----------Bảng BỆNH ÁN----------
CREATE TABLE BENH_AN
(
 MaBA int PRIMARY KEY NOT NULL DEFAULT 0,
 MaBN int NOT NULL,
 MaBS int NOT NULL,
 MaDT int ,
 NgayKham datetime ,
 KetQua Nvarchar(100),
 NgayLap datetime NOT NULL DEFAULT 0,
 ChuY Nvarchar(200) ,
 

----------Khóa ngoại----------
 FOREIGN KEY(MaBN) REFERENCES dbo.BENH_NHAN(MaBN),
 FOREIGN KEY(MaBS) REFERENCES dbo.BAC_SI(MaBS),
 FOREIGN KEY(MaDT) REFERENCES dbo.DON_THUOC(MaDT)
)
GO

----------Bảng ĐĂNG NHẬP----------
CREATE TABLE DANG_NHAP
(
 ID Varchar(40) PRIMARY KEY,
 Matkhau Varchar(40)
)

GO
----------Bảng TIẾP TÂN-----------
CREATE TABLE TIEP_TAN
(
 MaTT int PRIMARY KEY NOT NULL DEFAULT 0,
 TenTT nvarchar(100),
 NamSinh_TT Date,
 GioiTinh_TT Nvarchar(5),
 CMND_TT Varchar(9) UNIQUE,
 SĐT_TT varchar(11),
 DiaChi_TT Nvarchar(100),
)
GO

----------Bảng DỊCH VỤ----------
CREATE TABLE DICH_VU
(
 MaDV int PRIMARY KEY NOT NULL DEFAULT 0,
 TenDV Nvarchar(100),
 Gia Money
)
GO

----------Bảng HÓA ĐƠN----------
CREATE TABLE HOA_DON
(
 MaHD int PRIMARY KEY NOT NULL DEFAULT 0,
 MaBN int,
 MaTT int,
 TongTien Money,

----------Khóa ngoại----------
 FOREIGN KEY(MaBN) REFERENCES dbo.BENH_NHAN(MaBN),
 FOREIGN KEY(MaTT) REFERENCES dbo.TIEP_TAN(MaTT)
)
GO

----------Bảng CHI TIẾT HÓA ĐƠN----------
CREATE TABLE CHI_TIET_HOA_DON
(
 MaHD int NOT NULL DEFAULT 0,
 MaDV int,
 DonGia Money,
 SoLuong int CHECK (SoLuong >=1),

----------Khóa ngoại----------
 FOREIGN KEY(MaHD) REFERENCES dbo.HOA_DON(MaHD),
 FOREIGN KEY(MaDV) REFERENCES dbo.DICH_VU(MaDV)
)
GO 

----------Bảng LỊCH HẸN KHÁM----------
CREATE TABLE LICH_HEN_KHAM
(
 MaLHK int PRIMARY KEY NOT NULL DEFAULT 0,
 MaBN int NOT NULL,
 NgayGioHenKham datetime,

----------Khóa ngoại----------
 FOREIGN KEY(MaBN) REFERENCES dbo.BENH_NHAN(MaBN)
)
GO
----------------------------------Insert Into-------------------------------------------------------
                        ----------Bảng BÁC SĨ----------
INSERT INTO BAC_SI (MaBS, TenBS, NamSinh_BS, GioiTinh_BS, CMND_BS, SĐT_BS, DiaChi_BS, SoPhong) 
VALUES (101, N'Nguyễn Hữu Nam', '1977/08/18', N'Nam', 272859117, 0322458811, N'Quảng Nam', 1); 

INSERT INTO BAC_SI (MaBS, TenBS, NamSinh_BS, GioiTinh_BS, CMND_BS, SĐT_BS, DiaChi_BS ,SoPhong) 
VALUES (102, N'Võ Hoàng Yên', '1975/01/01', N'Nam', 272655209, 0339871273, N'Cà Mau', 1); 


                        ----------Bảng CA TRỰC----------
INSERT INTO CA_TRUC (MaBS , NgayTruc, CaTruc) 
VALUES (101, '2022/01/01', N'Ca sáng' );

INSERT INTO CA_TRUC (MaBS , NgayTruc, CaTruc) 
VALUES (101, '2022/01/02', N'Ca sáng');

INSERT INTO CA_TRUC (MaBS , NgayTruc, CaTruc) 
VALUES (101, '2022/01/03', N'Ca sáng');

INSERT INTO CA_TRUC (MaBS , NgayTruc, CaTruc) 
VALUES (101, '2022/01/04', N'Ca sáng');

INSERT INTO CA_TRUC (MaBS , NgayTruc, CaTruc) 
VALUES (101, '2022/01/05', N'Ca sáng');

INSERT INTO CA_TRUC (MaBS , NgayTruc, CaTruc) 
VALUES (101, '2022/01/06', N'Ca sáng');

INSERT INTO CA_TRUC (MaBS , NgayTruc, CaTruc) 
VALUES (101, '2022/01/07', N'Ca sáng');

INSERT INTO CA_TRUC (MaBS , NgayTruc, CaTruc) 
VALUES (102, '2022/01/01', N'Ca chiều' );

INSERT INTO CA_TRUC (MaBS , NgayTruc, CaTruc) 
VALUES (102, '2022/01/02', N'Ca chiều');

INSERT INTO CA_TRUC (MaBS , NgayTruc, CaTruc) 
VALUES (102, '2022/01/03', N'Ca chiều');

INSERT INTO CA_TRUC (MaBS , NgayTruc, CaTruc) 
VALUES (102, '2022/01/04', N'Ca chiều');

INSERT INTO CA_TRUC (MaBS , NgayTruc, CaTruc) 
VALUES (102, '2022/01/05', N'Ca chiều');

INSERT INTO CA_TRUC (MaBS , NgayTruc, CaTruc) 
VALUES (102, '2022/01/06', N'Ca chiều');

INSERT INTO CA_TRUC (MaBS , NgayTruc, CaTruc) 
VALUES (102, '2022/01/07', N'Ca chiều');

                        ----------Bảng BỆNH NHÂN----------
INSERT INTO BENH_NHAN (MaBN, TenBN, NamSinh_BN, GioiTinh_BN, CMND_BN, SĐT_BN, DiaChi_BN, BaoHiem) 
VALUES (201, N'Trần Đức Bo', '1999/01/13', N'Nam', 272866513, 0311223344, N'Tp Hồ Chí Minh', 'GD17956789551');
 
INSERT INTO BENH_NHAN (MaBN, TenBN, NamSinh_BN, GioiTinh_BN, CMND_BN, SĐT_BN, DiaChi_BN, BaoHiem) 
VALUES (202, N'Nguyễn Phương Hằng', '1971/01/26', N'Nữ', 272866551, 0311223344, N'Bình Dương', 'DN574456789147');

INSERT INTO BENH_NHAN (MaBN, TenBN, NamSinh_BN, GioiTinh_BN, CMND_BN, SĐT_BN, DiaChi_BN, BaoHiem) 
VALUES (203, N'Mai Kim Trí', '1995/01/08', N'Nữ', 272866112, 0311223344, N'Tp Hồ Chí Minh', 'CA598456789147');

INSERT INTO BENH_NHAN (MaBN, TenBN, NamSinh_BN, GioiTinh_BN, CMND_BN, SĐT_BN, DiaChi_BN, BaoHiem) 
VALUES (204, N'Trương Quân Ninh', '2001/05/23', N'Nữ', 272866555, 0311223344, N'Tp Hồ Chí Minh', 'SV479456789147');

INSERT INTO BENH_NHAN (MaBN, TenBN, NamSinh_BN, GioiTinh_BN, CMND_BN, SĐT_BN, DiaChi_BN, BaoHiem) 
VALUES (205, N'Nguyễn Minh Khai', '1998/05/13', N'Nam', 272866541, 0311223311, N'Tp Hồ Chí Minh', 'GD179456789147');

INSERT INTO BENH_NHAN (MaBN, TenBN, NamSinh_BN, GioiTinh_BN, CMND_BN, SĐT_BN, DiaChi_BN, BaoHiem) 
VALUES (206, N'Huỳnh Uy Dũng', '1969/07/19', N'Nam', 272866521, 0311223381, N'Bình Định', 'DN552456789147');

INSERT INTO BENH_NHAN (MaBN, TenBN, NamSinh_BN, GioiTinh_BN, CMND_BN, SĐT_BN, DiaChi_BN, BaoHiem) 
VALUES (207, N'Châu Tấn', '1971/12/01', N'Nữ', 272866552, 0311223341, N'Vũng Tàu', 'GD177456789258');

INSERT INTO BENH_NHAN (MaBN, TenBN, NamSinh_BN, GioiTinh_BN, CMND_BN, SĐT_BN, DiaChi_BN, BaoHiem) 
VALUES (208, N'Đàm Vĩnh Hưng', '1997/06/19', N'Nam', 272866789, 0311223335, N'Quảng Nam', 'GD149456789147');

INSERT INTO BENH_NHAN (MaBN, TenBN, NamSinh_BN, GioiTinh_BN, CMND_BN, SĐT_BN, DiaChi_BN, BaoHiem) 
VALUES (209, N'Lê Quang', '1992/02/02', N'Nam', 272866553, 0311223342, N'Tp Hải Phòng', 'GD131456789369');

INSERT INTO BENH_NHAN (MaBN, TenBN, NamSinh_BN, GioiTinh_BN, CMND_BN, SĐT_BN, DiaChi_BN, BaoHiem) 
VALUES (210, N'Võ Hoài Linh', '1989/10/20', N'Nam', 272866159, 0311223357, N'Quảng Nam', 'GD149456789486');

INSERT INTO BENH_NHAN (MaBN, TenBN, NamSinh_BN, GioiTinh_BN, CMND_BN, SĐT_BN, DiaChi_BN, BaoHiem) 
VALUES (211, N'Ngô Diệc Phàm', '1970/11/11', N'Nam', 272866137, 0311223375, N'Tp Hồ Chí Minh', 'GD179456789488');

INSERT INTO BENH_NHAN (MaBN, TenBN, NamSinh_BN, GioiTinh_BN, CMND_BN, SĐT_BN, DiaChi_BN, BaoHiem) 
VALUES (212, N'Dương Mịch', '1985/11/19', N'Nữ', 273866137, 0311443375, N'Tp Hồ Chí Minh', 'GD179456789437');

INSERT INTO BENH_NHAN (MaBN, TenBN, NamSinh_BN, GioiTinh_BN, CMND_BN, SĐT_BN, DiaChi_BN, BaoHiem) 
VALUES (213, N'Ngô Diệc Phi', '1987/11/11', N'Nữ', 273566137, 0344223375, N'Tp Hồ Chí Minh', 'GD179456789419');

                        ----------Bảng ĐƠN THUỐC----------
INSERT INTO DON_THUOC (MaDT , MaBS, MaBN, LoiDan) 
VALUES (301, 102, 205, N'no' );

                        ----------Bảng CHI TIẾT ĐƠN THUỐC----------
INSERT INTO		CHI_TIET_DON_THUOC (MaDT, TenThuoc, SoLuong, TenDonVi, CachDung, GhiChu) 
VALUES (301, N'Clindamycin', 100, 'mg', N'Uống thuốc với ly nước đầy ', N'Không dùng cho người tiền sử bị viêm ruột');

INSERT INTO		CHI_TIET_DON_THUOC (MaDT, TenThuoc, SoLuong, TenDonVi, CachDung, GhiChu) 
VALUES (301, N'Paracetamol', 10, 'mg', N'500mg mỗi 6 giờ', N'Chống chỉ định đối tượng nghiện rượu bia');

INSERT INTO		CHI_TIET_DON_THUOC (MaDT, TenThuoc, SoLuong, TenDonVi, CachDung, GhiChu) 
VALUES (301, N'Efferalgan, ', 100, 'ml', N'Pha 1 viên vào cốc nước', N'Chống chỉ định người bệnh bị suy gan nặng');

INSERT INTO		CHI_TIET_DON_THUOC (MaDT, TenThuoc, SoLuong, TenDonVi, CachDung, GhiChu) 
VALUES (301, N'Amoxicylin', 1, 'gr', N'Sử dụng 1,2gr mỗi 8 giờ', N'Tác dụng phụ');

                        ----------Bảng BỆNH ÁN----------
INSERT INTO BENH_AN (MaBA , MaBN, MaBS, NgayKham, KetQua, NgayLap, ChuY) 
VALUES (401, 201, 101, '2022/01/01 8:00:00', N'Răng thưa', '2022/01/01 08:05:00', N'No');

INSERT INTO BENH_AN (MaBA , MaBN, MaBS, NgayKham, KetQua, NgayLap, ChuY) 
VALUES (402, 202, 102, '2022/01/01 14:00:00', N'Răng hô, vẩu', '2022/01/07 14:05:00', N'No');

INSERT INTO BENH_AN (MaBA , MaBN, MaBS, NgayKham, KetQua, NgayLap, ChuY) 
VALUES (403, 203, 101, '2022/01/02 08:00:00', N'Răng sâu', '2022/01/02 08:30:00', N'No');

INSERT INTO BENH_AN (MaBA , MaBN, MaBS, NgayKham, KetQua, NgayLap, ChuY) 
VALUES (404, 204, 102, '2022/01/02 14:00:00', N'Răng bị nhiễm kháng sinh ở mức độ nhẹ', '2022/01/02 14:30:00', N'No');

INSERT INTO BENH_AN (MaBA , MaBN, MaBS, NgayKham, KetQua, NgayLap, ChuY) 
VALUES (405, 205, 101, '2022/01/03 09:00:00', N'Răng nhiễm hóa chất fluor', '2022/01/03 09:30:00', N'No');

INSERT INTO BENH_AN (MaBA , MaBN, MaBS, MaDT, NgayKham, KetQua, NgayLap, ChuY) 
VALUES (406, 206, 102, 301, '2022/01/03 14:00:00', N'Viêm tủy răng', '2022/01/03 14:05:00',N'No');

INSERT INTO BENH_AN (MaBA , MaBN, MaBS, NgayKham, KetQua, NgayLap, ChuY) 
VALUES (407, 207, 101, '2022/01/04 09:00:00', N'Viêm nha chu', '2022/01/04 09:30:00', N'No');

INSERT INTO BENH_AN (MaBA , MaBN, MaBS, NgayKham, KetQua, NgayLap, ChuY) 
VALUES (408, 208, 102, '2022/01/04 14:00:00', N'Răng bị sứt mẻ', '2022/01/04 14:30:00', N'No');

INSERT INTO BENH_AN (MaBA , MaBN, MaBS, NgayKham, KetQua, NgayLap, ChuY) 
VALUES (409, 209, 101,  '2022/01/05 10:00:00', N'Răng bị mòn men, đen chân răng', '2022/01/05 10:30:00', N'No');

INSERT INTO BENH_AN (MaBA , MaBN, MaBS, NgayKham, KetQua, NgayLap, ChuY) 
VALUES (410, 210, 102, '2022/01/05 14:00:00', N'Sâu răng', '2022/01/05 14:30:00', N'No');

INSERT INTO BENH_AN (MaBA , MaBN, MaBS, NgayKham, KetQua, NgayLap, ChuY) 
VALUES (411, 211, 101, '2022/01/06 10:35:00', N'Sâu răng', '2022/01/06 11:05:00', N'No');

INSERT INTO BENH_AN (MaBA , MaBN, MaBS, NgayKham, KetQua, NgayLap, ChuY) 
VALUES (412, 212, 102, '2022/01/06 14:30:00', N'Răng thưa', '2022/01/06 14:35:00', N'No');

INSERT INTO BENH_AN (MaBA , MaBN, MaBS, NgayKham, KetQua, NgayLap, ChuY) 
VALUES (413, 213, 101, '2022/01/07 10:00:00', N'Răng bị mẻ', '2022/01/07 10:05:00', N'No');

INSERT INTO BENH_AN (MaBA , MaBN, MaBS, NgayKham, KetQua, NgayLap, ChuY) 
VALUES (414, 202, 102, '2022/01/07 15:00:00', N'Răng bị mẻ', '2022/01/07 15:05:00', N'No');

INSERT INTO BENH_AN (MaBA , MaBN, MaBS, NgayKham, KetQua, NgayLap, ChuY) 
VALUES (415, 210, 102, '2022/01/07 15:45:00', N'Răng bị mẻ', '2022/01/07 15:50:00', N'No');

						----------Bảng TIẾP TÂN-----------
INSERT INTO TIEP_TAN (MaTT, TenTT, NamSinh_TT, GioiTinh_TT, CMND_TT, SĐT_TT, DiaChi_TT) 
VALUES (501, N'Nguyễn Thị Phương Nga', '1995/02/12', N'Nữ', 272859022, 0353279583, N'Hà Tĩnh');

INSERT INTO TIEP_TAN (MaTT, TenTT, NamSinh_TT, GioiTinh_TT, CMND_TT, SĐT_TT, DiaChi_TT) 
VALUES (502, N'Phan Thị Kim Nhung', '2001/06/26', N'Nữ', 272859067, 0344256883, N'Đồng Nai');

INSERT INTO TIEP_TAN (MaTT, TenTT, NamSinh_TT, GioiTinh_TT, CMND_TT, SĐT_TT, DiaChi_TT) 
VALUES (503, N'Nguyễn Đăng AN Ninh', '1991/03/03', N'Nam', 272859123, 0363999845, N'Bình Dương');

INSERT INTO TIEP_TAN (MaTT, TenTT, NamSinh_TT, GioiTinh_TT, CMND_TT, SĐT_TT, DiaChi_TT) 
VALUES (504, N'Phạm Hoàng Yến', '1999/11/12', N'Nữ', 272859068, 0929650233, N'Vũng Tàu');

						----------Bảng DỊCH VỤ----------
INSERT INTO DICH_VU (MaDV, TenDV, Gia) 
VALUES (601, N'Bọc răng sứ', 3000000);

INSERT INTO DICH_VU (MaDV, TenDV, Gia) 
VALUES (602, N'Nhổ răng khôn', 800.000);

INSERT INTO DICH_VU (MaDV, TenDV, Gia)
VALUES (603, N'Cấy ghép implant', 34000000);

INSERT INTO DICH_VU (MaDV, TenDV, Gia) 
VALUES (604, N'Bệnh lý nha chu', 1000000);

INSERT INTO DICH_VU (MaDV, TenDV, Gia) 
VALUES (605, N'Niềng răng thẩm mỹ', 50000000);

INSERT INTO DICH_VU (MaDV, TenDV, Gia) 
VALUES (606, N'Điều trị tủy', 3000000);

INSERT INTO DICH_VU (MaDV, TenDV, Gia) 
VALUES (607, N'Mặt dán sứ Veneer', 500000);

INSERT INTO DICH_VU (MaDV, TenDV, Gia) 
VALUES (608, N'Hàm trám răng', 500000);

INSERT INTO DICH_VU (MaDV, TenDV, Gia) 
VALUES (609, N'Tẩy trắng răng', 3000000);

INSERT INTO DICH_VU (MaDV, TenDV, Gia) 
VALUES (610, N'Chăm sóc răng miệng cho phụ nữ', 2000000);

						----------Bảng HÓA ĐƠN----------
INSERT INTO HOA_DON (MaHD, MaBN, MaTT, TongTien) 
VALUES (701, 201, 501, 9000000); 

INSERT INTO HOA_DON (MaHD, MaBN, MaTT, TongTien) 
VALUES (702, 202, 502, 50000000); 

INSERT INTO HOA_DON (MaHD, MaBN, MaTT, TongTien) 
VALUES (703, 203, 503, 50000); 

INSERT INTO HOA_DON (MaHD, MaBN, MaTT, TongTien) 
VALUES (704, 204, 504, 3000000); 

INSERT INTO HOA_DON (MaHD, MaBN, MaTT, TongTien) 
VALUES (705, 205, 501, 3000000); 

INSERT INTO HOA_DON (MaHD, MaBN, MaTT, TongTien) 
VALUES (706, 206, 502, 3000000); 

INSERT INTO HOA_DON (MaHD, MaBN, MaTT, TongTien) 
VALUES (707, 207, 503, 1000000); 

INSERT INTO HOA_DON (MaHD, MaBN, MaTT, TongTien) 
VALUES (708, 208, 504, 6000000); 

INSERT INTO HOA_DON (MaHD, MaBN, MaTT, TongTien) 
VALUES (709, 209, 501, 3000000); 

INSERT INTO HOA_DON (MaHD, MaBN, MaTT, TongTien) 
VALUES (710, 210, 502, 2000000); 

INSERT INTO HOA_DON (MaHD, MaBN, MaTT, TongTien) 
VALUES (711, 211, 502, 1500000);

INSERT INTO HOA_DON (MaHD, MaBN, MaTT, TongTien) 
VALUES (712, 212, 503, 1200000); 

INSERT INTO HOA_DON (MaHD, MaBN, MaTT, TongTien) 
VALUES (713, 213, 504, 3000000);

INSERT INTO HOA_DON (MaHD, MaBN, MaTT, TongTien) 
VALUES (714, 202, 501, 1000000);

INSERT INTO HOA_DON (MaHD, MaBN, MaTT, TongTien) 
VALUES (715, 210, 501, 2000000);

						----------Bảng CHI TIẾT HÓA ĐƠN----------
INSERT INTO CHI_TIET_HOA_DON (MaHD, MaDV, DonGia, SoLuong) 
VALUES (701, 601, 3000000, 1);

INSERT INTO CHI_TIET_HOA_DON (MaHD, MaDV, DonGia, SoLuong) 
VALUES (702, 605, 50000000, 1);

INSERT INTO CHI_TIET_HOA_DON (MaHD, MaDV, DonGia, SoLuong) 
VALUES (703, 608, 500000, 1);

INSERT INTO CHI_TIET_HOA_DON (MaHD, MaDV, DonGia, SoLuong) 
VALUES (704, 609, 3000000, 1);

INSERT INTO CHI_TIET_HOA_DON (MaHD, MaDV, DonGia, SoLuong) 
VALUES (705, 609, 3000000, 1);

INSERT INTO CHI_TIET_HOA_DON (MaHD, MaDV, DonGia, SoLuong) 
VALUES (706, 606, 3000000, 1);

INSERT INTO CHI_TIET_HOA_DON (MaHD, MaDV, DonGia, SoLuong) 
VALUES (707, 604, 1000000, 1);

INSERT INTO CHI_TIET_HOA_DON (MaHD, MaDV, DonGia, SoLuong) 
VALUES (708, 608, 1000000, 2);

INSERT INTO CHI_TIET_HOA_DON (MaHD, MaDV, DonGia, SoLuong) 
VALUES (709, 609, 3000000, 1);

INSERT INTO CHI_TIET_HOA_DON (MaHD, MaDV, DonGia, SoLuong) 
VALUES (710, 608, 500000, 4);

INSERT INTO CHI_TIET_HOA_DON (MaHD, MaDV, DonGia, SoLuong) 
VALUES (711, 608, 500000, 3);

INSERT INTO CHI_TIET_HOA_DON (MaHD, MaDV, DonGia, SoLuong) 
VALUES (712, 601, 3000000, 3);

INSERT INTO CHI_TIET_HOA_DON (MaHD, MaDV, DonGia, SoLuong) 
VALUES (713, 601, 3000000, 1);

INSERT INTO CHI_TIET_HOA_DON (MaHD, MaDV, DonGia, SoLuong) 
VALUES (714, 608, 500000, 2);

INSERT INTO CHI_TIET_HOA_DON (MaHD, MaDV, DonGia, SoLuong) 
VALUES (715, 601, 3000000, 4);

						----------Bảng LỊCH KHÁM BỆNH----------
INSERT INTO LICH_HEN_KHAM (MaLHK , MaBN, NgayGioHenKham) 
VALUES (801, 201, '2022/01/07 14:00:00');

INSERT INTO LICH_HEN_KHAM (MaLHK , MaBN, NgayGioHenKham) 
VALUES (802, 202, '2022/01/07 08:00:00');

INSERT INTO LICH_HEN_KHAM (MaLHK , MaBN, NgayGioHenKham) 
VALUES (803, 206, '2022/01/09 08:15:00');

INSERT INTO LICH_HEN_KHAM (MaLHK , MaBN, NgayGioHenKham) 
VALUES (804, 207, '2022/01/08 08:00:00');

INSERT INTO LICH_HEN_KHAM (MaLHK , MaBN, NgayGioHenKham) 
VALUES (805, 211, '2022/01/14 08:00:00');

INSERT INTO LICH_HEN_KHAM (MaLHK , MaBN, NgayGioHenKham) 
VALUES (806, 208, '2022/01/14 14:00:00');