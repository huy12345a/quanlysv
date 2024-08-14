CREATE DATABASE QUANLYSV;
use QUANLYSV;
CREATE TABLE DIEM
(
    Mahs    varchar(50),
    Toan    int,
    Ly      int,
    Hoa     int,
    Van     int,
    DTB     int,
    XepLoai varchar(50)
);
CREATE TABLE LOP
(
    Lop  varchar(100),
    GVCN varchar(50)
);
CREATE TABLE DSHS
(
    MaHS     varchar(100),
    Ho       varchar(100),
    Ten      varchar(100),
    Nu       boolean,
    NgaySinh Date,
    Lop      varchar(100),
    Ghichu   varchar(200)
);
INSERT INTO DIEM (Mahs, Toan, Ly, Hoa, Van, DTB, XepLoai)
VALUES ('HS001', 8, 7, 9, 6, (8 + 7 + 9 + 6) / 4, 'Khá'),
       ('HS002', 7, 6, 8, 7, (7 + 6 + 8 + 7) / 4, 'Trung bình'),
       ('HS003', 9, 8, 9, 9, (9 + 8 + 9 + 9) / 4, 'Giỏi'),
       ('HS004', 6, 5, 7, 6, (6 + 5 + 7 + 6) / 4, 'Trung bình'),
       ('HS005', 8, 8, 8, 8, (8 + 8 + 8 + 8) / 4, 'Khá');
INSERT INTO LOP (Lop, GVCN)
VALUES ('10A1', 'Mr. Nam'),
       ('10A2', 'Ms. Hoa'),
       ('11B1', 'Mr. Minh'),
       ('11B2', 'Ms. Lan'),
       ('12C1', 'Mr. Tung');
INSERT INTO DSHS (MaHS, Ho, Ten, Nu, NgaySinh, Lop, Ghichu)
VALUES ('HS001', 'Nguyen', 'Na', TRUE, '2006-03-15', '10A1', 'Học giỏi môn Toán'),
       ('HS002', 'Le', 'Bao', FALSE, '1999-06-09', '10A2', 'Cần cải thiện điểm số'),
       ('HS003', 'Tran', 'Cuong', FALSE, '2005-11-20', '11B1', 'Học sinh ưu tú'),
       ('HS004', 'Hoang', 'Duc', TRUE, '2006-09-03', '11B2', 'Thực hành nhiều môn khác'),
       ('HS005', 'Pham', 'Nam', TRUE, '2005-05-28', '12C1', 'Học sinh kha');
DROP TABLE DSHS;
DROP TABLE DIEM;
DROP TABLE LOP;
# Hiện danh sách sinh viên: mã hs, họ và tên (là 1 cột), ngày sinh
SELECT MaHS, CONCAT(Ho, ' ', Ten) AS HoTen, NgaySinh
FROM DSHS;
# Hiện danh sách sinh viên: mã hs, họ và tên (là 1 cột), sinh ngày 20
SELECT MaHS, CONCAT(Ho, ' ', Ten) AS HoTen, NgaySinh
FROM DSHS
WHERE DAY(NgaySinh) = 20;
# Hiện danh sách sinh viên: mã hs, họ và tên (là 1 cột), ngày sinh là 6/9/1999
SELECT MaHS, CONCAT(Ho, ' ', Ten) AS HoTen, NgaySinh
FROM DSHS
WHERE NgaySinh = '1999-06-09';
# Hiện danh sách sinh viên: mã hs, họ và tên (là 1 cột), tên là NA
SELECT MaHS, CONCAT(Ho, ' ', Ten) AS HoTen, NgaySinh
FROM DSHS
WHERE Ten = 'NA';
# Hiện danh sách sinh viên: mã hs, họ và tên (là 1 cột), tên bắt đầu bằng chữ N
SELECT MaHS, CONCAT(Ho, ' ', Ten) AS HoTen, NgaySinh
FROM DSHS
WHERE Ten LIKE 'N%';
# Danh sách sinh viên có tên chứa "NA"
SELECT MaHS, CONCAT(Ho, ' ', Ten) AS HoTen, NgaySinh
FROM DSHS
WHERE Ten LIKE '%NA%';
# Đếm số sinh viên tên bắt đầu bằng chữ N
SELECT COUNT(*) AS SoLuong
FROM DSHS
WHERE Ten LIKE 'N% ';
# Hiện danh sách sinh viên: họ và tên (là 1 cột), ngày sinh, tên lớp, tên GVCN
SELECT CONCAT(DSHS.Ho, ' ', DSHS.Ten) AS HoTen, DSHS.NgaySinh, LOP.Lop, LOP.GVCN
FROM DSHS
         JOIN LOP ON DSHS.Lop = LOP.Lop;
