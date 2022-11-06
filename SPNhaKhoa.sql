USE SQLNhaKhoaKim
						----------STORED PROCEDURE----------

						----------Bảng BÁC SĨ----------
-- 1. Stored Procedure dùng để thêm dữ liệu vào bảng bác sĩ ---
CREATE PROCEDURE sp_addBSData
(@MaBS int, @TenBS nvarchar(100), @NamSinh_BS date, @GioiTinh_BS nvarchar(5),
@CMND_BS varchar(9), @SĐT_BS varchar(11), @DiaChi_BS nvarchar(100), @SoPhong int)
AS
	IF EXISTS (SELECT * FROM BAC_SI WHERE @MaBS = MaBS)
	begin
		raiserror(N'Mã bác sĩ này đã tồn tại', 16, 1)
	end
	INSERT INTO BAC_SI
	VALUES(@MaBS, @TenBS, @NamSinh_BS, @GioiTinh_BS, @CMND_BS, @SĐT_BS, @DiaChi_BS, @SoPhong)
	print N'Thêm thành công'

-- Thực thi
sp_addBSData 105, N'Lê Thanh Tâm', '1964-12-03', 'Nam', '242342', '09238473', N'Đồng Nai', 1
select * from BAC_SI
drop procedure sp_addBSData

-- 2. Stored Procedure dùng để cập nhật ca trực của bác sĩ ---
CREATE PROCEDURE sp_UpdateCaTruc
(@MaBS int, @NgayTruc datetime, @CaTruc nvarchar(40))
AS
	IF NOT EXISTS (SELECT * FROM CA_TRUC WHERE @MaBS = MaBS)
	begin
		raiserror(N'Mã bác sĩ này không tồn tại', 16, 1)
	end
BEGIN
	UPDATE Ca_Truc
	SET
		CaTruc = @CaTruc
	WHERE
		NgayTruc = @NgayTruc
    AND	MaBS = @MaBS
END

-- Thực thi
exec sp_UpdateCaTruc 101, '2022-01-01', N'Ca sáng'
SELECT * FROM CA_TRUC
drop procedure sp_UpdateCaTruc

-- 3. Stored Procedure dùng để cập nhật thông tin của bác sĩ ---
CREATE PROCEDURE sp_UpdateBSInfo
(@MaBS int, @TenBS nvarchar(100), @NamSinh_BS date, @GioiTinh_BS nvarchar(5),
@CMND_BS varchar(9), @SĐT_BS varchar(11), @DiaChi_BS nvarchar(100), @SoPhong int)
AS
	IF NOT EXISTS (SELECT * FROM BAC_SI WHERE @MaBS = MaBS)
	begin
		raiserror(N'Mã bác sĩ này không tồn tại', 16, 1)
	end
BEGIN
	UPDATE BAC_SI
	SET
		TenBS = @TenBS,
		NamSinh_BS = @NamSinh_BS,
		GioiTinh_BS = @GioiTinh_BS,
		CMND_BS = @CMND_BS,
		SĐT_BS = @SĐT_BS,
		DiaChi_BS = @DiaChi_BS,
		SoPhong = @SoPhong
	WHERE
		MaBS = @MaBS
END

-- Thực thi
sp_UpdateBSInfo 105, N'Đỗ Phương Oanh', '1994-12-09', N'Nữ', '272655543', '339877488', N'Vũng Tàu', 4
SELECT * FROM BAC_SI
drop procedure sp_UpdateBSInfo

-- 4. Stored Procedure dùng để xóa 1 bác sĩ ---
CREATE PROC Xoa_Mot_BAC_SI
(
	@MaBS Int
)
AS
BEGIN
	DELETE FROM [dbo].[BAC_SI] WHERE MaBS = @MaBS
	DELETE FROM [dbo].[CA_TRUC] WHERE MaBS = @MaBS
	DELETE FROM [dbo].[BENH_AN] WHERE MaBS = @MaBS
	DELETE FROM [dbo].[DON_THUOC] WHERE MaBS = @MaBS
