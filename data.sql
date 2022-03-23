create database quanlyvattu;
use quanlyvattu;
create table vattu
(
    id        int auto_increment primary key,
    mavattu   nvarchar(20) not null unique,
    tenvattu  nvarchar(50) not null,
    donvitinh nvarchar(20),
    giatien   int
);
select *
from vattu;
create table tonkho
(
    id              int auto_increment primary key,
    id_vattu        int,
    soluongdau      int,
    tongsoluongnhap int,
    tongsoluongxuat int,
    foreign key (id_vattu) references vattu (id)
);
select *
from tonkho;

create table nhacungcap
(
    id           int auto_increment primary key,
    manhacungcap nvarchar(20) not null,
    ten          nvarchar(50) not null,
    diachi       nvarchar(100),
    sdt          int
);
select *
from nhacungcap;
create table donhang
(
    id            int auto_increment primary key,
    madon         nvarchar(20) not null,
    ngaydathang   date         not null,
    id_nhacungcap int,
    foreign key (id_nhacungcap) references nhacungcap(id)
);
select * from donhang;

create table phieunhap(
                          id int auto_increment primary key ,
                          maphieu nvarchar(20) not null ,
                          ngaynhap date,
                          id_donhang int,
                          foreign key (id_donhang) references donhang(id)
);
select * from phieunhap;

create table phieuxuat (
                           id int auto_increment primary key ,
                           maphieu nvarchar(20) not null ,
                           ngayxuat date,
                           tenkhachhang nvarchar(50)
);
select * from phieuxuat;

create table chitietdonhang(
                               id int auto_increment primary key ,
                               id_donhang int,
                               id_vattu int,
                               soluongdat int,
                               foreign key (id_donhang) references donhang(id),
                               foreign key (id_vattu) references vattu(id)
);
select * from chitietdonhang;

create table chitietphieunhap(
                                 id int auto_increment primary key ,
                                 id_phieunhap int,
                                 id_vattu int,
                                 soluongnhap int,
                                 dongianhap int,
                                 ghichu text,
                                 foreign key (id_vattu) references vattu(id),
                                 foreign key (id_phieunhap) references phieunhap(id)
);
select *
from chitietphieunhap;

create table chitietphieuxuat(
                                 id  int auto_increment primary key ,
                                 id_phieuxuat int,
                                 id_vattu int,
                                 soluongxuat int,
                                 dongiaxuat int,
                                 ghichu text,
                                 foreign key (id_vattu) references vattu(id),
                                 foreign key (id_phieuxuat) references phieuxuat(id)
);
select * from chitietphieuxuat;

create view vw_CTPNHAP as
select p.maphieu,v.mavattu,c.soluongnhap,c.dongianhap, c.soluongnhap*c.dongianhap as 'thanhtien'
from phieunhap p join chitietphieunhap c on p.id = c.id_phieunhap
                 join vattu v on c.id_vattu = v.id
;
select * from vw_CTPNHAP;
create view vw_CTPNHAP_VT as
select p.maphieu,v.mavattu,v.tenvattu,c.soluongnhap,c.dongianhap, c.soluongnhap*c.dongianhap as 'thanhtien'
from phieunhap p join chitietphieunhap c on p.id = c.id_phieunhap
                 join vattu v on c.id_vattu = v.id
;
select * from vw_CTPNHAP_VT;
create view vw_CTPNHAP_VT_PN as
select p.maphieu,p.ngaynhap,d.madon,v.mavattu,v.tenvattu,c.soluongnhap,c.dongianhap, c.soluongnhap*c.dongianhap as 'thanhtien'
from phieunhap p join chitietphieunhap c on p.id = c.id_phieunhap
                 join vattu v on c.id_vattu = v.id
                 join donhang d on p.id_donhang = d.id
;
select * from vw_CTPNHAP_VT_PN;
create view vw_CTPNHAP_VT_PN_DH as
select p.maphieu,p.ngaynhap,d.madon,n.manhacungcap,v.mavattu,v.tenvattu,c.soluongnhap,c.dongianhap, c.soluongnhap*c.dongianhap as 'thanhtien'
from phieunhap p join chitietphieunhap c on p.id = c.id_phieunhap
                 join vattu v on c.id_vattu = v.id
                 join donhang d on p.id_donhang = d.id
                 join nhacungcap n on d.id_nhacungcap = n.id
;
select * from vw_CTPNHAP_VT_PN_DH;

create view vw_CTPNHAP_loc as
select p.maphieu,v.mavattu,c.soluongnhap,c.dongianhap, c.soluongnhap*c.dongianhap as 'thanhtien'
from phieunhap p join chitietphieunhap c on p.id = c.id_phieunhap
                 join vattu v on c.id_vattu = v.id where c.soluongnhap > 5
;
select * from vw_CTPNHAP_loc;

create view vw_CTPNHAP_VT_loc as
select p.maphieu,v.mavattu,v.tenvattu,c.soluongnhap,c.dongianhap, c.soluongnhap*c.dongianhap as 'thanhtien'
from phieunhap p join chitietphieunhap c on p.id = c.id_phieunhap
                 join vattu v on c.id_vattu = v.id where v.donvitinh = 'nai'
;
select * from vw_CTPNHAP_VT_loc;





