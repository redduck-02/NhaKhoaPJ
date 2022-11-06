USE SQLNhaKhoaKim

						----------TRIGGER----------
---1. Giá của dịch vụ phải lớn hơn 0---
CREATE TRIGGER TG_CheckgiaDV ON DICH_VU FOR INSERT, UPDATE
AS
BEGIN
	DECLARE @Gia Money
	SELECT @Gia = Gia 
	FROM inserted
	IF(@Gia <= 0)
	BEGIN
	 PRINT N'Giá của dịch vụ phải lớn hơn 0'
	 ROLLBACK TRAN
	END
END
INSERT INTO DICH_VU VALUES (102, 'dddds',-10);

---2. Check tuổi bác sĩ để về hưu---
CREATE TRIGGER TG_Checktuoihuu ON BAC_SI FOR INSERT, UPDATE
AS
BEGIN
      DECLARE @Tuoi Int;
	  DECLARE @GioiTinh Nvarchar;
	  SET @Tuoi = (SELECT (YEAR(GETDATE()) - YEAR(Tmp.NamSinh_BS)) FROM BAC_SI, Inserted AS Tmp
	  WHERE BAC_SI.MaBS = Tmp.MaBS )
	  
	  SET @GioiTinh = (SELECT B.GioiTinh_BS FROM BAC_SI, Inserted AS B
	  WHERE BAC_SI.MaBS = B.MaBS)
	  IF (@GioiTinh = 'Nam')
		BEGIN 
			IF(@Tuoi>=60)
			BEGIN
				PRINT(N'Đã về hưu')
				ROLLBACK TRAN
			END
		END
	  ELSE
		IF(@Tuoi>=55)
			BEGIN
				PRINT(N'Đã về hưu')
				ROLLBACK TRAN
			END
	  END

INSERT INTO BAC_SI (MaBS, TenBS, NamSinh_BS, GioiTinh_BS, CMND_BS, SĐT_BS, DiaChi_BS, SoPhong) 
VALUES (106, N'Phạm Kim Dung', '1960/08/18', N'Nữ', 272859118, 0322458856, N'Quảng Nam', 2);

SELECT * FROM BAC_SI WHERE (Year(GETDATE()) - YEAR(NamSinh_BS)) > 55

---3. Check lịch hẹn khám lớn hơn ngày ---

CREATE TRIGGER TG_CheckNgayKham ON LICH_HEN_KHAM FOR INSERT, UPDATE
AS
BEGIN
	DECLARE @curentDate DateTime;
	SET @curentDate = (SELECT B.NgayGioHenKham FROM LICH_HEN_KHAM, inserted AS B
	WHERE LICH_HEN_KHAM.MaBN = B.MaBN)
	IF((@curentDate - GETDATE()) < 1)
	BEGIN 
		PRINT('Ngày hẹn khám bé hơn ngày hiện tại')
	END
END

INSERT INTO LICH_HEN_KHAM (MaLHK , MaBN, NgayGioHenKham) 
VALUES (809, 213, '2022/01/09 08:15:00');

---4. Bệnh nhân đến khám và lưu lại thông tin bệnh nhân. Các bệnh nhân sẽ được trở thành thành viên và được phân biệt bằng mã riêng biệt.
---4.1:Xét theo tổng giá tiền từ hóa đơn để phân thẻ thành viên: từ 0-5tr là thẻ đồng, 5-10tr là thẻ bạc,  10-20tr thẻ là vàng, 20-50tr thẻ là kim cương---
CREATE TRIGGER TG_Diemtichluy ON HOA_DON FOR INSERT, UPDATE
AS
BEGIN
	DECLARE @tien Money;
	DECLARE @MaBN Int;

	SET @tien = (SELECT hd_Tmp.TongTien FROM HOA_DON, Inserted AS hd_Tmp
	WHERE HOA_DON.MAHD = hd_Tmp.MaHD)

	SET @MaBN = (SELECT hd_Tmp.MaBN FROM HOA_DON, Inserted AS hd_Tmp
	WHERE HOA_DON.MAHD = hd_Tmp.MaHD)

	IF(@tien >= 1000000 AND @tien < 5000000)
	BEGIN
		UPDATE BENH_NHAN SET KhuyenMai = N'Đồng' WHERE BENH_NHAN.MaBN = @MaBN
	END
	ELSE IF (@tien >= 5000000 AND @tien < 10000000)
	BEGIN
		UPDATE BENH_NHAN SET KhuyenMai = N'Bạc' WHERE BENH_NHAN.MaBN = @MaBN
	END
	ELSE IF (@tien >= 10000000 and @tien < 20000000)
	BEGIN
		UPDATE BENH_NHAN SET KhuyenMai = N'Vàng' WHERE BENH_NHAN.MaBN = @MaBN
	END
	ELSE
	BEGIN
		UPDATE BENH_NHAN SET KhuyenMai = N'Kim Cương' WHERE BENH_NHAN.MaBN = @MaBN
	END