END

-- Thực thi
exec Xoa_Mot_BAC_SI 106
SELECT * FROM BAC_SI
drop procedure Xoa_Mot_BAC_SI

-- 5. Stored Procedure dùng để Tim kiem ca truc cua bac si -----
create procedure sp_ThongtinCatruc
@mabs int 
as
begin 
select	a.MaBS ,a.TenBS,b.NgayTruc, b.CaTruc 
from BAC_SI a,CA_TRUC b
where a.MaBS=b.MaBS and a.MaBS= @mabs
end

-- Thực thi
exec sp_ThongtinCatruc 102
SELECT * FROM CA_TRUC
drop procedure sp_ThongtinCatruc

-- 6. Stored Procedure dùng xể Xuat ra thong tin cac benh nhan ma bac si da kham --
create procedure sp_Thongtinhenkham 
@mabs int 
as
begin 
if exists (select *from BAC_SI where BAC_SI.MaBS = @mabs )
begin 
select	a.MaBS , c.MaBN,c.TenBN,c.SĐT_BN,b.NgayKham, b.KetQua
from BAC_SI a,BENH_AN b,BENH_NHAN c
where a.MaBS=b.MaBS and b.MaBN= c.MaBN and a.MaBS= @mabs
end
else print N'Không tìm thấy bác sĩ này!!!' 
end

-- Thực thi
drop procedure sp_Thongtinhenkham
exec sp_Thongtinhenkham 102

						----------Bảng BỆNH NHÂN----------
-- 7. Stored Procedure dùng để thêm dữ liệu vào bảng bệnh nhân ---
CREATE PROCEDURE sp_addBNData
(@MaBN int, @TenBN nvarchar(100), @NamSinh_BN date, @GioiTinh_BN nvarchar(5),
@CMND_BN varchar(9), @SĐT_BN varchar(11), @DiaChi_BN nvarchar(100), @BaoHiem varchar(100))
AS
	IF EXISTS (SELECT * FROM BENH_NHAN WHERE @MaBN = MaBN)
	begin
		raiserror(N'Mã bệnh nhân này đã tồn tại', 16, 1)
	end
	INSERT INTO BENH_NHAN 
	VALUES(@MaBN, @TenBN, @NamSinh_BN, @GioiTinh_BN, @CMND_BN, @SĐT_BN, @DiaChi_BN, @BaoHiem)
	print N'Thêm thành công'

-- Thực thi
sp_addBNData 214, N'Nguyễn Thanh Sơn', '1964-12-03', 'nam', '242342', 'GD179456786642', N'Đồng Nai', 'GD179456784325'
select * from BENH_NHAN
drop procedure sp_addBNData
delete from BENH_NHAN where MaBN = 214

-- 8. Stored Procedure dùng để cập nhật thông tin của bệnh nhân ---
CREATE PROCEDURE sp_UpdateBNInfo
(@MaBN int, @TenBN nvarchar(100), @NamSinh_BN date, @GioiTinh_BN nvarchar(5),
@CMND_BN varchar(9), @SĐT_BN varchar(11), @DiaChi_BN nvarchar(100), @BaoHiem varchar(100))
AS
	IF NOT EXISTS (SELECT * FROM BENH_NHAN WHERE @MaBN = MaBN)
	begin
		raiserror(N'Mã bệnh nhân này không tồn tại', 16, 1)
	end
BEGIN
	UPDATE BENH_NHAN
	SET
		TenBN = @TenBN,
		NamSinh_BN = @NamSinh_BN,
		GioiTinh_BN = @GioiTinh_BN,
		CMND_BN = @CMND_BN,
		SĐT_BN = @SĐT_BN,
		DiaChi_BN = @DiaChi_BN,
		BaoHiem = @BaoHiem
	WHERE
		MaBN = @MaBN
