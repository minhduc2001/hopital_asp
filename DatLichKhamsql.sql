create database WebDatLichKham
go
use WebDatLichKham
go
create table BenhNhan( 
	mabn INT IDENTITY(1,1) PRIMARY KEY,
	tenbn nvarchar(50) not null,
	sdt char(10),
	email char(30),
	diachi nvarchar(50),
	ngaysinh date,
	gioitinh nvarchar(5) check (GioiTinh in (N'Nam', N'Nữ')),
	tendn varchar(50),
	mk char(50)
)
go
create table ChiNhanh(
	machinhanh INT IDENTITY(1,1) PRIMARY KEY,
	diachi nvarchar(50)
)
go
create table Khoa(
	makhoa INT IDENTITY(1,1) PRIMARY KEY,
	tenkhoa nvarchar(50),
	mota nvarchar(max)
)
go
create table NguoiDung (
	mand INT IDENTITY(1,1) PRIMARY KEY,
	hoten nvarchar(50) not null,
	diachi nvarchar(50),
	ngaysinh date,
	gioitinh nvarchar(5) check (GioiTinh in (N'Nam', N'Nữ')),
	sdt char(10),
	email char(30),
	chucvu nvarchar(max),
	hocham nvarchar(max),
	hocvi nvarchar(max),
	gioithieu nvarchar(max),
	makhoa int references Khoa (makhoa),
	machinhanh int references ChiNhanh(machinhanh),
	tendn varchar(50),
	mk char(50),
	quyen int,
	anh nvarchar(max)
)
go
CREATE TABLE [dbo].[BenhAn] (
    [maba] [int] NOT NULL IDENTITY,
    [mabn] [int] NOT NULL,
    [mabs] [int] NOT NULL,
    [tieude] [nvarchar](max),
    [ngaykham] [datetime] NOT NULL,
    [giokham] [datetime] NOT NULL,
    [mach] [float] NOT NULL,
    [nhietdo] [float] NOT NULL,
    [nhiptho] [float] NOT NULL,
    [chieucao] [float] NOT NULL,
    [cannang] [float] NOT NULL,
    [bmi] [float] NOT NULL,
    [thiluctrai] [float] NOT NULL,
    [thilucphai] [float] NOT NULL,
    [nhanapP] [float] NOT NULL,
    [nhanapT] [float] NOT NULL,
    [chuandoan] [nvarchar](max),
    [ketqua] [nvarchar](max),
    [trangthai] [int] NOT NULL,
    CONSTRAINT [PK_dbo.BenhAn] PRIMARY KEY ([maba])
)
go
CREATE INDEX [IX_mabn] ON [dbo].[BenhAn]([mabn])
CREATE INDEX [IX_mabs] ON [dbo].[BenhAn]([mabs])
ALTER TABLE [dbo].[BenhAn] ADD CONSTRAINT [FK_dbo.BenhAn_dbo.NguoiDung_mabs] FOREIGN KEY ([mabs]) REFERENCES [dbo].[NguoiDung] ([mand]) ON DELETE CASCADE
ALTER TABLE [dbo].[BenhAn] ADD CONSTRAINT [FK_dbo.BenhAn_dbo.BenhNhan_mabn] FOREIGN KEY ([mabn]) REFERENCES [dbo].[BenhNhan] ([mabn]) ON DELETE CASCADE
go
create table Loai(
	maloai INT IDENTITY(1,1) PRIMARY KEY,
	tenloai nvarchar(max)
)

go
insert into Loai values
(N'Chăm sóc sức khỏe'),
(N'Tin tức')

go
create table BaiViet(
	mabv INT IDENTITY(1,1) PRIMARY KEY,
	tieude nvarchar(max),
	noidung nvarchar(max),
	hinhanh nvarchar(100),
	mota nvarchar(max),
	ngaydang date,
	maloai int references Loai(maloai),
	mand int references NguoiDung(mand)
)
go
create table CaKham(
	maca INT IDENTITY(1,1) PRIMARY KEY,
	ngaykham date,
	hinhthuc nvarchar(30),
	ca char(100),
	mand int references NguoiDung(mand)
)

go
create table DatLich(
	madat INT IDENTITY(1,1) PRIMARY KEY,
	ngaydat date,
	mota nvarchar(max),
	sdt char(10),
	hoten nvarchar(30),
	ngaysinh date,
	trangthai int,
	maca int references CaKham(maca),	
	mabn int
)
go
go
create table DanhGia(
	madanhgia INT IDENTITY(1,1) PRIMARY KEY,
	ngay date,
	noidung nvarchar(max),
	mand int references NguoiDung(mand),
	mabn int references BenhNhan(mabn)
)
go

create table HoiDap(
	ma INT IDENTITY(1,1) PRIMARY KEY,
	hoi nvarchar(max),
	ngayhoi datetime,
	ngaytl datetime,
	dap nvarchar(max),
	mand int references NguoiDung(mand),
	mabn int references BenhNhan(mabn),
	trangthai int
)