END
---4.2:Mỗi thẻ sẽ đc giảm 2%, 5%, 10%, 15% trên 1 dv tương ứng cho các bậc trên---
CREATE TRIGGER TG_Sale ON HOA_DON FOR INSERT, UPDATE
AS
BEGIN
    DECLARE @Tien Money;
	--DECLARE @KhuyenMai Nvarchar;
	DECLARE @MaBN Int;

	SET @Tien = (SELECT hd_Tmp.TongTien FROM HOA_DON, Inserted AS hd_Tmp
	WHERE HOA_DON.MaHD = hd_Tmp.MaHD)

	SET @MaBN = (SELECT hd_Tmp.MaBN FROM HOA_DON, Inserted AS hd_Tmp
	WHERE HOA_DON.MAHD = hd_Tmp.MaHD)

	IF(@tien >= 1000000 AND @tien < 5000000)
	BEGIN
		UPDATE HOA_DON SET TongTien = TongTien - (TongTien * 0.02) WHERE HOA_DON.MaBN = @MaBN
	END
	ELSE IF (@tien >= 1000000 AND @tien < 5000000)
	BEGIN
		UPDATE HOA_DON SET TongTien = TongTien - (TongTien * 0.05) WHERE HOA_DON.MaBN = @MaBN
	END
	ELSE IF (@tien >= 1000000 AND @tien < 5000000)
	BEGIN
		UPDATE HOA_DON SET TongTien = TongTien - (TongTien * 0.1) WHERE HOA_DON.MaBN = @MaBN
	END
	ELSE
	BEGIN
		UPDATE HOA_DON SET TongTien = TongTien - (TongTien * 0.15) WHERE HOA_DON.MaBN = @MaBN
	END
END

SELECT KhuyenMai FROM BENH_NHAN where MaBN = 212

INSERT INTO HOA_DON (MaHD, MaBN, MaTT, TongTien) 
VALUES (716, 212, 504, 100000000);

--5.check ngày lập so với ngày khám 

create trigger tg_benhan on benh_an for insert ,update
as
begin
	declare @ngaylap datetime;
	declare @ngaykham datetime;
	set @ngaylap = (select nl.ngaylap from benh_an,inserted as nl where benh_an.maba = nl.maba)
	set @ngaykham = (select nk.ngaykham from benh_an, inserted as nk where benh_an.maba = nk.maba)
	if((@ngaylap - @ngaykham) > 1)
	begin 
		print(N'Ngày lập được tạo quá ngày so với ngày khám')
		rollback tran
	end
end

drop trigger tg_benhan

INSERT INTO BENH_AN (MaBA , MaBN, MaBS, NgayKham, KetQua, NgayLap, ChuY) 
VALUES (984, 211, 101, '2022/01/06 10:35:00', N'Sâu răng', '2022/01/07 10:36:00', N'No');

------6. kiểm tra Ngày khám phải lớn hơn ngày sinh của bệnh nhân------
create   or alter trigger kiem_tra_ngay_kham on BENH_AN
after insert,update
as if (exists (select * from inserted i join BENH_NHAN bn on i.MaBN = bn.MaBN where i.NgayKham<bn.NamSinh_BN))
	begin
	Print N'Ngày khám phải lớn hơn ngày sinh của bệnh nhân'
	rollback tran
	end

INSERT INTO BENH_AN (MaBA , MaBN, MaBS, NgayKham, KetQua, NgayLap, ChuY) 
VALUES (433, 204, 102, '1900/01/02 14:00:00', N'Răng bị nhiễm kháng sinh ở mức độ nhẹ', '1900/01/02 14:30:00', N'No');


-----7. Độ tuổi của nhân viên phải trên 18 tuổi 
create trigger trg_NhanVien on TIEP_TAN for insert
as
Begin
	declare @tuoi int;
	set @tuoi = (select (YEAR(GETDATE())-Year(TIEP_TAN.NamSinh_TT)) from TIEP_TAN, inserted  where TIEP_TAN.MaTT = inserted.MaTT)
	if(@tuoi<18)
	begin 
	print N' Tiếp tân chưa đủ 18 tuổi '
	RollBack Tran
	end
end 

INSERT INTO TIEP_TAN (MaTT, TenTT, NamSinh_TT, GioiTinh_TT, CMND_TT, SĐT_TT, DiaChi_TT) 
VALUES (5000, N'Nguyên', '2010/11/12', N'Nữ', 272, 0929650233, N'Vũng Tàu');


----8. Ca trực chỉ có thể là Ca sáng hoạc Ca chiều ---------
create or alter trigger trg_ktraCaTruc
on CA_TRUC
FOR INSERT,UPDATE
AS BEGIN
IF EXISTS (SELECT * FROM inserted WHERE inserted.CaTruc NOT IN ('Ca sáng','Ca chiều'))
begin
PRint N'Không thêm được';
rollback tran
end
END

INSERT INTO CA_TRUC (MaBS , NgayTruc, CaTruc) 
VALUES (102, '2022/01/03', N'Ca gerer');

--8. Giới tính bác sĩ chỉ có thể là nam hoặc nữ --
CREATE or ALTER TRIGGER trg_ktraGioiTinhBS
ON BAC_SI
FOR INSERT, UPDATE
AS BEGIN
	IF EXISTS (SELECT * FROM inserted WHERE inserted.GioiTinh_BS NOT IN ('Nam',N'Nữ'))
	BEGIN
	PRINT N'Giới tính phải là nam hoặc nữ';
	ROLLBACK TRAN
	END
END

-- Thực thi
INSERT INTO BAC_SI(MaBS , TenBS, NamSinh_BS, GioiTinh_BS, CMND_BS, SĐT_BS, DiaChi_BS, SoPhong) 
VALUES (106, N'Nguyễn A', '1990-12-30', 'Nan', '272655723', '339877564', N'Hà Nội', 2);