END

-- Thực thi
sp_UpdateBNInfo 214, N'Nguyễn Quang Tuấn', '1992-02-09', N'Nam', '31122463', '311223342', N'Tp Hải Phòng', 'GD131456789369'
SELECT * FROM BENH_NHAN
drop procedure sp_UpdateBNInfo

-- 9. Stored Procedure dùng để xóa 1 bệnh nhân --
CREATE PROC Xoa_Mot_BENH_NHAN
(
@MaBN Int
)
AS
BEGIN
	DELETE FROM [dbo].[BENH_NHAN] WHERE MaBN = @MaBN
	DELETE FROM [dbo].[BENH_AN] WHERE MaBN = @MaBN
	DELETE FROM [dbo].[DON_THUOC] WHERE MaBN = @MaBN
	DELETE FROM [dbo].[HOA_DON] WHERE MaBN = @MaBN
	DELETE FROM [dbo].[LICH_HEN_KHAM] WHERE MaBN = @MaBN
END

-- Thực thi
exec Xoa_Mot_BENH_NHAN 214
SELECT * FROM BENH_NHAN
drop procedure Xoa_Mot_BENH_NHAN

--- 10. Stored Procedure dùng để Nhap Ma Benh nhan xem thong tin benh nhan va lich hen kham  -------
create procedure sp_TTbenhNhanVaLichHenKham 
@mabn int 
as 
begin
if exists (select *from BENH_NHAN ,LICH_HEN_KHAM where BENH_NHAN.MaBN= @mabn and LICH_HEN_KHAM.MaBN =@mabn)
begin 
select a.MaBN, a.TenBN, a.SĐT_BN, b.NgayGioHenKham
from BENH_NHAN a, LICH_HEN_KHAM b
where a.MaBN= b.MaBN  and a.MaBN= @mabn 
end
else if exists (select *from BENH_NHAN  where BENH_NHAN.MaBN= @mabn)
begin 
	print N'Bệnh nhân không có lịch hẹn khám'
end
else print N'Không tìmt thấy bệnh nhân này'
end

-- Thực thi
exec sp_TTbenhNhanVaLichHenKham 208
drop procedure sp_TTbenhNhanVaLichHenKham

-- 11. Stored Procedure dùng để tim kiem thong tin benh nhan --
create procedure sp_thongTinBenhNhan
@mabn int 
as 
begin
if exists(select *from BENH_NHAN where BENH_NHAN.MaBN= @mabn )
begin 
	print N'Thông tin Bệnh Nhân' 
	select *from BENH_NHAN where BENH_NHAN.MaBN= @mabn;
end
else print N'Không tìm thấy thông tin bệnh nhân này !!!' 
end

-- Thực thi
exec sp_thongTinBenhNhan 205
drop procedure sp_thongTinNhanVien

						----------Bảng ĐƠN THUỐC----------
-- 12. Stored Procedure dùng để xóa 1 đơn thuốc --
CREATE PROC Xoa_Mot_Don_Thuoc
(
@MaDT int
)
AS
BEGIN
    DELETE FROM [dbo].[DON_THUOC] WHERE MaDT = @MaDT
	DELETE FROM [dbo].[BENH_AN] WHERE MaDT = @MaDT
	DELETE FROM [dbo].[CHI_TIET_DON_THUOC] WHERE MaDT = @MaDT
END
GO

-- Thực thi
exec Xoa_Mot_Don_Thuoc 301
select * from DON_THUOC
drop procedure Xoa_Mot_Don_Thuoc

-- 13. Stored Procedure dùng để Update don thuoc --
create procedure sp_updateTTDonThuoc
 @maDT int,
 @LoiDan Nvarchar (200)
	as 
 begin 
		update DON_THUOC set LoiDan= @LoiDan 
		where MaDT= @maDT 
 end

 -- Thực thi
 exec sp_updateTTDonThuoc 301, N've sinh rang mieng sach se' 

						----------Bảng BỆNH ÁN----------
