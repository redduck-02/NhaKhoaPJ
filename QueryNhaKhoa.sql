USE SQLNhaKhoaKim
			----------SELECT----------
---1. In ra danh sách bệnh nhân ở thành phố Hồ Chí Minh---
SELECT
	MaBN as N'Mã bệnh nhân', TenBN as N'Họ và tên',
	NamSinh_BN as N'Năm sinh', CMND_BN as 'CMND',
	SĐT_BN as N'Số điện thoại', DiaCHi_BN as N'Địa chỉ',
	BaoHiem as N'Mã bảo hiểm'
FROM BENH_NHAN
WHERE DiaChi_BN = N'Tp Hồ Chí Minh'

---2. In ra danh sách bệnh án (MaBA, MaBN, MaBS) bị sâu răng---
SELECT MaBA as N'Mã bệnh án', MaBN as N'Mã bệnh nhân', MaBS as N'Mã bác sĩ',
		NgayKham as N'Ngày khám', KetQua as N'Kết quả', NgayLap as N'Ngày lập',
		LichTaiKham as N'Lịch tái khám', ChuY as N'Chú ý'
FROM BENH_AN
WHERE KetQua = N'Sâu răng'

---3. In ra số hóa đơn và tổng tiền của bệnh nhân có mã 208---
SELECT MaHD as N'mã hoá đơn', HD.MaBN as N'Mã bệnh nhân',
	BN.TenBN as N'Tên bệnh nhân', TongTien as N'Tổng tiền'
FROM HOA_DON as HD, BENH_NHAN as BN
WHERE
	HD.MaBN = 208
AND
	BN.MaBN = 208

---4. In ra trị giá hóa đơn cao nhất và thấp nhất ---
SELECT 
	MAX(TongTien) AS N'Hoá đơn có giá trị cao nhất',
	MIN(TongTien) AS N'Hoá đơn có giá trị thấp nhất'
FROM HOA_DON
	

---5. In trị giá trung bình của tất cả hóa đơn trong năm 2022---
SELECT AVG(TongTien) AS 'Giá trung bình của tất cả hoá đơn trong năm 2022'
FROM HOA_DON

---6. Tìm dịch vụ (MaDV, TenDV) có tổng số lượng bệnh nhân thấp nhất trong năm 2022---
SELECT MaDV, TenDV
FROM DICH_VU
WHERE MaDV = (SELECT TOP 1 MaDV
FROM CHI_TIET_HOA_DON
GROUP BY MaDV
ORDER BY SUM(SoLuong) DESC)

---7. Trong 5 bệnh nhân có tổng tiền cao nhất, tìm bệnh nhân dùng nhiều dịch vụ nhất---
SELECT BENH_NHAN.*, HOA_DON.*
FROM BENH_NHAN, HOA_DON
--WHERE 

---8. In ra danh sách bệnh nhân do bác sĩ Võ Hoàng Yên (BS02) điều trị---
--SELECT MaBS, TenBS, MaBN
--FROM BAC_SI
--WHERE MaBS = 

						----------STORED PROCEDURE----------
-- Stored Procedure dùng để thêm dữ liệu vào bảng bác sĩ ---
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
sp_addBSData 105, N'Nguyễn Phương Dịt', '1964-12-03', 'nam', '242342', '09238473', N'Đồng Nai', 1
select * from BAC_SI

-- Stored Procedure dùng để thêm dữ liệu vào bảng bệnh nhân ---
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
sp_addBNData 212, N'Nguyễn Phương Dịt', '1964-12-03', 'nam', '242342', '09238473', N'Đồng Nai', ''
select * from BENH_NHAN
delete from BENH_NHAN where MaBN = 212

-- Stored Procedure dùng để thêm dữ liệu vào bảng tiếp tân ---
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
sp_addTTData 505, N'Phan Thị Phương Nga', '1980-10-12', 'Nữ', '272859312', '909645642', N'Hà Tĩnh'
select * from TIEP_TAN

-- Stored Procedure dùng để cập nhật ca trực của bác sĩ ---
CREATE PROCEDURE sp_UpdateCaTruc
(@MaBS int, @NgayTruc datetime, @CaTruc nvarchar(40))
AS
BEGIN
	UPDATE Ca_Truc
	SET
		CaTruc = @CaTruc
	WHERE
		NgayTruc = @NgayTruc
    AND	MaBS = @MaBS
END

-- Thực thi
DROP PROCEDURE sp_UpdateCaTruc
exec sp_UpdateCaTruc 101, '2022-01-01', N'Ca sáng'
SELECT * FROM CA_TRUC

--- Stored Procedure dùng để in ra thông tin nhân viên trong phòng khám ----
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
exec sp_thongTinNhanVien 505
exec sp_thongTinNhanVien 501

select * from BAC_SI
select * from TIEP_TAN
drop procedure sp_thongTinNhanVien

--- Stored Procedure dùng để xuất ra thông tin các bệnh nhân mà bác sĩ đã khám ---
Create procedure sp_Thongtinhenkham 
@mabs int
as
begin 
if exists (select *from BAC_SI where BAC_SI.MaBS = @mabs )
begin 
select	a.MaBS , c.MaBN,c.TenBN,c.SĐT_BN,b.NgayKham, b.KetQua,b.LichTaiKham
from BAC_SI a,BENH_AN b,BENH_NHAN c
where a.MaBS=b.MaBS and b.MaBN= c.MaBN and a.MaBS= @mabs
end
else print N'Không tìm thấy bác sĩ này!!!' 
end

-- Thực thi
drop procedure sp_Thongtinhenkham
sp_Thongtinhenkham 103