go
insert into ChiNhanh values
(N'Hà Nội'),
(N'Đà Nẵng'),
(N'Sài Gòn')
go
insert into Khoa values
(N'Khoa Tai mũi họng',N''),
(N'Khoa Nam học',N''),
(N'Khoa Cơ xương khớp',N''),
(N'Khoa Ung bướu',N''),
(N'Trung tâm sản phụ khoa',N'')
go
insert into NguoiDung values
(N'BS TRẦN THỊ THÚY HẰNG', N'Hà Nội', '1970-01-04', N'Nữ', '09987730','hang@gmail.com',N'Trưởng khoa tai mũi họng',N'Phó giáo sư', N'Tiến sĩ', N'BSNT.CKII Trần Thị Thúy Hằng là một trong những bác sĩ hàng đầu lĩnh vực Thanh học tại Việt Nam. Không chỉ có trình độ chuyên môn cao, nhiều năm kinh nghiệm thực tiễn tại các bệnh viện uy tín, bác sĩ Trần Thị Thúy Hằng còn được nhiều bệnh nhân tin tưởng và yêu mến bởi sự quan tâm, tận tình trong thăm khám và điều trị bệnh.',1,1,'bsadmin','123',0, N'1.png'),
(N'BS TỪ THANH TRÍ DŨNG', N'Hà Nội', '1970-01-04', N'Nam', '09987731','dung@gmail.com',N'Trưởng khoa nam học',N'Phó giáo sư', N'Tiến sĩ', N'NGND.GS.TS.BS Trần Quán Anh là người đầu tiên đặt nền móng cho ngành Nam học Việt Nam.
Ông là Tổng Thư ký Hội Tiết niệu – Thận học Việt Nam, Hội viên Hội Tiết niệu thế giới (S.I.U), là người khởi xướng xây dựng phân khoa nam học, thuộc Khoa tiết niệu, Bệnh viện Việt – Đức, Hà Nội. Từng tham gia nhiều hội nghị quốc tế về nam học tại nhiều quốc gia trên thế giới, Giáo sư Trần Quán Anh tiến hành hàng chục công trình nghiên cứu quý giá gây dựng cho bộ môn khoa học từ non trẻ đến gặt hái được những thành tựu to lớn ở Việt Nam hiện nay.',2,1,'bsdung','123',1, N'2.png'),
(N'BS NGUYỄN BÁ MỸ NHI', N'Đà Nẵng', '1970-01-04', N'Nữ', '09987732','nhi@gmail.com',N'Giám đốc Trung tâm Sản Phụ khoa',N'Phó giáo sư', N'Tiến sĩ',N'bác sĩ Mỹ Nhi còn là người truyền cảm hứng, là người thầy truyền lửa y đạo – y thuật cho nhiều thế hệ bác sĩ trong và ngoài chuyên ngành Sản Phụ khoa suốt hơn 30 năm qua.
Với vai trò Giám đốc Trung tâm Sản Phụ khoa, Bệnh viện Đa khoa Tâm Anh TP.Hồ Chí Minh, Bác sĩ Nguyễn Bá Mỹ Nhi không chỉ tham gia định hướng phát triển trung tâm Sản Phụ khoa vì sức khỏe của người phụ nữ Việt Nam mà còn hướng đến đào tạo, chẩn đoán – điều trị chuyên sâu như Phẫu thuật nội soi phụ khoa, Ung thư phụ khoa, Bệnh lý sàn chậu nữ, Dị tật bẩm sinh đường sinh dục nữ, Thai kỳ nguy cơ cao, Chẩn đoán tiền sản, Can thiệp bào thai, Phẫu thuật thẩm mỹ nữ…',5,1,'bsmynhi','123', 1,N'3.png'),
(N'BS TRẦN VƯƠNG THẢO NGHI', N'Sài Gòn', '1970-01-04', N'Nữ', '09987732','nghi@gmail.com',N'Trưởng khoa Ung bướu',N'Phó giáo sư', N'Tiến sĩ',N'Gần 20 năm gắn bó với chuyên ngành Ung bướu, bác sĩ Trần Vương Thảo Nghi đã không biết bao nhiêu lần tạo nên những câu chuyện “cổ tích” ngoài đời thực, giúp người bệnh luôn tin rằng Ung thư không phải là dấu chấm hết.
Có kinh nghiệm “chinh chiến” trong các tình huống “ngàn cân treo sợi tóc”, đặc biệt với những ca bệnh khó, Bác sĩ Trần Vương Thảo Nghi đã góp phần cải thiện tình trạng bệnh, nâng cao chất lượng cuộc sống cho rất nhiều bệnh nhân.',4, 1, 'thaonghi','123',1, '5.png'),
(N'BS ĐẶNG HỒNG HOA', N'Hà Nội', '1970-01-04', N'Nữ', '09987732','honghoa@gmail.com',N'Trưởng khoa Cơ xương khớp',N'Phó giáo sư', N'Tiến sĩ',N'Với hơn 30 năm nghiên cứu và khám chữa bệnh thành công cho nhiều bệnh nhân cơ xương khớp, PGS.TS.BSCC Đặng Hồng Hoa, Trưởng khoa Cơ xương khớp, Bệnh viện Đa khoa Tâm Anh, Hà Nội được mệnh danh là “Nữ anh hùng áo trắng của ngành Cơ xương khớp"', 3, 1, 'bshonghoa','123',2, N'4.png'),


(N'BS TRẦN THỊ NGỌC', N'Hà Nội', '1970-01-04', N'Nữ', '09987730','ngoc@gmail.com',N'Bác sĩ khoa Cơ xương khớp',N'Phó giáo sư', N'Tiến sĩ', N'BSNT.CKII Trần Thị Ngọc là một trong những bác sĩ hàng đầu lĩnh vực Thanh học tại Việt Nam. Không chỉ có trình độ chuyên môn cao, nhiều năm kinh nghiệm thực tiễn tại các bệnh viện uy tín, bác sĩ Trần Thị Thúy Hằng còn được nhiều bệnh nhân tin tưởng và yêu mến bởi sự quan tâm, tận tình trong thăm khám và điều trị bệnh.',3,2,'bsngoc','123',1, N'6.png'),
(N'BS TRẦN QUÁN ANH', N'Hà Nội', '1970-01-04', N'Nam', '09987731','anh@gmail.com',N'Trưởng khoa Ung bướu',N'Phó giáo sư', N'Tiến sĩ', N'NGND.GS.TS.BS Trần Quán Anh là người đầu tiên đặt nền móng cho ngành Nam học Việt Nam.
Ông là Tổng Thư ký Hội Tiết niệu – Thận học Việt Nam, Hội viên Hội Tiết niệu thế giới (S.I.U), là người khởi xướng xây dựng phân khoa nam học, thuộc Khoa tiết niệu, Bệnh viện Việt – Đức, Hà Nội. Từng tham gia nhiều hội nghị quốc tế về nam học tại nhiều quốc gia trên thế giới, Giáo sư Trần Quán Anh tiến hành hàng chục công trình nghiên cứu quý giá gây dựng cho bộ môn khoa học từ non trẻ đến gặt hái được những thành tựu to lớn ở Việt Nam hiện nay.',4,2,'bsanh','123',1, N'7.png'),

(N'BS NGUYỄN THỊ NGA', N'Đà Nẵng', '1970-01-04', N'Nữ', '09987732','nhi@gmail.com',N'Giám đốc Trung tâm Sản Phụ khoa',N'Phó giáo sư', N'Tiến sĩ',N'bác sĩ Nga còn là người truyền cảm hứng, là người thầy truyền lửa y đạo – y thuật cho nhiều thế hệ bác sĩ trong và ngoài chuyên ngành Sản Phụ khoa suốt hơn 30 năm qua.
Với vai trò Giám đốc Trung tâm Sản Phụ khoa, Bệnh viện Đa khoa Tâm Anh TP.Hồ Chí Minh, Bác sĩ Nguyễn Bá Mỹ Nhi không chỉ tham gia định hướng phát triển trung tâm Sản Phụ khoa vì sức khỏe của người phụ nữ Việt Nam mà còn hướng đến đào tạo, chẩn đoán – điều trị chuyên sâu như Phẫu thuật nội soi phụ khoa, Ung thư phụ khoa, Bệnh lý sàn chậu nữ, Dị tật bẩm sinh đường sinh dục nữ, Thai kỳ nguy cơ cao, Chẩn đoán tiền sản, Can thiệp bào thai, Phẫu thuật thẩm mỹ nữ…',5,2,'bsnga','123', 1,N'8.png'),
(N'BS ĐẶNG ĐÌNH HIẾU' ,N'Đà Nẵng', '1970-01-04', N'Nam', '09987732','hieu@gmail.com',N'Trưởng khoa Tai mũi họng',N'Phó giáo sư', N'Tiến sĩ',N'Gần 20 năm gắn bó với chuyên ngành Tai mũi họng, bác sĩ ĐẶng Đình Hiếu đã không biết bao nhiêu lần tạo nên những câu chuyện “cổ tích” ngoài đời thực, giúp người bệnh luôn tin rằng Ung thư không phải là dấu chấm hết.
Có kinh nghiệm “chinh chiến” trong các tình huống “ngàn cân treo sợi tóc”, đặc biệt với những ca bệnh khó, Bác sĩ ĐẶng Đình Hiếu đã góp phần cải thiện tình trạng bệnh, nâng cao chất lượng cuộc sống cho rất nhiều bệnh nhân.',1, 2, 'bshieu','123',1, '16.png'),
(N'BS NGUYỄN THỊ VÂN', N'Đà Nẵng', '1970-01-04', N'Nữ', '09987732','van@gmail.com',N'Trưởng khoa Nam học',N'Phó giáo sư', N'Tiến sĩ',N'Với hơn 30 năm nghiên cứu và khám chữa bệnh thành công cho nhiều bệnh nhân, PGS.TS.BSCC Nguyễn Thị Vân, Trưởng khoa  Nam học, Bệnh viện Đa khoa Tâm Anh, Hà Nội được mệnh danh là “Nữ anh hùng áo trắng của ngành Nam học"', 2, 2, 'bsvan','123',2, N'9.png'),
(N'BS ĐẶNG THỊ THƯƠNG', N'Đà Nẵng', '1970-01-04', N'Nữ', '09987732','thuong@gmail.com',N'Trưởng khoa Cơ xương khớp',N'Phó giáo sư', N'Tiến sĩ',N'Với hơn 30 năm nghiên cứu và khám chữa bệnh thành công cho nhiều bệnh nhân cơ xương khớp, PGS.TS.BSCC Đặng Thị Thương, Trưởng khoa Cơ xương khớp, Bệnh viện Đa khoa Tâm Anh, Hà Nội được mệnh danh là “Nữ anh hùng áo trắng của ngành Nam học"', 3, 2, 'bsthuong','123',2, N'10.png'),


(N'BS NGUYỄN THỊ HIỀN', N'Sài Gòn', '1970-01-04', N'Nữ', '09987732','nhi@gmail.com',N'Giám đốc Trung tâm Sản Phụ khoa',N'Phó giáo sư', N'Tiến sĩ',N'bác sĩ Hiền còn là người truyền cảm hứng, là người thầy truyền lửa y đạo – y thuật cho nhiều thế hệ bác sĩ trong và ngoài chuyên ngành Sản Phụ khoa suốt hơn 30 năm qua.
Với vai trò Giám đốc Trung tâm Sản Phụ khoa, Bệnh viện Đa khoa Tâm Anh TP.Hồ Chí Minh, Bác sĩ Nguyễn Bá Mỹ Nhi không chỉ tham gia định hướng phát triển trung tâm Sản Phụ khoa vì sức khỏe của người phụ nữ Việt Nam mà còn hướng đến đào tạo, chẩn đoán – điều trị chuyên sâu như Phẫu thuật nội soi phụ khoa, Ung thư phụ khoa, Bệnh lý sàn chậu nữ, Dị tật bẩm sinh đường sinh dục nữ, Thai kỳ nguy cơ cao, Chẩn đoán tiền sản, Can thiệp bào thai, Phẫu thuật thẩm mỹ nữ…',5,3,'bshien','123', 1,N'11.png'),
(N'BS ĐẶNG VĂN HIẾU' , N'Sài Gòn', '1970-01-04', N'Nam', '09987732','hieu@gmail.com',N'Trưởng khoa Tai mũi họng',N'Phó giáo sư', N'Tiến sĩ',N'Gần 20 năm gắn bó với chuyên ngành Tai mũi họng, bác sĩ ĐẶng Hiếu đã không biết bao nhiêu lần tạo nên những câu chuyện “cổ tích” ngoài đời thực, giúp người bệnh luôn tin rằng Ung thư không phải là dấu chấm hết.
Có kinh nghiệm “chinh chiến” trong các tình huống “ngàn cân treo sợi tóc”, đặc biệt với những ca bệnh khó, Bác sĩ ĐẶng Đình Hiếu đã góp phần cải thiện tình trạng bệnh, nâng cao chất lượng cuộc sống cho rất nhiều bệnh nhân.',1, 2, 'bvanshieu','123',1, '16.png'),
(N'BS NGUYỄN THỊ VÂN',  N'Sài Gòn', '1970-01-04', N'Nữ', '09987732','van@gmail.com',N'Trưởng khoa Nam học',N'Phó giáo sư', N'Tiến sĩ',N'Với hơn 30 năm nghiên cứu và khám chữa bệnh thành công cho nhiều bệnh nhân, PGS.TS.BSCC Nguyễn Thị Vân, Trưởng khoa  Nam học, Bệnh viện Đa khoa Tâm Anh, Hà Nội được mệnh danh là “Nữ anh hùng áo trắng của ngành Nam học"', 2, 3, 'bsvan1','123',2, N'12.png'),
(N'BS ĐẶNG THỊ THƯƠNG', N'Sài Gòn', '1970-01-04', N'Nữ', '09987732','thuong@gmail.com',N'Trưởng khoa Cơ xương khớp',N'Phó giáo sư', N'Tiến sĩ',N'Với hơn 30 năm nghiên cứu và khám chữa bệnh thành công cho nhiều bệnh nhân cơ xương khớp, PGS.TS.BSCC Đặng Thị Thương, Trưởng khoa Cơ xương khớp, Bệnh viện Đa khoa Tâm Anh, Hà Nội được mệnh danh là “Nữ anh hùng áo trắng của ngành Nam học"', 3, 3, 'bsthuong1','123',2, N'13.png'),
(N'BS TRẦN THỊ NGỌC',  N'Sài Gòn', '1970-01-04', N'Nữ', '09987730','ngoc@gmail.com',N'Bác sĩ khoa Cơ xương khớp',N'Phó giáo sư', N'Tiến sĩ', N'BSNT.CKII Trần Thị Ngọc là một trong những bác sĩ hàng đầu lĩnh vực Thanh học tại Việt Nam. Không chỉ có trình độ chuyên môn cao, nhiều năm kinh nghiệm thực tiễn tại các bệnh viện uy tín, bác sĩ  còn được nhiều bệnh nhân tin tưởng và yêu mến bởi sự quan tâm, tận tình trong thăm khám và điều trị bệnh.',3,3,'bsngoc1','123',1, N'14.png'),
(N'BS TRẦN QUÁN NAM',  N'Sài Gòn', '1970-01-04', N'Nam', '09987731','nam@gmail.com',N'Trưởng khoa Ung bướu',N'Phó giáo sư', N'Tiến sĩ', N'NGND.GS.TS.BS Trần Quán Nam là người đầu tiên đặt nền móng cho ngành Nam học Việt Nam.
Ông là Tổng Thư ký Hội Tiết niệu – Thận học Việt Nam, Hội viên Hội Tiết niệu thế giới (S.I.U), là người khởi xướng xây dựng phân khoa nam học, thuộc Khoa tiết niệu, Bệnh viện Việt – Đức, Hà Nội. Từng tham gia nhiều hội nghị quốc tế về nam học tại nhiều quốc gia trên thế giới, Giáo sư Trần Quán Anh tiến hành hàng chục công trình nghiên cứu quý giá gây dựng cho bộ môn khoa học từ non trẻ đến gặt hái được những thành tựu to lớn ở Việt Nam hiện nay.',4,3,'bsnam','123',1, N'15.png')

go
insert into BaiViet values
(N'Giữ vững tinh thần - Vượt qua đại dịch',N'<h3>Chuy&ecirc;n gia chỉ c&aacute;ch tăng cường sức khỏe - Giữ vững tinh thần - Vượt qua đại dịch</h3>

<p>(Thứ 4, 01/07/2020 22:08)</p>

<p><strong>B&aacute;o điện tử Sức khỏe&amp;Đời sống tổ chức buổi tư vấn truyền h&igrave;nh trực tuyến với chủ đề &ldquo;Tăng cường sức khỏe - Giữ vững tinh thần - Vượt qua đại dịch&rdquo; v&agrave;o 15h00, Thứ Hai, ng&agrave;y 13/04/2020. Chương tr&igrave;nh được ph&aacute;t trực tiếp tr&ecirc;n b&aacute;o điện tử Suckhoedoisong.vn, tr&ecirc;n k&ecirc;nh Youtube v&agrave; fanpage của b&aacute;o Sức khoẻ&amp;Đời sống.</strong></p>

<p>&nbsp;</p>

<p>C&oacute; một thực tế kh&ocirc;ng thể phủ nhận, đại dịch COVID-19 kh&ocirc;ng chỉ l&agrave; &ldquo;cơn lốc đen&rdquo; tấn c&ocirc;ng v&agrave;o hệ h&ocirc; hấp v&agrave; cướp đi sinh mạng của h&agrave;ng trăm ng&agrave;n người tr&ecirc;n thế giới, m&agrave; n&oacute; c&ograve;n mang đến rất nhiều hệ lụy. Một trong số những hệ lụy đ&oacute;, ch&iacute;nh l&agrave; đời sống t&acirc;m l&yacute;, tinh thần, sức khỏe t&acirc;m thần của nhiều người đ&atilde; đang v&agrave; sẽ bị tổn thương nghi&ecirc;m trọng.</p>

<p>Một cuộc khảo s&aacute;t của Hiệp hội T&acirc;m l&yacute; học Trung Quốc thực hiện v&agrave;o cuối th&aacute;ng 3/2020 cho thấy, 18.000 người được chẩn đo&aacute;n hội chứng lo lắng li&ecirc;n quan đến sự b&ugrave;ng ph&aacute;t dịch COVID -19, hơn 5.000 người được đ&aacute;nh gi&aacute; rối loạn căng thẳng sau sang chấn t&acirc;m l&yacute; (PTSD); trong đ&oacute; c&oacute; 21,5% c&oacute; biểu hiện rối loạn r&otilde; rệt.&nbsp; Tại H&agrave;n Quốc, khi đại dịch b&ugrave;ng ph&aacute;t, ch&iacute;nh quyền Seoul cũng đ&atilde; phải tăng cường c&aacute;c dịch vụ về hỗ trợ, tư vấn t&acirc;m l&yacute;.</p>

<p>Mới đ&acirc;y nhất, tại Việt Nam, kết quả nghi&ecirc;n cứu của nh&oacute;m t&aacute;c giả Việt Nam - Đ&agrave;i Loan khảo s&aacute;t, đ&aacute;nh gi&aacute; tr&ecirc;n 3.947 người mang biểu hiện ho, sốt v&agrave; triệu chứng nghi nhiễm COVID -19 tại c&aacute;c cơ sở y tế Th&aacute;i Nguy&ecirc;n, Thừa Thi&ecirc;n Huế, TP.HCM cho thấy 64,3% người c&oacute; dấu hiệu trầm cảm.</p>

<p>R&otilde; r&agrave;ng, đại dịch COVID-19 đ&atilde;, đang v&agrave; sẽ khiến tinh thần v&agrave; t&acirc;m l&yacute; rất nhiều người bị tổn thương.</p>

<p>Do đ&oacute;, nhằm cung cấp cho kh&aacute;n giả, bạn đọc của b&aacute;o Sức Khỏe v&agrave; Đời Sống, Cơ quan Ng&ocirc;n luận của Bộ Y tế, những th&ocirc;ng tin hữu &iacute;ch nhất về sự tấn c&ocirc;ng của COVID-19 đến tinh thần v&agrave; t&acirc;m l&yacute; của mọi người cũng như sự ảnh hưởng gi&aacute;n tiếp của COVID - 19 đến c&aacute;c bệnh nh&acirc;n tim mạch v&agrave; c&aacute;c bệnh l&yacute; kh&aacute;c, g&iacute;up họ giữ vững tinh thần, tăng cường sức khỏe to&agrave;n diện để vượt qua đại dịch COVD-19. B&aacute;o điện tử Sức khỏe &amp; Đời sống - suckhoedoisong.vn tổ chức buổi tư vấn truyền h&igrave;nh trực tuyến với chủ đề&nbsp;&ldquo;Tăng cường sức khỏe - Giữ vững tinh thần - Vượt qua đại dịch&rdquo;&nbsp;v&agrave;o 15h00, Thứ Hai ng&agrave;y 13/4/2020.</p>

<p>Kh&aacute;ch mời tham gia chương tr&igrave;nh gồm:</p>

<p><em>Thiếu tướng, PGS.TS.BS. Nguyễn Hồng Sơn - Gi&aacute;m đốc BV Qu&acirc;n y 175, Bộ Quốc Ph&ograve;ng</em></p>

<p><em><img alt="" src="https://benhvien175.vn/wp-content/uploads/2018/09/NguyenHongSon.png" style="height:596px; width:700px" /></em></p>

<p><em>GS.TS.BS Đặng Vạn Phước - Trưởng khoa Y, Đại học Quốc gia TP. Hồ Ch&iacute; Minh; Chủ tịch Hội Tim mạch học Việt Nam</em></p>

<p>&nbsp;</p>

<p><em><img alt="" src="https://benhvien175.vn/wp-content/uploads/2018/09/NguyenHongSon.png" style="height:533px; width:700px" /></em></p>

<p><em>TSKH. Vũ C&ocirc;ng Lập - Nguy&ecirc;n Viện trưởng Viện Vật l&yacute; Y sinh</em></p>

<p><em><img alt="" src="https://znews-photo.zingcdn.me/w860/Uploaded/izhmr/2014_07_03/Vu_Cong_Lap.jpg" style="height:597px; width:700px" /></em></p>

<p><em>MC, ThS. BS. Nguyễn Hồ Vĩnh Phước</em></p>

<p><em><img alt="" src="https://scontent.fhan9-1.fna.fbcdn.net/v/t31.18172-8/29750004_874191619431825_4942892616712730419_o.jpg?stp=dst-jpg_p843x403&_nc_cat=107&ccb=1-7&_nc_sid=730e14&_nc_ohc=pP8ovHqqfSsAX_hkznw&_nc_ht=scontent.fhan9-1.fna&oh=00_AT_uLJtV2k_pZ4vREVGfSIq2CrHD3FtxTPlsOZhw6m4QsQ&oe=63683155" style="height:560px; width:373px" /></em></p>

<p>&nbsp;</p>

<p>Nguồn: B&aacute;o Sức khỏe&amp;Đời sống</a></p>
', 'sk.png',N' Có một thực tế không thể phủ nhận, đại dịch COVID-19 không chỉ là “cơn lốc đen” tấn công vào hệ hô hấp và cướp đi sinh mạng của hàng trăm ngàn người trên thế giới, mà nó còn mang đến rất nhiều hệ lụy....',N'2022-01-04', 1, 3),
--
(N'“PHAO CỨU SINH” CHO BỆNH NHÂN HẸP MẠCH VÀNH NẶNG KÈM SUY THẬN, SUY TIM',N'<em>Chụp mạch vành chỉ với 1/4 lượng thuốc cản quang thông thường kết hợp siêu âm lòng mạch giúp nhiều bệnh nhân mạch vành kèm suy thận được đặt stent kịp thời, an toàn.</em></p> <p dir="ltr"><img loading="lazy" class="aligncenter size-full wp-image-61731 lazyload" src="https://tamanhhospital.vn/wp-content/uploads/2022/09/phao-cuu-sinh-cho-benh-nhan.jpg" alt="phao cứu sinh cho bệnh nhân" width="847" height="443" srcset="https://tamanhhospital.vn/wp-content/uploads/2022/09/phao-cuu-sinh-cho-benh-nhan.jpg 847w, https://tamanhhospital.vn/wp-content/uploads/2022/09/phao-cuu-sinh-cho-benh-nhan-300x157.jpg 300w, https://tamanhhospital.vn/wp-content/uploads/2022/09/phao-cuu-sinh-cho-benh-nhan-768x402.jpg 768w" sizes="(max-width: 847px) 100vw, 847px" data-src="https://tamanhhospital.vn/wp-content/uploads/2022/09/phao-cuu-sinh-cho-benh-nhan.jpg"></p> <p dir="ltr">Sau 3 ngày đặt stent tái thông lòng động mạch liên thất trước bị hẹp đến 90%, bệnh nhân Đoàn Ngọc Lam (82 tuổi, ngụ Bình Dương) hết đau ngực, khó thở, khỏe mạnh xuất viện trong niềm hạnh phúc của gia đình và ekip bác sĩ Bệnh viện Đa khoa Tâm Anh TP HCM. Đây là một trong số nhiều trường hợp bệnh nhân lớn tuổi bị hẹp mạch vành nặng kèm nhiều bệnh lý nền được chụp mạch vành với kỹ thuật Cardiac Swing hạn chế thuốc cản quang và đặt stent kích thước “khổng lồ” lên đến 5.0 mm giảm tái hẹp tại Bệnh viện Tâm Anh thời gian gần đây.</p> <p dir="ltr">BS.CKII Huỳnh Ngọc Long, Giám đốc Trung tâm Can thiệp mạch, Bệnh viện Đa khoa Tâm Anh TP HCM cho biết, nhờ kỹ thuật Cardiac Swing, chỉ cần 2 lần chụp, với tổng cộng 7-8 ml thuốc cản quang, bác sĩ có thể thu được hình ảnh 3D động mạch vành ở mọi góc độ thay vì 6-8 lần chụp với lượng thuốc đưa vào cơ thể có thể lên đến 20-30ml như kỹ thuật thông thường.</p> <p dir="ltr">Kết quả cho thấy, bệnh nhân bị xơ vữa động mạch gây hẹp đến 90% tại vị trí động mạch liên thất trước. Đây là động mạch cung cấp nhiều máu nhất cho vùng cơ tim, nên cần được can thiệp tái thông mạch vành càng sớm càng tốt để tránh nguy cơ đột tử.</p> <p dir="ltr">Bà Lam có bệnh nền tăng huyết áp, đái tháo đường type 2, rối loạn lipid máu, sa sút trí tuệ (bệnh Alzheimer), đặc biệt là suy thận mạn và suy tim nên đã nhiều lần gia đình trì hoãn chụp mạch vành vì lo ngại việc tiêm thuốc cản quang khi chụp mạch vành sẽ khiến bệnh suy thận của bà nặng hơn.</p> <p dir="ltr">Tuy nhiên, trong quá trình điều trị nội khoa, tình trạng đau ngực không hết mà xuất hiện thường xuyên hơn. Đầu tháng 9, bà được chuyển đến Bệnh viện Đa khoa Tâm Anh TP HCM trong tình trạng sốt cao, ho khan, khó thở, suy hô hấp, được ekip bác sĩ khoa Cấp cứu, Hồi sức tích cực, tim mạch điều trị nội khoa tích cực trước khi chụp và đặt stent mạch vành.</p> <p dir="ltr">Bác sĩ Long cho biết, rất nhiều bệnh nhân suy thận đến bệnh viện Tâm Anh điều trị phát hiện hẹp mạch vành rất nặng. Trước đây khi chưa có kỹ thuật Cardiac Swing, họ ở trong tình thế “tiến thoái lưỡng nan”, nếu như không chụp mạch vành, các bác sĩ không thể chẩn đoán chính xác và có hướng điều trị kịp thời, có thể dẫn đến suy tim và đột tử. Ngược lại, nếu chọn chụp mạch vành, họ phải chấp nhận bệnh suy thận nặng hơn do ảnh hưởng thuốc cản quang và có thể phải chạy thận nhân tạo hoặc ghép thận.</p> <p dir="ltr">Do đó, rất nhiều trường hợp như bà Lam chọn trì hoãn chụp và can thiệp mạch vành chấp nhận điều trị nội khoa.</p> <p dir="ltr">“Tuy nhiên, tình trạng hẹp mạch vành nặng không được phát hiện và can thiệp sẽ dẫn đến suy tim. Và khi mạch vành hẹp đến 90%, nếu không được đặt stent tái thông lòng mạch kịp thời, bệnh nhân có thể đột tử bất cứ lúc nào”, bác sĩ Long nói.</p> <div id="attachment_61730" style="width: 857px" class="wp-caption aligncenter"><img aria-describedby="caption-attachment-61730" loading="lazy" class="size-full wp-image-61730 lazyload" src="https://tamanhhospital.vn/wp-content/uploads/2022/09/he-thong-dsa.jpg" alt="hệ thống dsa" width="847" height="565" srcset="https://tamanhhospital.vn/wp-content/uploads/2022/09/he-thong-dsa.jpg 847w, https://tamanhhospital.vn/wp-content/uploads/2022/09/he-thong-dsa-300x200.jpg 300w, https://tamanhhospital.vn/wp-content/uploads/2022/09/he-thong-dsa-768x512.jpg 768w" sizes="(max-width: 847px) 100vw, 847px" data-src="https://tamanhhospital.vn/wp-content/uploads/2022/09/he-thong-dsa.jpg"><p id="caption-attachment-61730" class="wp-caption-text">Đặt stent mạch vành với sự hỗ trợ của hệ thống chụp mạch can thiệp số hóa xóa nền (DSA) Philips Azurion Robotic Ceiling FlexArm trang bị cánh tay robot xoay 360 độ kết hợp siêu âm lòng mạch (IVUS) giúp dễ dàng tiếp cận vùng cần can thiệp, tăng độ chính xác và rút ngắn thời gian thực hiện.</p></div> <p dir="ltr">Bác sĩ Long cho biết, đối với bệnh nhân lớn tuổi có độ hẹp đến 90%, nghĩa là kích thước lòng mạch trước can thiệp chỉ khoảng dưới 1.0 mm. Nếu không có sự hỗ trợ của hệ thống siêu âm trong lòng mạch (IVUS) thế hệ mới dẫn đường, chỉ thông qua hình chụp mạch vành, các bác sĩ sẽ không tự tin chọn stent kích thước lớn vì lo ngại nguy cơ vỡ mạch máu. Việc chọn stent không tối ưu có thể dẫn đến khả năng tái hẹp trong stent khá cao. Khi đó, bệnh nhân có thể gặp các&nbsp;cơn đau ngực do thiếu máu cơ tim&nbsp;và thậm chí là tử vong nếu không được tái&nbsp;can thiệp kịp thời.</p> <p dir="ltr">Do đó, với bệnh nhân Lam, nếu dựa vào hình chụp mạch vành thông thường, bác sĩ chỉ ước tính đặt stent cỡ 3.5 mm. Nhưng nhờ sự hỗ trợ của IVUS, các bác sĩ bệnh viện Tâm Anh xác định chính xác đường kính mạch máu thật sự của bệnh nhân có thể lên hơn 5.0 mm nên quyết định chọn stent cỡ lớn và nong lên kích thước 4.8-5.2 mm. “Nếu đặt được stent càng lớn thì nguy cơ tái hẹp trong stent càng thấp”, bác sĩ Long nhấn mạnh.</p> <div style="width: 1610px" class="wp-caption alignnone"><img loading="lazy" src="https://lh3.googleusercontent.com/1zggOQVirizfnkyptEEuE8D7lKp3hkQONyZUibBkh9TQ6GO_IHzbKNdIHv6DpYRKP8kq6ov4gZ9Xo-ZgXJSEapBHwmeOxZQwlFtUs6hk3lt93Oel_c8XhLfi8kZrIdLaImrkasHHc2OoKizdXDOPJXSNy56f0XTYXSjbJz1pNMqovCf9uK_Ux2ieBA" alt="" width="1600" height="1121" data-cke-saved-src="https://lh3.googleusercontent.com/1zggOQVirizfnkyptEEuE8D7lKp3hkQONyZUibBkh9TQ6GO_IHzbKNdIHv6DpYRKP8kq6ov4gZ9Xo-ZgXJSEapBHwmeOxZQwlFtUs6hk3lt93Oel_c8XhLfi8kZrIdLaImrkasHHc2OoKizdXDOPJXSNy56f0XTYXSjbJz1pNMqovCf9uK_Ux2ieBA" class="lazyload" data-src="https://lh3.googleusercontent.com/1zggOQVirizfnkyptEEuE8D7lKp3hkQONyZUibBkh9TQ6GO_IHzbKNdIHv6DpYRKP8kq6ov4gZ9Xo-ZgXJSEapBHwmeOxZQwlFtUs6hk3lt93Oel_c8XhLfi8kZrIdLaImrkasHHc2OoKizdXDOPJXSNy56f0XTYXSjbJz1pNMqovCf9uK_Ux2ieBA"><p class="wp-caption-text">Hình ảnh lòng động mạch liên thất trước của bà Lam sau khi được đặt stent có kích thước lên đến 5.2 mm (hình ảnh từ IVUS).</p></div> <p dir="ltr">Bên cạnh IVUS, kỹ thuật chụp cắt lớp quang học (OCT) trong lòng mạch vành được ứng dụng tại khoa Tim mạch BVĐK Tâm Anh Hà Nội cũng giúp đánh giá chính xác tổn thương để đưa ra hướng can thiệp hiệu quả và tối ưu nhất cho người bệnh, tránh trường hợp đặt stent ở nhiều vị trí dẫn đến tăng chi phí không cần thiết. Sau khi đặt stent, bác sĩ tiếp tục sử dụng OCT để đánh giá kết quả đặt stent trong mạch máu của người bệnh trước khi kết thúc can thiệp.</p> <p dir="ltr">“Nhờ sử dụng ánh sáng hồng ngoại, kỹ thuật chụp cắt lớp quang học cho hình ảnh lòng mạch có độ phân giải cao và rõ nét. Điều này giúp bác sĩ đánh giá độ bao phủ và vị trí của stent cũng như sự áp sát của stent vào lòng mạch một cách chính xác nhất, hạn chế tối đa các biến chứng trong quá trình can thiệp và giảm nguy cơ tái hẹp sau đặt stent”, BS.CKI Nguyễn Đức Hưng – Phó khoa tim mạch, BVĐK Tâm Anh Hà Nội cho biết.</p> <div id="attachment_61729" style="width: 857px" class="wp-caption aligncenter"><img aria-describedby="caption-attachment-61729" loading="lazy" class="size-full wp-image-61729 lazyload" src="https://tamanhhospital.vn/wp-content/uploads/2022/09/ung-dung-oct.jpg" alt="ứng dụng oct" width="847" height="566" srcset="https://tamanhhospital.vn/wp-content/uploads/2022/09/ung-dung-oct.jpg 847w, https://tamanhhospital.vn/wp-content/uploads/2022/09/ung-dung-oct-300x200.jpg 300w, https://tamanhhospital.vn/wp-content/uploads/2022/09/ung-dung-oct-768x513.jpg 768w" sizes="(max-width: 847px) 100vw, 847px" data-src="https://tamanhhospital.vn/wp-content/uploads/2022/09/ung-dung-oct.jpg"><p id="caption-attachment-61729" class="wp-caption-text">Ứng dụng OCT trong đặt stent mạch vành tại BVĐK Tâm Anh Hà Nội.</p></div> <p dir="ltr">Hiện nay, Bệnh viện Đa khoa Tâm Anh là đơn vị đầu tiên tại Việt Nam trang bị hệ thống chụp mạch can thiệp số hóa xóa nền (DSA) Philips Azurion Robotic Ceiling FlexArm treo trần, hoạt động linh hoạt giúp các bác sĩ có thể tiếp cận vùng cơ thể cần can thiệp dễ dàng nhờ vậy việc thực hiện thủ thuật can thiệp được nhanh chóng và chính xác hơn.</p> <p dir="ltr">Ngoài ra, nhờ kết hợp hệ thống phần mềm ứng dụng trong can thiệp tim mạch tiên tiến thế giới như Dynamic Coronary Roadmap, StentBoost Live, các bác sĩ có thể nong bóng, đặt stent dưới hướng dẫn của hình ảnh có độ phân giải cao, thao tác làm phồng bóng để đẩy stent áp sát vào thành mạch máu chính xác, rút ngắn thời gian can thiệp đồng thời giảm tối đa lượng thuốc cản quang đưa vào cơ thể bệnh nhân, giảm nguy cơ cho người bệnh suy thận, suy tim.</p> <p dir="ltr">Theo ước tính, có 17-48% bệnh nhân mạch vành có tình trạng rối loạn chức năng thận. Đồng thời, người bệnh thận mạn có tỷ lệ xơ vữa động mạch tăng cao và có xu hướng mắc bệnh mạch vành nặng hơn. Khoảng 50% bệnh nhân cao tuổi có bệnh thận mạn kèm suy tim – dấu hiệu tiến triển của bệnh mạch vành. Do đó, bác sĩ Long khuyến nghị, người bệnh thận mạn cần kiểm tra sức khỏe tim mạch định kỳ để được phát hiện hẹp mạch vành và xử trí kịp thời.</p> <p dir="ltr">Tại Bệnh viện đa khoa Tâm Anh, nhờ sự phối hợp chặt chẽ các chuyên khoa như Nội tim mạch, Can thiệp mạch, Thận – Tiết niệu, Gây mê hồi sức – Điều trị đau và chăm sóc giảm nhẹ…, bệnh nhân được chăm sóc và điều trị toàn diện trước và sau can thiệp, nhanh chóng hồi phục, xuất viện sau 3-5 ngày.</p> <p dir="ltr">“Tôi mà biết đặt stent nhẹ nhàng thế này tôi đã đến bệnh viện Tâm Anh làm lâu rồi. Suốt một năm qua, cơn đau ngực, khó thở cứ hành tôi mất ăn mất ngủ nhưng không dám chụp mạch vành vì sợ ảnh hưởng thận. Giờ thì tôi thấy khỏe rồi, ăn rất ngon, ngủ rất sâu. Bác sĩ cho tôi xem hình mạch máu sau khi nong mở rộng, cười bảo rằng 82 tuổi mà lòng mạch ‘trẻ’ như cô gái 28. Thật tuyệt vời!”, bà Lam chia sẻ ngày xuất viện.</p> <p dir="ltr"><img loading="lazy" class="aligncenter size-full wp-image-61718 lazyload" src="https://tamanhhospital.vn/wp-content/uploads/2022/09/thumb-live-14092022.jpg" alt="thumb live 14092022" width="847" height="476" srcset="https://tamanhhospital.vn/wp-content/uploads/2022/09/thumb-live-14092022.jpg 847w, https://tamanhhospital.vn/wp-content/uploads/2022/09/thumb-live-14092022-300x169.jpg 300w, https://tamanhhospital.vn/wp-content/uploads/2022/09/thumb-live-14092022-768x432.jpg 768w" sizes="(max-width: 847px) 100vw, 847px" data-src="https://tamanhhospital.vn/wp-content/uploads/2022/09/thumb-live-14092022.jpg"></p> <p dir="ltr">Vào lúc 20h ngày 14/9, hệ thống Bệnh viện Đa khoa Tâm Anh tổ chức chương trình tư vấn trực tuyến “Kỹ thuật mới chụp mạch vành và đặt stent tim mạch” nhằm cập nhật những tiến bộ mới trong chẩn đoán và can thiệp mạch vành, giảm nguy cơ tái hẹp, kéo dài tuổi thọ và chất lượng sống cho bệnh nhân mạch vành, đặc biệt là người có bệnh nền suy thận, suy tim, đái tháo đường…</p> <p dir="ltr">Chương trình có sự tham gia của BS.CKII Huỳnh Ngọc Long – Giám đốc Trung tâm Can thiệp mạch BVĐK Tâm Anh TP.HCM; ThS.BS Võ Anh Minh – Trưởng đơn vị Can thiệp mạch vành, Trung tâm Can thiệp mạch BVĐK Tâm Anh TP.HCM; BS.CKI Nguyễn Đức Hưng – Phó khoa Tim mạch BVĐK Tâm Anh Hà Nội và ThS.BS Nguyễn Tuấn Long – Bác sĩ Can thiệp tim mạch, BVĐK Tâm Anh Hà Nội.</p>
', 'phaocuusinh.png',N' Tại Bệnh viện đa khoa Tâm Anh, nhờ sự phối hợp chặt chẽ các chuyên khoa như Nội tim mạch, Can thiệp mạch, Thận – Tiết niệu, Gây mê hồi sức – Điều trị đau và chăm sóc giảm nhẹ…, bệnh nhân được chăm sóc và điều trị toàn diện trước và sau can thiệp, nhanh chóng hồi phục, xuất viện sau 3-5 ngày.',N'2022-01-04', 2, 3)
go

insert into BenhNhan values
(N'Nguyễn Tuấn Anh','098763332','tuananh@gmail.com',N'Hà Nội','1990-09-08',N'Nam','tuananh','123'),
(N'Bùi Nguyễn Dũng','098763312','dung@gmail.com',N'Hà Nội','1990-09-08',N'Nam','dung','123'),
(N'Nguyễn Thị Vinh','098773332','vinh@gmail.com',N'Đà Nằng','1994-09-08',N'Nữ','vinh','123'),
(N'Lưu Nhật Minh','098763932','minh@gmail.com',N'Sài Gòn','1991-09-08',N'Nữ','minh','123'),
(N'Hà Kiều Ân','098763330','an@gmail.com',N'Hà Nội','1990-09-08',N'Nữ','an','123')
go
insert into HoiDap values
(N'Tôi bị sốt liệu rằng có nhiễm CORONA không ?','2022-01-01','2022-01-02', N'Không . Điều đó bình thuờng.', 1, 1, 1),
(N'Vius lây bệnh qua người bằng con đường nào, thời gian lây bệnh đến phát bệnh trong thời gian bao lâu?','2022-01-01','2022-01-02', N'Virus này lây qua đường không khí, qua giọt bắn nước bọt, qua vật dụng, thời gian ủ bệnh là 14 ngày.', 2, 2, 1),
(N'Tôi muốn hỏi khi nào có thể tới khám?','2022-01-01','2022-01-02', N'Sau khi đặt lịch có thể tới khám, hoặc đến trực tiếp trung tâm hẹn lịch khám nhé.', 1, 2, 1),
(N'Hỏi đáp Khẩu trang y tế bình thường có khả năng cản virus như thế nào ?','2022-01-04','2022-01-07', N'Hiện nay khẩu trang y tế được sử dụng trong việc phòng chống bệnh truyền nhiễm, kể cả bệnh do nCoV. Bộ Y tế khuyến cáo khẩu trang y tế thông thường sử dụng tốt cho người có nguy cơ như làm việc ở cửa khẩu, làm việc ở bệnh viện, đi đến nơi đông người. Khẩu trang N95 sử dụng tốt cho người đi vào ổ dịch, người chăm sóc bệnh nhân tại ổ dịch.', 1, 1, 1),
(N'Tôi muốn tư vấn về sức khỏe.','2022-01-01','2022-01-02', N'Được mời bạn qua trung tâm hoặc để lại số điện thoại.', 3, 1, 1)
go

create table DangNhap(
		ma INT IDENTITY(1,1) PRIMARY KEY,
		tendn char(30) unique,
		mk char(30),
		quyen int,
		mand int
		)
go

insert into DangNhap values
('tuananh','123',2,1),
('dung','123',2,2),
('vinh','123',2,3),
('minh','123',2,4),
('an','123',2,5),

('admin','123',0,1),
('bsdung','123',1,2),
('bsmynhi','123',1,3),
('bsthaonghi','123',1,4),
('bshonghoa','123',1,5)
go
update NguoiDung set tendn=DangNhap.tendn, quyen=DangNhap.quyen
from DangNhap 
where NguoiDung.mand=DangNhap.mand and (DangNhap.quyen=0 or DangNhap.quyen=1)
go
update BenhNhan set tendn=DangNhap.tendn
from DangNhap 
where BenhNhan.mabn=DangNhap.mand and quyen=2
go
create trigger CapNhatTK on DangNhap for insert, update
as
begin
	update NguoiDung set tendn=DangNhap.tendn, quyen=DangNhap.quyen
from DangNhap 
where NguoiDung.mand=DangNhap.mand and (DangNhap.quyen=0 or DangNhap.quyen=1)
	update BenhNhan set tendn=DangNhap.tendn
from DangNhap 
where BenhNhan.mabn=DangNhap.mand and quyen=2
end


go
insert into CaKham values
('2022-12-20',N'Khám trong giờ','7:30-10:30', 2),
('2022-12-19',N'Khám trong giờ','13:30-16:30', 3),
('2022-12-15',N'Khám ngoài giờ','16:30-19:30',  4),
('2022-12-21',N'Khám ngoài giờ','19:30-21:30', 5),
('2022-12-15',N'Khám online','7:30-10:30', 3),
('2022-12-16',N'Khám trong giờ','7:30-10:30',  3),
('2022-12-18',N'Khám ngoài giờ','16:30-19:30', 4),
('2022-12-17',N'Khám trong giờ','16:30-19:30', 2),
('2022-12-15',N'Khám online','7:30-10:30', 2),
('2022-12-16',N'Khám trong giờ','7:30-10:30',  2),
('2022-12-15',N'Khám ngoài giờ','16:30-19:30', 2),
('2022-12-17',N'Khám ngoài giờ','16:30-19:30', 5)
go
Create trigger CapNhatDatLich on DatLich for insert, update
as
begin
	update DatLich set hoten=BenhNhan.tenbn, sdt=BenhNhan.sdt, ngaysinh=BenhNhan.ngaysinh
from BenhNhan
where DatLich.mabn=BenhNhan.mabn
	update DatLich set mabn =0
	where mabn is null
end
go

alter table CaKham ADD trangthai int
go
Update CaKham set trangthai=1
go


alter table BenhNhan ADD trangthai int
go
Update BenhNhan set trangthai=1
go


alter table NguoiDung ADD trangthai int
go
Update NguoiDung set trangthai=1
go

create trigger Ca on CaKham for insert
as
begin
Declare @mamoi int,@mand int
Select @mamoi=maca from inserted

	update CaKham set trangthai=1 where maca=@mamoi

end
go
create trigger bn on BenhNhan for insert
as
begin
Declare @mamoi int
Select @mamoi=mabn from inserted

	update BenhNhan set trangthai=1 where mabn=@mamoi

end
go
create trigger bs on NguoiDung for insert
as
begin
Declare @mamoi int
Select @mamoi=mand from inserted

	update NguoiDung set trangthai=1 where mand=@mamoi

end