-- 14. Stored Procedure dùng để xóa 1 bệnh án --
CREATE PROC Xoa_Mot_Benh_An
(
@MaBA int
)
AS
BEGIN
    DELETE FROM [dbo].[BENH_AN] WHERE MaBA = @MaBA 
END

 -- Thực thi
 exec Xoa_Mot_Benh_An 401
 select * from BENH_AN
 drop proc Xoa_Mot_Benh_An

-- 15. Stored Procedure dùng để Kiem tra benh an cua benh nhan thong qua ma benh nhan------
create procedure sp_Thongtinbenhan
@mabn int 
as
begin 
select	a.MaBN ,a.TenBN ,b.NgayKham,b.KetQua, b.NgayLap, b.ChuY 
from BENH_NHAN a,BENH_AN b
where a.MaBN=b.MaBN and a.MaBN= @mabn
end
drop procedure sp_Thongtinbenhan
exec sp_Thongtinbenhan 203

						----------Bảng TIẾP TÂN----------
-- 16. Stored Procedure dùng để thêm dữ liệu vào bảng tiếp tân --
CREATE PROCEDURE sp_addTTData
(@MaTT int, @TenTT nvarchar(100), @NamSinh_TT date, @GioiTinh_TT nvarchar(5),
@CMND_TT varchar(9), @SĐT_TT varchar(11), @DiaChi_TT nvarchar(100))
AS
	IF EXISTS (SELECT * FROM TIEP_TAN WHERE @MaTT = MaTT)
	begin
		raiserror(N'Mã tiếp tân này đã tồn tại', 16, 1)
	end
	INSERT INTO TIEP_TAN
	VALUES(@MaTT, @TenTT, @NamSinh_TT, @GioiTinh_TT, @CMND_TT, @SĐT_TT, @DiaChi_TT)
	print N'Thêm thành công'

-- Thực thi
sp_addTTData 505, N'Trương Ngọc Ánh', '1980-10-12', 'Nữ', '272859312', '909645642', N'Hà Tĩnh'
select * from TIEP_TAN
drop procedure sp_addTTData

-- 17. Stored Procedure dùng để cập nhật thông tin của tiếp tân --
CREATE PROCEDURE sp_UpdateTTInfo
(@MaTT int, @TenTT nvarchar(100), @NamSinh_TT date, @GioiTinh_TT nvarchar(5),
@CMND_TT varchar(9), @SĐT_TT varchar(11), @DiaChi_TT nvarchar(100))
AS
	IF NOT EXISTS (SELECT * FROM TIEP_TAN WHERE @MaTT = MaTT)
	begin
		raiserror(N'Mã tiếp tân này không tồn tại', 16, 1)
	end
BEGIN
	UPDATE TIEP_TAN
	SET
		TenTT = @TenTT,
		NamSinh_TT = @NamSinh_TT,
		GioiTinh_TT = @GioiTinh_TT,
		CMND_TT = @CMND_TT,
		SĐT_TT = @SĐT_TT,
		DiaChi_TT = @DiaChi_TT
	WHERE
		MaTT = @MaTT
END

-- Thực thi
sp_UpdateTTInfo 505, N'Đỗ Phương Anh', '1980-10-12', N'Nữ', '272859312', '909645642', N'Hà Tĩnh'
SELECT * FROM TIEP_TAN
drop procedure sp_UpdateTTInfo

-- 18. Stored Procedure dùng để xoá 1 tiếp tân --
CREATE PROC Xoa_Mot_Tiep_Tan
(
@MaTT int
)
AS
BEGIN
    DELETE FROM [dbo].[TIEP_TAN] WHERE MaTT = @MaTT
	DELETE FROM [dbo].[HOA_DON] WHERE MaTT = @MaTT
END 