# Hiện danh sách sinh viên: họ và tên (là 1 cột), ngày sinh, điểm trung bình, xếp loại
SELECT CONCAT(DSHS.Ho, ' ', DSHS.Ten) AS HoTen, DSHS.NgaySinh, DIEM.DTB, DIEM.XepLoai
FROM DSHS
         JOIN DIEM ON DSHS.MaHS = DIEM.Mahs;
# Đếm số học sinh của mỗi lớp
SELECT Lop, COUNT(*) AS SoLuong
FROM DSHS
GROUP BY Lop;
# Hiện ra lớp có số lượng sinh viên > 5
SELECT Lop
FROM DSHS
GROUP BY Lop
HAVING COUNT(*) > 5;
# Hiện thông lớp có số lượng sinh viên nhiều nhất
SELECT Lop
FROM DSHS
GROUP BY Lop
ORDER BY COUNT(*) DESC
LIMIT 1;
# Tìm học sinh có điểm lớn nhất
SELECT DSHS.MaHS, CONCAT(DSHS.Ho, ' ', DSHS.Ten) AS HoTen, MAX(DIEM.DTB) AS DiemMax
FROM DSHS
         JOIN DIEM ON DSHS.MaHS = DIEM.Mahs
GROUP BY DSHS.MaHS, DSHS.Ho, DSHS.Ten
ORDER BY DiemMax DESC
LIMIT 1;
# Hiện ra danh sách các học sinh có điểm tb > 8
SELECT *
FROM DSHS
         JOIN DIEM ON DSHS.MaHS = DIEM.Mahs
WHERE DIEM.DTB > 8;
# Tổng điểm tb của các bạn có tên bắt đầu bằng chữ NA
SELECT SUM(DIEM.DTB) AS TongDTB
FROM DSHS
         JOIN DIEM ON DSHS.MaHS = DIEM.Mahs
WHERE DSHS.Ten LIKE 'NA%';
# Hiện ra danh sách các học sinh có điểm tb > 5 và điểm toán > 8
SELECT *
FROM DSHS
         JOIN DIEM ON DSHS.MaHS = DIEM.Mahs
WHERE DIEM.DTB > 5 AND DIEM.Toan > 8;
# Hiện ra danh sách các học sinh có xếp loại là giỏi
SELECT *
FROM DSHS
         JOIN DIEM ON DSHS.MaHS = DIEM.Mahs
WHERE DIEM.XepLoai = 'Giỏi';
# Đếm số lượng học sinh giỏi
SELECT COUNT(*) AS SoLuongHS
FROM DSHS
         JOIN DIEM ON DSHS.MaHS = DIEM.Mahs
WHERE DIEM.XepLoai = 'Giỏi';
# In ra các học sinh chưa tham gia thi
SELECT MaHS, CONCAT(Ho, ' ', Ten) AS HoVaTen
FROM DSHS
WHERE MaHS NOT IN (SELECT Mahs FROM DIEM);
# In ra học sinh có điểm trung bình lớn nhất của từng lớp
WITH MaxDTB AS (
    SELECT Lop, MAX(DTB) AS MaxDTB
    FROM DSHS
             JOIN DIEM ON DSHS.MaHS = DIEM.Mahs
    GROUP BY Lop
)
SELECT DSHS.Lop, DSHS.MaHS, CONCAT(DSHS.Ho, ' ', DSHS.Ten) AS HoVaTen, DIEM.DTB
FROM DSHS
         JOIN DIEM ON DSHS.MaHS = DIEM.Mahs
         JOIN MaxDTB ON DSHS.Lop = MaxDTB.Lop AND DIEM.DTB = MaxDTB.MaxDTB
ORDER BY DSHS.Lop;


CREATE TABLE users
(
    id       INT AUTO_INCREMENT PRIMARY KEY,
    name     VARCHAR(100),
    email    VARCHAR(100) UNIQUE,
    password VARCHAR(100)
)













