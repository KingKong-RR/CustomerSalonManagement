-- =============================================
-- Create database For Customer Salon Management
-- =============================================
-- CreateDB.sql
--
-- Projekt      : Datenbanken
-- Version      : 1.0
-- Autor        : Rexhep, Didier, Coco
-- Erstelldatum : 10.06.2022
-- Bemerkungen  : 
--
-- Change log
-- 
--
-- Datenbank erstellen
--
USE master

DROP PROCEDURE IF EXISTS CustomerSalonManagementDB;
go

create database CustomerSalonManagementDB;
go

use CustomerSalonManagementDB;

--
-- Step 1, Tabellen erstellen
--


--
-- Tabelle Traeger erstellen
--
create table [Title]
(
	[TitleID] 			int 			not null	identity(1,1)	unique,
    [Title]				varchar(45)		not null,
    constraint pk_title primary key (TitleID)
);

--
-- Tabelle Ort erstellen
--
create table [Address]
(
	[AddressID] 		int				not null	identity(1,1)	unique,
    [ZIP]				int				not null,
	[City] 				varchar(45)		not null,
    constraint pk_address primary key (AddressID)
);

--
-- Tabelle Stil erstellen
--
create table [Product]
(
	[ProductID] 		int 			not null	identity(1,1)	unique,
    [Name]				varchar(50)		not null,
	[Price]				decimal(3,2)	not null,
    constraint pk_product primary key (ProductID)
);

--
-- Tabelle Musikstuek erstellen
--
create table [Service]
(
	[ServiceID]			int 			not null	identity(1,1)	unique,
    [Type]				varchar(50) 	not null,
    [Price]				decimal(3,2)	not null,
    [Duration]			decimal(2,2)	not null,
    constraint pk_service primary key (ServiceID)
);

--
-- Tabelle Alben erstellen
--
create table [Discount]
(
	[DiscountID]		int 			not null	identity(1,1)	unique,
    [Visits]			int 			not null,
    [DiscountRate]		int				not null, 
    constraint pk_discount primary key (DiscountID)
);

--
-- Tabelle Interpret erstellen
--
create table [Employee]
(
	[EmployeeID]		int 			not null	identity(1,1)	unique,
    [FirtsName]			varchar(50)		not null,
	[LastName]			varchar(50)		not null,
	[DateOfBirth]		Date			not null,
	[Street]			varchar(50)		not null,
	[AddressID]			int				not null,
	[TitleID]			int				not null,
    constraint pk_employee primary key (EmployeeID, TitleID)
);

--
-- Tabelle AlbumInhalt erstellen
--
create table [Customer]
(
    [CustomerID] 		int				not null	identity(1,1)	unique,
    [FirtsName]			varchar(50)		not null,
	[LastName]			varchar(50)		not null,
	[DateOfBirth]		Date			not null,
	[DateOfEntry]		Date			not null,
	[Street]			varchar(50)		not null,
	[TitleID]			int				not null,
	[AddressID]			int				not null,
	[DiscountID]		int				not null,

    constraint pk_customer primary key (CustomerID, TitleID, AddressID, DiscountID)
);

--
-- Tabelle Interpret erstellen
--
create table [Booking]
(
	[BookingID]	 		int 			not null 	identity(1,1)	unique,
    [Date]				DateTime		not null,
	[ServiceID]			int				not null,
	[EmployeeID]		int				not null,
	[ProductID]			int				not null,
	[CustomerID]		int				not null,
    constraint pk_booking primary key (BookingID, ServiceID, EmployeeID, ProductID)
);

--
-- Step 2, foreign key constraints erstellen
--
alter table [Employee]
	add constraint fk_employee_title foreign key (TitleID) references [Title](TitleID),
		constraint fk_employee_address foreign key (AddressID) references [Address](AddressID);

alter table [Customer]
	add constraint fk_customer_title foreign key (TitleID) references [Title](TitleID),
		constraint fk_customer_address foreign key (AddressID) references [Address](AddressID),
		constraint fk_customer_discount foreign key (DiscountID) references [Discount](DiscountID);

alter table [Booking]
	add constraint fk_booking_service foreign key (ServiceID) references [Service](ServiceID),
		constraint fk_booking_employee foreign key (EmployeeID) references [Employee](EmployeeID),
		constraint fk_booking_product foreign key (ProductID) references [Product](ProductID);

--
-- Step 3, Index erstellen
-- 
create index idx_Booking_ServiceID on [Booking](ServiceID);

create index idx_Booking_EmployeeID on [Booking](EmployeeID);

create index idx_Booking_ProductID on [Booking](ProductID);

create index idx_Booking_CustomerID on [Booking](CustomerID);
    
    