-- Thực thi
exec Xoa_Mot_Tiep_Tan 505
SELECT * FROM TIEP_TAN
drop procedure Xoa_Mot_Tiep_Tan

						----------Bảng DỊCH VỤ----------
-- 19. Stored Procedure dùng để thêm dữ liệu vào bảng dịch vụ ---
CREATE PROCEDURE sp_addDVData
(@MaDV int, @TenDV nvarchar(100), @Gia money)
AS
	IF EXISTS (SELECT * FROM DICH_VU WHERE @MaDV = MaDV)
	begin
		raiserror(N'Mã dịch vụ này đã tồn tại', 16, 1)
	end
	INSERT INTO DICH_VU
	VALUES(@MaDV, @TenDV, @Gia)
	print N'Thêm thành công'

-- Thực thi
sp_addDVData 611, N'Niềng răng tàng hình', 3000000
select * from DICH_VU
drop procedure sp_addDVData

-- 20. Stored Procedure dùng để cập nhật dịch vụ ---
create procedure sp_updateTTDichVu
 @MaDV int ,
 @TenDV Nvarchar(100),
 @Gia Money 
  as 
  begin 
  update HOA_DON set TongTien = TongTien - (select DonGia*SoLuong from CHI_TIET_HOA_DON where HOA_DON.MaHD = CHI_TIET_HOA_DON.MaHD and MaDV = @MaDV)
	where HOA_DON.MaHD in(select MaHD 
					  from CHI_TIET_HOA_DON
					  where MaDV = @MaDV)
	update DICH_VU set TenDV=@TenDV,Gia= @Gia
	where MaDV = @MaDV
	update CHI_TIET_HOA_DON set DonGia = @Gia
	where MaDV = @MaDV
	update HOA_DON set TongTien = TongTien + (select DonGia*SoLuong from CHI_TIET_HOA_DON where HOA_DON.MaHD = CHI_TIET_HOA_DON.MaHD and MaDV = @MaDV)
	where HOA_DON.MaHD in(select MaHD 
					  from CHI_TIET_HOA_DON
					  where MaDV = @MaDV)
	end 

-- Thực thi
sp_updateTTDichVu 611, N'Niềng răng không mắc cài', 3000000
SELECT * FROM DICH_VU
drop procedure sp_UpdateDVInfo

-- 21. Stored Procedure dùng để xoá 1 dịch vụ ---
CREATE proc Xoa_Mot_Dich_Vu
(
@MaDV int
)
AS
BEGIN
    DELETE FROM [dbo].[DICH_VU] WHERE MaDV = @MaDV
	DELETE FROM [dbo].[CHI_TIET_HOA_DON] WHERE MaDV = @MaDV
END 

-- Thực thi
exec Xoa_Mot_Dich_Vu 611
SELECT * FROM DICH_VU
drop procedure Xoa_Mot_Dich_Vu

						----------Bảng HÓA ĐƠN----------
-- 22. Stored Procedure dùng để xoá 1 hoá đơn --
CREATE PROC Xoa_Mot_Hoa_Don
(
@MaHD int
)
AS
BEGIN
    DELETE FROM [dbo].[HOA_DON] WHERE MaHD = @MaHD
	DELETE FROM [dbo].[CHI_TIET_HOA_DON] WHERE MaHD = @MaHD
END
GO

-- Thực thi
exec Xoa_Mot_Hoa_Don 701
SELECT * FROM HOA_DON
drop procedure Xoa_Mot_Hoa_Don

-- 23. Stored Procedure dùng để them chi tiet hoa don --
	create proc sp_TaoCTHoaDon
	@MaHoaDon int,
	@MaDV int, 
	@Soluong int 
	as
	begin

			insert into CHI_TIET_HOA_DON(MaHD,MaDV,SoLuong,DonGia)
			select @MaHoaDon ,@MaDV, @Soluong,DICH_VU.Gia  
			from DICH_VU
			where  DICH_VU.MaDV = @MaDV
			update HOA_DON set TongTien= TongTien+ (select DICH_VU.Gia*@Soluong from DICH_VU where DICH_VU.MaDV = @MaDV) 
			where HOA_DON.MaHD = @MaHoaDon
	end	
	--thuc thi
	drop proc sp_TaoCTHoaDon
	exec sp_TaoCTHoaDon 701,608,2

-- 24. Stored Procedure dùng để Load hoa don
	create proc sp_XuatHoaDon
	@MaHoaDon int
	as
	begin
		select *from HOA_DON
		where HOA_DON.MaHD = @MaHoaDon
	end

	-- thuc thi
	drop proc sp_
	exec sp_XuatHoaDon 701

						----------Bảng LỊCH HẸN KHÁM----------
-- 25. Stored Procedure dùng để thêm dữ liệu vào bảng lịch hẹn khám ---
CREATE PROCEDURE sp_addLHKData
(@MaLHK int, @MaBN int, @NgayGioHenKham datetime)
AS
	IF EXISTS (SELECT * FROM LICH_HEN_KHAM WHERE @MaLHK = MaLHK)
	begin
		raiserror(N'Mã lịch hẹn này đã tồn tại', 16, 1)
	end
	INSERT INTO LICH_HEN_KHAM
	VALUES(@MaLHK, @MaBN, @NgayGioHenKham)
	print N'Thêm thành công'

-- Thực thi
sp_addLHKData 807, 203, '2022/11/01 13:00:00'
select * from LICH_HEN_KHAM
drop procedure sp_addLHKData

--26. Stored Procedure dùng để cập nhật thông tin lịch hẹn khám ---
CREATE PROCEDURE sp_UpdateLHKInfo
(@MaLHK int, @MaBN int, @NgayGioHenKham datetime)
AS
	IF NOT EXISTS (SELECT * FROM LICH_HEN_KHAM WHERE @MaLHK = MaLHK)
	begin
		raiserror(N'Mã lịch hẹn này không tồn tại', 16, 1)
	end
BEGIN
	UPDATE LICH_HEN_KHAM
	SET
		NgayGioHenKham = @NgayGioHenKham
	WHERE
		MaLHK = @MaLHK
	AND	MaBN = @MaBN
END

-- Thực thi
sp_UpdateLHKInfo 807, 203, '2022-11-02 14:00:00'
SELECT * FROM LICH_HEN_KHAM
drop procedure sp_UpdateLHKInfo

-- 27. Stored Procedure dùng để xóa lịch hẹn khám----------
CREATE PROC Xoa_Mot_Lich_hen_Kham
(
@MaLHK Int
)
AS
BEGIN
    DELETE FROM [dbo].[LICH_HEN_KHAM] WHERE MaLHK = @MaLHK
END

-- Thực thi
exec Xoa_Mot_Lich_hen_Kham 807
SELECT * FROM LICH_HEN_KHAM
drop procedure Xoa_Mot_Lich_hen_Kham

---------NHAN VIEN TRONG PHONG KHAM ----------
-- 28. Stored Procedure dùng đểtim kiem ra thong tin nhan vien trong phong kham ----
create procedure sp_thongTinNhanVien
@manv int 
as 
begin
if exists(select *from BAC_SI where BAC_SI.MaBS= @manv )
begin 
	print N'Thông tin Bác Sĩ!' 
	select *from BAC_SI where BAC_SI.MaBS= @manv;
end
else if exists(select *from TIEP_TAN where TIEP_TAN.MaTT= @manv )
begin 
	print N'Thông tin Tiếp Tân!' 
	select *from TIEP_TAN where TIEP_TAN.MaTT= @manv;
end
else print N'Không tìm thấy thông tin nhân viên này !!!' 
end

-- Thực thi
exec sp_thongTinNhanVien 501
drop procedure sp_thongTinNhanVien 

