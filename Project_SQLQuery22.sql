use Servicely
update Booking set Status = 'Pending' where WUserName='amalik'

select BookTime, EndTime, BookDate, BookId from Booking where WUserName='fahmad'

select count(*) as orders,BookDate
from Booking
where WUserName='amalik' 
group by BookDate
order by BookDate ASC

select * from Booking

select  (select avg(Rating) from Booking where WUserName='amalik') as Rating,
		(select count(*) from Booking where WUserName='amalik' and Status='Completed') as Completed,
		(select count(*) from Booking where WUserName='amalik' and Status='Pending') as Pending,
		(select count(*) from Booking where WUserName='amalik' and ( Status='Completed' or Status='Accepted') ) as Total,
		(select count(*) from Booking where (month(BookDate) = month(getdate()) and year(BookDate) = year(getdate())) 
				and WUserName = 'amalik' and ( Status='Completed' or Status='Accepted')) as ThisMonth,
		(select WorkPrice from Worker where UserName = 'amalik') as Price


		select BookTime, EndTime, BookDate, BookId from Booking where WUserName='${id}' and (Status='Pending' or Status='Accepted') and BookDate='${date1}'

select * from Worker
select * from Customer
select * from Booking where WUserName='aali'



SELECT COUNT(*) as OrdersCount, CONVERT(DATE, BookDate) as BookingDate
        FROM Booking
        WHERE WUserName = 'amalik' 
        AND BookDate >= DATEADD(day, -30, GETDATE())
        GROUP BY CONVERT(DATE, BookDate)
        ORDER BY BookingDate DESC


		WITH CTE AS (
		SELECT DATEADD(day, -29, GETDATE()) as day
		UNION ALL
		SELECT DATEADD(day, 1, day) 
		FROM CTE
		WHERE day < GETDATE()
		)
		SELECT 
			CTE.day,
			COALESCE(COUNT(CASE WHEN Booking.WUserName = 'amalik' 
			AND CAST(Booking.BookDate AS DATE) < CTE.day 
			THEN Booking.BookId END), 0) AS Orders
		FROM CTE
		LEFT JOIN Booking
		ON Booking.WUserName = 'amalik'
		GROUP BY CTE.day
		ORDER BY CTE.day ASC


		WITH CTE AS (
    SELECT DATEADD(day, -29, GETDATE()) as day
    UNION ALL
    SELECT DATEADD(day, 1, day) 
    FROM CTE
    WHERE day < GETDATE()
)
SELECT 
    CTE.day,
    COALESCE(COUNT(CASE WHEN WUserName='amalik' and CAST(Booking.BookDate AS DATE) = CTE.day THEN Booking.BookId END), 0) AS Orders
FROM CTE
LEFT JOIN Booking
ON CAST(Booking.BookDate AS DATE) = CTE.day and WUserName='amalik'
GROUP BY CTE.day
ORDER BY CTE.day ASC





		WITH CTE AS (
		SELECT DATEADD(day, -6, GETDATE()) as day
		UNION ALL
		SELECT DATEADD(day, 1, day) 
		FROM CTE
		WHERE day < GETDATE()
		)
		SELECT
			COALESCE(AVG(CASE WHEN Booking.WUserName = 'amalik' 
			AND CAST(Booking.BookDate AS DATE) < CTE.day 
			THEN Booking.Rating END), 0) AS Rating
		FROM CTE
		LEFT JOIN Booking
		ON Booking.WUserName = 'amalik'
		GROUP BY CTE.day
		ORDER BY CTE.day ASC



		select AVG(Rating) as avg from Booking where WUserName='amalik'

select * from Booking where WUserName='amalik'  and Rating is not NULL

select * from Booking where WUserName='tkhurshid'
select WUserName, count(*) from Booking group by WUserName
select B.BookDate, B.BookTime, B.EndTime, B.Status, C.CustFirstName, C.CustCity, C.CustHNo, C.CustStreet from Booking B, Customer C where B.WUserName = 'amalik' and (C.UserName=B.CUsername and Status = 'Rejected')

Create table Service(
	SId integer constraint OID_Required NOT NULL,
	SName varchar(20),
	SDesc varchar(300),
	constraint PK_Service Primary Key(SId)
)

Create table Customer(
	Username varchar(20) constraint CName_Required NOT NULL,
	CustFirstName varchar(15),
	CustLastName varchar(15),
	CustDOB date,
	CustGender char(1),
	CustPhoneNo varchar(12),
	CustHNo varchar(10),
	CustStreet varchar(30),
	CustCity varchar(20),
	Password varchar(16),
	Email varchar(20),
	CNIC varchar(20),
	constraint PK_Customer Primary Key(UserName)

)

create table Worker(
	Username varchar(20) constraint CName_Required NOT NULL,
	WorkFirstName varchar(15),
	WorkLastName varchar(15),
	WorkDOB date,
	WorkGender char(1),
	WorkPhoneNo varchar(12),
	WorkHNo varchar(10),
	WorkStreet varchar(30),
	WorkCity varchar(20),
	WorkExperience integer,		--no of years	
	WorkPrice decimal(6,2),		--per hour price
	workDesc varchar(300),
	Password varchar(16),
	Email varchar(20),
	SId integer,
	constraint PK_Worker Primary Key(UserName),
	CNIC varchar(20),
	constraint FK_Service Foreign key(SId) references Service
)

Create table Booking(
	BookId	int identity(1,1),
	CUserName varchar(20),
	WUserName varchar(20),
	BookTime time,
	EndTime time,
	BookDate date,
	Review varchar(300),
	Status varchar(10),
	Rating integer constraint Check_Ratinng check(Rating>=1 And Rating<=5),
	constraint FK_Customer Foreign Key(CUserName) references Customer,
	constraint FK_Worker Foreign Key(WUserName) references Worker,
	constraint PK_Booking Primary Key(BookId, CUserName, WUserName)
)


Insert into Service values
(1, 'Electriacian', 'We provide the best residential and commercial electrical services for your power needs. Request service and get offers from best service providers in all electrical services' ),
(2, 'Mechanic', 'We know how hard it is to find the right person especially when it comes to the matter of mechanic. Rise above your troubles because Servicely is here.'),
(3, 'Carpenter', 'Our professional carpenters will redesign your home, making it appear exceptionally stylish at an affordable price. Book online furniture repair and carpentry services.'),
(4, 'Plumber', 'Are you having issues with your faucets and sinks? Common problems can include leaky faucets, low water pressure, clogged drains, hot water issues, loose faucet handles, and more.'),
(5, 'Pest Control', 'We provide professional pest control services for your home and business. Book highly experienced in-house professionals & get it done, Instantly.'),
(6, 'Salon', 'Servicely offers beauty salon solution at your doorstep by trained professionals around your home with affordable prices.'),
(7, 'laundry', 'Our experienced in-house workers knows how to remove the deep-down dirt, stubborn stains and eliminate bacteria from the clothes. So, your clothes remains in their best quality for the long run.'),
(8, 'Gardener', 'Undoubtedly, garden maintenance is pretty fun, but a time-consuming task. So, why not let Servicely over this responsibility'),
(9, 'Painter', 'Affordable building & wall paint services for homes and offices. Whitewash, plastic emulsion, enamel paint, polishing & related services. Find out the best professional through Servicely')


insert into Customer values
('aabbasi','Ali','Abbasi', '25-Oct-1995', 'M', '0312-5439112', 'LA-6/B', '30-Davis Road', 'Lahore','customer','user1@gmail.com','35201-0000000-1'),
('ajafri','Ayyan','Jafri', '03-Feb-2000', 'M', '0346-5458666', '49-C', 'Arkay Square Extension', 'Karachi','customer','user2@gmail.com','35201-0000000-2'),
('dfarooq','Danial','Farooq', '31-Dec-1994', 'M', '0321-5333576', 'B-5', '7-Ravi Road', 'Lahore','customer','user3@gmail.com','35201-0000000-3'),
('hahmad','Huzaifa','Ahmad', '04-Jan-1997', 'M', '0333-6779432', '98-A', 'Margalla Road, F-6/2', 'Islamabad','customer','user4@gmail.com','35201-0000000-4'),
('nali','Nouman','Ali', '16-May-2001', 'M', '0311-2387235', 'SA-24/C', 'Syed Maratib Ali Road', 'Lahore','customer','user6@gmail.com','35201-0000000-5'),
('anasir','Amna','Nasir', '16-Dec-1999', 'F', '0305-7898654','B-47', 'Trade Center,Block 13-A', 'Karachi','customer','user7@gmail.com','35201-0000000-6'),
('aifzal','Aqsa','Ifzal', '09-Sep-1992', 'F', '0326-9546431', '142-B', 'Unit No.3 Latifabad', 'Hyderabad','customer','user8@gmail.com','35201-0000000-7'),
('timran','Tabish','Imran', '12-Feb-2003', 'F', '0312-1149756', '14-C', 'Haider Road Saddar', 'Rawalpindi','customer','user9@gmail.com','35201-0000000-8')

insert into Worker values
('maamir','Muhammad','Aamir','02-Mar-1990','M','0343-7654218','C-232','New Garden Town','Rawalpindi',4,1000.00,'My top priority is to help customers at my best and takling almost any electronic hurdle.','worker','worker1@gmail.com',1,'35201-0000000-9'),
('anaseer','Arslan','Naseer','14-Oct-1994','M','0322-9456232','CW-24','Temple Road','Rawalpindi',3,600.00,'I am specialized in construction work related to the design, installation, and maintenance of electrical systems.','worker','worker2@gmail.com',1,'35201-0000001-0'),
('fahmad','Faiz','Ahmad','01-Jan-1994','M','0324-6555433','S-6','Steel Market Road','Karachi',5,1000.00,'I will provide the occasion, reliable, and cost-efficient electrical services.','worker','worker3@gmail.com',1,'35201-0000001-1'),
('amalik','Ayaan','Malik','12-Jan-1992','M','0311-9889974','WS-103','Shahrah-e-Liaqat','Karachi',7,1400.00,'I am aspire to provide the most responsive and personalized electrical services.','worker','worker4@gmail.com',1,'35201-0000001-2'),
('jnaseer','Jibran','Naseer','24-Jun-1996','M','0345-5445545','D-286/6','KDA Scheme  1-A','Hyderabad',6,1200.00,'I am dedicated to manage all of your residential and commercial electrical issues safely.','worker','worker5@gmail.com',1,'35201-0000001-3'),
('hsikandar','Hameen','Sikandar','30-Sep-2002','M','0333-5677653','H-78/6','G.t Road Opp.','Hyderabad',2,800.00,'I will focus on your needs and specifications having good knowledge of electric appliances.','worker','worker6@gmail.com',1,'35201-0000001-4'),
('uahmad','Umair','Ahmad','02-Sep-1997','M','0340-5674328','B-86/3','Sector I-9/2','Islamabad',6,900.00,'I will do electrical rewiring and all electrical work for your residential place.','worker','worker7@gmail.com',1,'35201-0000001-5'),
('simran','Saim','Imran','28-Dec-2000','M','0320-5933421','B-19','Siddiq Wahab Road','Lahore',3,800,'I am able to do repair & maintenance work in addition to tasks associated with new construction.','worker','worker8@gmail.com',1,'35201-0000001-6'),
('siqbal','Saifi','Iqbal','05-Nov-1995','M','0322-1457920','60A','Korangi Industrial Area','Lahore',7,1500,'I will deliver th ebest quality work That never gives any vhnace to you for any complaints.','worker','worker9@gmail.com',1,'35201-0000001-7'),
('ashah','Azlan','Shah','18-Oct-2002','M','0311-5478924','862','Faisal Garden','Lahore',2,700,'I can tackle any kind of of electrical work at both residential and commerciaal area.','worker','worker10@gmail.com',1,'35201-0000001-8'),
('sshahid','Shayan','Shahid','03-Feb-1997','M','0318-5678222','F-93','Al-Syed Arcade','Lahore',5,900,'I am giving an entire variety of services and products such as monitoring for people in addition to fleets.','worker','worker01@gmail.com',2,'35201-0000001-9'),
('tkhurshid','Taha','Khurshid','22-Mar-1998','M','0327-2223334','A-40','M.A Jinnah Road','Karachi',4,900,'I will focus to offer exceptional maintenance an honest and reliable service.','worker','worker12@gmail.com',2,'35201-0000002-0'),
('smubeen','Sarim','Mubeen','23-Mar-1990','M','0343-7564218','CB-25','Munsafi Road','Rawalpindi',5,1000,'I provide the best service of making new furniture and repairing and polishing old ones.','worker','worker13@gmail.com',3,'35201-0000002-1'),
('aali','Azhar','Ali','14-Dec-1993','M','0322-9454332','LA-60','Khiaban-2','Hyderabad',3,800,'I will provide the professional carpentary service and will do quality work.','worker','worker14@gmail.com',3,'35201-0000002-2'),
('hali','Haider','Ali','01-Oct-1994','M','0324-6558933','C-24/7','Afshane Colony','Jhelum',5,900,'I offer plumbing, installation and maintenance service and always be fully prepared and able to meet any of your plumbing needs.','worker','worker15@gmail.com',4,'35201-0000002-3'),
('atayyab','Ammar','Tayyab','31-Jan-1992','M','0311-9888874','WX-76','Aurengzeb Block','Lahore',6,1200,'I can do maintenance and repair work as well as task related to new construction.','worker','worker16@gmail.com',4,'35201-0000002-4'),
('husman','Hadi','Usman','08-Jun-1996','M','0345-5466545','AB-79','Chah Tarkhanan Khan','Sialkot',6,1200,'I am offering pest control services, termite control services, bed bug treatment and cockroach control services.','worker','worker17@gmail.com',5,'35201-0000002-5'),
('amohsin','Azhaan','Mohsin','30-Sep-2001','M','0333-5877653','B-9','Sector H-8','Islamabad',2,700,'I am specialized in stored products fumigation, termite proofing, and other structural pests control.','worker','worker18@gmail.com',5,'35201-0000002-6'),
('sahmad','Saqib','Ahmad','02-Jun-1997','M','0340-5999328','B-8','Railway Road','Rawalpindi',3,800,'I  offer professional beauty treatments and therapy to make you look and feel your best. ','worker','worker19@gmail.com',6,'35201-0000002-7'),
('aiman','Aabish','Iman','22-Mar-1996','F','0327-7453334','A-2','I-10/2','Islamabad',4,900,'I offer various services such as haircuts and styling, facial, makeup, bridal services, manicure and pedicure. ','worker','worker20@gmail.com',6,'35201-0000002-8'),
('sjibreen','Safwan','Jibreen','28-Dec-2003','M','0320-6667732','C-56','Churangi','Lahore',1,600,'I will give you the best laundry services in attire cleaning and impolding.','worker','worker21@gmail.com',7,'35201-0000002-9'),
('aarsalan','Anabiya','Arsalan','19-Aug-1999','F','0317-3874112','D-34/11','DHA','Rawalpindi',4,900,'I am providing the cleaning of gents clothing, ladies clothing, Blankets, Bed sheet, Curtains, Carpet and Sofa.','worker','worker22@gmail.com',7,'35201-0000003-0'),
('sisrar','Shahzain','Israr','25-May-1995','M','0322-1445920','D-78','Talpur Road','Hyderabad',6,1200,'I am offering gardening services, landscape design & development services and maintenance services for landscape areas/lawns.','worker','worker23@gmail.com',8,'35201-0000003-1'),
('mfayyaz','Muskan','Fayyaz','04-Dec-2004','F','0336-4719281','B-60','Johar Town','Karachi',0,500,'I am providing one of the best gardening services including artificial plants, pots, planters, flowers, water fountains, etc.','worker','worker24@gmail.com',8,'35201-0000003-2'),
('mfareed','Mahir','Fareed','16-Oct-2002','M','0325-5478924','A-2','Clifton','Karachi',2,700,'I am offering wall distemper and weather-sheet painting, inner paint and distempering and long term maintenance.','worker','worker25@gmail.com',9,'35201-00000003-3'),
('jiqbal','Javed','Iqbal','23-Feb-1997','M','0318-5676622','B-45','Lalkurti','Rawalpindi',6,1100,'I offer impeccable painting services and constantly working towards a better system to enhance your overall painting experience.','worker','worker26@gmail.com',9,'35201-0000003-4')

--cust, worker, time, date, review, rating
insert into Booking values
('ajafri','ashah','12:00:00','13:00:00','01-Jan-2023','I am very happy with the job he did. He painted our entire house very good. I highly recommend him.','Accepted', 5),
('anasir','mfayyaz','09:00:00','10:00:00','23-Dec-2022','He is very competent, very friendly, very hardworking and reliable. Very hard to find gardeners of his calibre anywhere.','Completed', 4),
('dfarooq','sjibreen','13:00:00','15:00:00','02-Jan-2022','Not happy with his work. The clothes are still dirty. I just got may time and money wasted.','Completed', 1),	
('hahmad','sahmad','10:00:00','12:00:00','31-Dec-2022','I will always recomend Saaqib Ahmad for Hair services as I had the best experience of availing service from him several times.','Completed', 5),	
('hahmad','amohsin','11:00:00','12:00:00','15-Nov-2022','Having a positive experience. Timely, personable and concerned about doing the right thing for the customer.','Completed', 3), 
('nali','atayyab','12:00:00','15:00:00','01-Jan-2022','Quick response, courteous and overall great quality.','Completed', 5),	
('aifzal','aali','13:00:00','15:00:00','20-Dec-2022','Very honest, customer friendly, and fast service.','Completed', 4),	
('anasir','tkhurshid','13:00:00','14:00:00','04-Dec-2022','Very professional, client focused and above and beyond customer service.','Completed', 5),	
('anasir','amalik','11:00:00','12:00:00','22-Oct-2022','He was very reliable personable and professional throughout his time with us.','Completed', 4),
('ajafri','amalik','15:00:00','16:00:00','13-Nov-2022','Exceptional service from him. Very professional and trustworthy workmen - he came on time, did the work with no fuss and even cleaned up afterwards with his own vacuum cleaner.','Completed', 5),
('anasir','amalik','10:00:00','11:00:00','16-Nov-2022','So very pleased with the work carried out today by Ayaan. He kept us informed at every level in a most professional manner.','Completed', 5),
('ajafri','amalik','14:00:00','15:00:00','05-Dec-2022','I have used his service a number of times and have found him very helpful and polite and would recommend him.','Completed', 4),
('nali','atayyab','12:00:00','15:00:00','02-Jan-2022',NULL,'Rejected', NULL),	
('aifzal','aali','13:00:00','15:00:00','21-Dec-2022',NULL,'Rejected', NULL),	
('anasir','tkhurshid','13:00:00','14:00:00','06-Dec-2022',NULL,'Rejected',NULL),
('anasir','tkhurshid','13:00:00','14:00:00','06-Dec-2022',NULL,'Rejected',NULL),
('nali','atayyab','12:00:00','15:00:00','02-Jan-2022',NULL,'Rejected', NULL),	
('aifzal','amalik','13:00:00','15:00:00','21-Jan-2022',NULL,'Pending', NULL),	
('anasir','amalik','13:00:00','14:00:00','06-Feb-2022',NULL,'Pending',NULL),
('anasir','tkhurshid','13:00:00','14:00:00','06-Feb-2022',NULL,'Pending',NULL),
('aifzal','amalik','13:00:00','15:00:00','20-Jan-2022',NULL,'Accepted', NULL),	
('ajafri','amalik','13:00:00','14:00:00','05-Feb-2022',NULL,'Accepted',NULL),
('ajafri','tkhurshid','13:00:00','14:00:00','05-Feb-2022',NULL,'Accepted',NULL),
('ajafri','amalik','17:00:00','18:00:00','05-Feb-2022',NULL,'Rejected',NULL),
('ajafri','amalik','17:00:00','18:00:00','05-Jan-2023',NULL,'Rejected',5)

select w.Username,w.WorkExperience,w.WorkFirstName,w.WorkLastName, 
(select top 1 b.Review as review, c.UserName as CUserName from Booking b, Customer c where b.WUserName=w.Username and C.Username=b.CUserName)
from  Worker w




-------------------PROCEDURE-------------------------
-----------------------------------------------------------------
CREATE PROCEDURE get_Cards_Highest_Expereince (@SId INT,@user varchar(20))
AS
BEGIN
     SELECT Worker.Username,( Worker.WorkFirstName +' '+ Worker.WorkLastName) as WorkerName, Worker.WorkPrice, Worker.WorkExperience,Worker.WorkCity,Worker.workDesc,
    (SELECT TOP 1 Review FROM Booking WHERE WUserName = Worker.Username ORDER BY Rating DESC) AS Review,
    (SELECT TOP 1CUserName FROM Booking WHERE WUserName = Worker.Username ORDER BY Rating DESC) AS Reviewer,
    (SELECT CONCAT(CustFirstName, ' ', CustLastName) FROM Customer WHERE Username = (SELECT TOP 1 CUserName FROM Booking WHERE WUserName = Worker.Username ORDER BY Rating DESC)) AS ReviewerName,
    (SELECT COUNT(*) FROM Booking WHERE WUserName = Worker.Username) AS Orders,
    AVG(Booking.Rating) as AverageRating
    FROM Worker
    LEFT JOIN Booking ON Worker.Username = Booking.WUserName
   WHERE SId = @SId  and Worker.WorkCity=(select Customer.CustCity from Customer where Customer.Username=@user)
    GROUP BY Worker.Username, Worker.WorkFirstName, Worker.WorkLastName,Worker.WorkPrice,Worker.WorkExperience,Worker.WorkCity,Worker.workDesc	
    ORDER BY Worker.WorkExperience DESC;
END;
GO
execute get_Cards_Highest_Expereince 1,'ajafri'

---------------------------------------------------------------------
CREATE PROCEDURE get_Cards_Lowest_Experience (@SId INT,@user varchar(20))
AS
BEGIN
     SELECT Worker.Username,( Worker.WorkFirstName +' '+ Worker.WorkLastName) as WorkerName, Worker.WorkPrice, Worker.WorkExperience,Worker.WorkCity,Worker.workDesc,
    (SELECT TOP 1 Review FROM Booking WHERE WUserName = Worker.Username ORDER BY Rating DESC) AS Review,
    (SELECT TOP 1CUserName FROM Booking WHERE WUserName = Worker.Username ORDER BY Rating DESC) AS Reviewer,
    (SELECT CONCAT(CustFirstName, ' ', CustLastName) FROM Customer WHERE Username = (SELECT TOP 1 CUserName FROM Booking WHERE WUserName = Worker.Username ORDER BY Rating DESC)) AS ReviewerName,
    (SELECT COUNT(*) FROM Booking WHERE WUserName = Worker.Username) AS Orders,
    AVG(Booking.Rating) as AverageRating
    FROM Worker
    LEFT JOIN Booking ON Worker.Username = Booking.WUserName
    WHERE SId = @SId  and Worker.WorkCity=(select Customer.CustCity from Customer where Customer.Username=@user)
   GROUP BY Worker.Username, Worker.WorkFirstName, Worker.WorkLastName,Worker.WorkPrice,Worker.WorkExperience,Worker.WorkCity,Worker.workDesc	
    ORDER BY Worker.WorkExperience ASC;
END;
GO
execute get_Cards_Lowest_Experience 1,'ajafri'

----------------------------------------------------------------------------------
CREATE PROCEDURE getCards(@SId INT,@user varchar(20))
AS
BEGIN
	SELECT Worker.Username,( Worker.WorkFirstName +' '+ Worker.WorkLastName) as WorkerName, Worker.WorkPrice, Worker.WorkExperience,Worker.WorkCity,Worker.workDesc,
    (SELECT TOP 1 Review FROM Booking WHERE WUserName = Worker.Username ORDER BY Rating DESC) AS Review,
    (SELECT TOP 1CUserName FROM Booking WHERE WUserName = Worker.Username ORDER BY Rating DESC) AS Reviewer,
    (SELECT CONCAT(CustFirstName, '  ', CustLastName) FROM Customer WHERE Username = (SELECT TOP 1 CUserName FROM Booking WHERE WUserName = Worker.Username ORDER BY Rating DESC)) AS ReviewerName,
    (SELECT COUNT(*) FROM Booking WHERE WUserName = Worker.Username) AS Orders,
    AVG(Booking.Rating) as AverageRating
    FROM Worker
    LEFT JOIN Booking ON Worker.Username = Booking.WUserName
    WHERE SId = @SId  and Worker.WorkCity=(select Customer.CustCity from Customer where Customer.Username=@user)
    GROUP BY Worker.Username, Worker.WorkFirstName, Worker.WorkLastName,Worker.WorkPrice,Worker.WorkExperience,Worker.WorkCity,Worker.workDesc	
END;
GO

execute getCards 1,'ajafri'
  ---------------BOOKING------------------
CREATE PROCEDURE insertInBooking (@Cusername varchar(20),@Wusername varchar(20),@startTime TIME,@noOfHours INT,@bookDate DATE)
AS
	DECLARE @endTime TIME
	SET @endTime=DATEADD(hh,@noOfHours,@startTime)
	insert into Booking values (@Cusername,@Wusername,@startTime,@endTime,@bookDate,NULL,'Pending',NULL)
GO

execute insertInBooking 'ajafri','amalik','15:00:00',2,'05-Jan-2023'

drop procedure insertInBooking


---------------------ORDER BY SQL---------------------------
CREATE PROCEDURE get_Cards_Highest_Orders(@SId INT,@user varchar(20))
AS
BEGIN
	SELECT Worker.Username,( Worker.WorkFirstName+' '+ Worker.WorkLastName) as WorkerName, Worker.WorkPrice,Worker.WorkExperience,Worker.WorkCity,Worker.workDesc,
    (SELECT TOP 1 Review FROM Booking WHERE WUserName = Worker.Username ORDER BY Rating DESC) AS Review,
    (SELECT TOP 1CUserName FROM Booking WHERE WUserName = Worker.Username ORDER BY Rating DESC) AS Reviewer,
    (SELECT CONCAT(CustFirstName, ' ', CustLastName) FROM Customer WHERE Username = (SELECT TOP 1 CUserName FROM Booking WHERE WUserName = Worker.Username ORDER BY Rating DESC)) AS ReviewerName,
    (SELECT COUNT(*) FROM Booking WHERE WUserName = Worker.Username) AS Orders,
    AVG(Booking.Rating) as AverageRating
    FROM Worker
    LEFT JOIN Booking ON Worker.Username = Booking.WUserName
    WHERE SId = @SId  and Worker.WorkCity=(select Customer.CustCity from Customer where Customer.Username=@user)
    GROUP BY Worker.Username, Worker.WorkFirstName, Worker.WorkLastName,Worker.WorkPrice,Worker.WorkExperience,Worker.WorkCity,Worker.workDesc
    ORDER BY Orders DESC;
END;
GO
execute get_Cards_Highest_Orders 1,'ajafri'
------------------------------------------------------------
CREATE PROCEDURE get_Cards_Lowest_Orders(@SId INT,@user varchar(20))
AS
BEGIN
	SELECT Worker.Username,( Worker.WorkFirstName+' '+ Worker.WorkLastName) as WorkerName, Worker.WorkPrice,Worker.WorkExperience,Worker.WorkCity,Worker.workDesc,
    (SELECT TOP 1 Review FROM Booking WHERE WUserName = Worker.Username ORDER BY Rating DESC) AS Review,
    (SELECT TOP 1CUserName FROM Booking WHERE WUserName = Worker.Username ORDER BY Rating DESC) AS Reviewer,
    (SELECT CONCAT(CustFirstName, ' ', CustLastName) FROM Customer WHERE Username = (SELECT TOP 1 CUserName FROM Booking WHERE WUserName = Worker.Username ORDER BY Rating DESC)) AS ReviewerName,
    (SELECT COUNT(*) FROM Booking WHERE WUserName = Worker.Username) AS Orders,
    AVG(Booking.Rating) as AverageRating
    FROM Worker
    LEFT JOIN Booking ON Worker.Username = Booking.WUserName
    WHERE SId = @SId  and Worker.WorkCity=(select Customer.CustCity from Customer where Customer.Username=@user)
    GROUP BY Worker.Username, Worker.WorkFirstName, Worker.WorkLastName,Worker.WorkPrice,Worker.WorkExperience,Worker.WorkCity,Worker.workDesc
    ORDER BY Orders ASC;
END;
GO
execute get_Cards_Lowest_Orders 1,'ajafri'
----------------------------------------------------------------

CREATE PROCEDURE get_Cards_Lowest_Price(@SId INT,@user varchar(20))
AS
BEGIN
	SELECT Worker.Username,( Worker.WorkFirstName+' '+ Worker.WorkLastName) as WorkerName, Worker.WorkPrice,Worker.WorkExperience,Worker.WorkCity,Worker.workDesc,
    (SELECT TOP 1 Review FROM Booking WHERE WUserName = Worker.Username ORDER BY Rating DESC) AS Review,
    (SELECT TOP 1CUserName FROM Booking WHERE WUserName = Worker.Username ORDER BY Rating DESC) AS Reviewer,
    (SELECT CONCAT(CustFirstName, ' ', CustLastName) FROM Customer WHERE Username = (SELECT TOP 1 CUserName FROM Booking WHERE WUserName = Worker.Username ORDER BY Rating DESC)) AS ReviewerName,
    (SELECT COUNT(*) FROM Booking WHERE WUserName = Worker.Username) AS Orders,
    AVG(Booking.Rating) as AverageRating
    FROM Worker
    LEFT JOIN Booking ON Worker.Username = Booking.WUserName
    WHERE SId = @SId  and Worker.WorkCity=(select Customer.CustCity from Customer where Customer.Username=@user)
    GROUP BY Worker.Username, Worker.WorkFirstName, Worker.WorkLastName,Worker.WorkPrice,Worker.WorkExperience,Worker.WorkCity,Worker.workDesc	
    ORDER BY Worker.WorkPrice ASC;
END;
GO
execute get_Cards_Lowest_Price 1,'ajafri'

---------------------------------------------------------------
CREATE PROCEDURE get_Cards_Highest_Price(@SId INT,@user varchar(20))
AS
BEGIN
	 SELECT Worker.Username,( Worker.WorkFirstName+' '+ Worker.WorkLastName) as WorkerName, Worker.WorkPrice,Worker.WorkExperience,Worker.WorkCity,Worker.workDesc,
    (SELECT TOP 1 Review FROM Booking WHERE WUserName = Worker.Username ORDER BY Rating DESC) AS Review,
    (SELECT TOP 1CUserName FROM Booking WHERE WUserName = Worker.Username ORDER BY Rating DESC) AS Reviewer,
    (SELECT CONCAT(CustFirstName, ' ', CustLastName) FROM Customer WHERE Username = (SELECT TOP 1 CUserName FROM Booking WHERE WUserName = Worker.Username ORDER BY Rating DESC)) AS ReviewerName,
    (SELECT COUNT(*) FROM Booking WHERE WUserName = Worker.Username) AS Orders,
    AVG(Booking.Rating) as AverageRating
    FROM Worker
    LEFT JOIN Booking ON Worker.Username = Booking.WUserName
    WHERE SId = @SId  and Worker.WorkCity=(select Customer.CustCity from Customer where Customer.Username=@user)
    GROUP BY Worker.Username, Worker.WorkFirstName, Worker.WorkLastName,Worker.WorkPrice,Worker.WorkExperience,Worker.WorkCity,Worker.workDesc
    ORDER BY Worker.WorkPrice DESC;
END;
GO
execute get_Cards_Highest_Price 1,'ajafri'
-----------------------------------------------------------------
CREATE PROCEDURE get_Cards_Highest_Rating (@SId INT,@user varchar(20))
AS
BEGIN
     SELECT Worker.Username,( Worker.WorkFirstName+' '+ Worker.WorkLastName) as WorkerName, Worker.WorkPrice,Worker.WorkExperience,Worker.WorkCity,Worker.workDesc,
    (SELECT TOP 1 Review FROM Booking WHERE WUserName = Worker.Username ORDER BY Rating DESC) AS Review,
    (SELECT TOP 1CUserName FROM Booking WHERE WUserName = Worker.Username ORDER BY Rating DESC) AS Reviewer,
    (SELECT CONCAT(CustFirstName, ' ', CustLastName) FROM Customer WHERE Username = (SELECT TOP 1 CUserName FROM Booking WHERE WUserName = Worker.Username ORDER BY Rating DESC)) AS ReviewerName,
    (SELECT COUNT(*) FROM Booking WHERE WUserName = Worker.Username) AS Orders,
    AVG(Booking.Rating) as AverageRating
    FROM Worker
    LEFT JOIN Booking ON Worker.Username = Booking.WUserName
   WHERE SId = @SId  and Worker.WorkCity=(select Customer.CustCity from Customer where Customer.Username=@user)
    GROUP BY Worker.Username, Worker.WorkFirstName, Worker.WorkLastName,Worker.WorkPrice,Worker.WorkExperience,Worker.WorkCity,Worker.workDesc
    ORDER BY AverageRating DESC;
END;
GO

execute get_Cards_Highest_Rating 1,'ajafri'

---------------------------------------------------------------------
CREATE PROCEDURE get_Cards_Lowest_Rating (@SId INT,@user varchar(20))
AS
BEGIN
     SELECT Worker.Username,( Worker.WorkFirstName+' '+ Worker.WorkLastName) as WorkerName, Worker.WorkPrice,Worker.WorkExperience,Worker.WorkCity,Worker.workDesc,
    (SELECT TOP 1 Review FROM Booking WHERE WUserName = Worker.Username ORDER BY Rating DESC) AS Review,
    (SELECT TOP 1CUserName FROM Booking WHERE WUserName = Worker.Username ORDER BY Rating DESC) AS Reviewer,
    (SELECT CONCAT(CustFirstName, ' ', CustLastName) FROM Customer WHERE Username = (SELECT TOP 1 CUserName FROM Booking WHERE WUserName = Worker.Username ORDER BY Rating DESC)) AS ReviewerName,
    (SELECT COUNT(*) FROM Booking WHERE WUserName = Worker.Username) AS Orders,
    AVG(Booking.Rating) as AverageRating
    FROM Worker
    LEFT JOIN Booking ON Worker.Username = Booking.WUserName
   WHERE SId = @SId  and Worker.WorkCity=(select Customer.CustCity from Customer where Customer.Username=@user)
    GROUP BY Worker.Username, Worker.WorkFirstName, Worker.WorkLastName,Worker.WorkPrice,Worker.WorkExperience,Worker.WorkCity,Worker.workDesc
    ORDER BY AverageRating ASC;
END;
GO
execute get_Cards_Lowest_Rating 1,'ajafri'





execute get_Cards_Lowest_Experience 1

CREATE TRIGGER checkCustomer 
ON Customer
INSTEAD OF INSERT
AS
	DECLARE @Username varchar(20)
	DECLARE @FirstName varchar(15)
	DECLARE @Lastname varchar(15)
	DECLARE @Phone varchar(15)
	DECLARE @Email varchar(20)
	DECLARE @CNIC varchar(20)
	DECLARE @DOB date
	DECLARE @Age INT
	DECLARE @Gender char(1)
	DECLARE @HNo varchar(10)
	DECLARE @Street varchar(30)
	DECLARE @City varchar(20)
	DECLARE @Password varchar(16)
	SET @FirstName=(SELECT CustFirstName From inserted)
	SET @LastName=(SELECT CustLastName From inserted)
	SET @Gender=(SELECT CustGender From inserted)
	SET @HNo=(SELECT CustHNo From inserted)
	SET @Street=(SELECT CustStreet From inserted)
	SET @City=(SELECT CustCity From inserted)
	SET @DOB=(SELECT CustDOB From inserted)
	SET @Password=(SELECT Password From inserted)
	SET @Username=(SELECT Username From inserted)
	SET @Phone=(SELECT CustPhoneNo From inserted)
	SET @Email=(SELECT Email From inserted)
	SET @CNIC=(SELECT CNIC From inserted)
	if(MONTH(GETDATE()) > MONTH(@DOB) OR MONTH(GETDATE()) = MONTH(@DOB) AND DAY(GETDATE()) >= DAY(@DOB))
	BEGIN 
		SELECT @Age=DATEDIFF(year, @DOB, GETDATE())
	END
	else
	BEGIN 
		SELECT @Age=DATEDIFF(year, @DOB, GETDATE()) - 1 
	END
	if exists(Select Username  --Condition for unique Username
			  from Customer 
			  where Username=(Select Username from inserted))
	BEGIN
		Select 'username' as status
	END
	else if(@Age<18) --Condition for Age > 18
	BEGIN
		Select 'age' as status
	END
	else if exists(Select CustPhoneNo   --Condition for unique Phone
			  from Customer 
			  where CustPhoneNo=(Select CustPhoneNo from inserted))
	BEGIN
		Select 'phone' as status
	END
	else if exists(Select Email   --Condition for unique Email
			  from Customer 
			  where Email=(Select Email from inserted))
	BEGIN
		Select 'email' as status
	END
	else if exists(Select CNIC   --Condition for unique CNIC
			  from Customer 
			  where CNIC=(Select CNIC from inserted))
	BEGIN
		Select 'cnic' as status
	END
	else
	BEGIN
	insert into Customer values (@Username,@FirstName,@Lastname,@DOB,@Gender,@Phone,@HNo,@Street,@City,@Password,@Email,@CNIC)
	select 'success' as status
	END

GO

CREATE TRIGGER checkWorker 
ON Worker
INSTEAD OF INSERT
AS
	DECLARE @Username varchar(20)
	DECLARE @FirstName varchar(15)
	DECLARE @Lastname varchar(15)
	DECLARE @Phone varchar(15)
	DECLARE @Email varchar(20)
	DECLARE @CNIC varchar(20)
	DECLARE @DOB date
	DECLARE @Age INT
	DECLARE @Gender char(1)
	DECLARE @HNo varchar(10)
	DECLARE @Street varchar(30)
	DECLARE @City varchar(20)
	DECLARE @Password varchar(16)
	DECLARE @Experience INT
	DECLARE @Price INT
	DECLARE @Sid INT
	DECLARE @Desc varchar(300)
	SET @FirstName=(SELECT WorkFirstName From inserted)
	SET @LastName=(SELECT WorkLastName From inserted)
	SET @Gender=(SELECT WorkGender From inserted)
	SET @HNo=(SELECT WorkHNo From inserted)
	SET @Street=(SELECT WorkStreet From inserted)
	SET @City=(SELECT WorkCity From inserted)
	SET @DOB=(SELECT WorkDOB From inserted)
	SET @Password=(SELECT Password From inserted)
	SET @Username=(SELECT Username From inserted)
	SET @Phone=(SELECT WorkPhoneNo From inserted)
	SET @Email=(SELECT Email From inserted)
	SET @CNIC=(SELECT CNIC From inserted)
	SET @Experience=(SELECT WorkExperience From inserted)
	SET @Price=(SELECT WorkPrice From inserted)
	SET @Desc=(SELECT workDesc From inserted)
	SET @Sid=(SELECT SId From inserted)

	if(MONTH(GETDATE()) > MONTH(@DOB) OR MONTH(GETDATE()) = MONTH(@DOB) AND DAY(GETDATE()) >= DAY(@DOB))
	BEGIN 
		SELECT @Age=DATEDIFF(year, @DOB, GETDATE())
	END
	else
	BEGIN 
		SELECT @Age=DATEDIFF(year, @DOB, GETDATE()) - 1 
	END
	if exists(Select Username  --Condition for unique Username
			  from Worker 
			  where Username=(Select Username from inserted))
	BEGIN
		Select 'username' as status
	END
	else if(@Age<18) --Condition for Age > 18
	BEGIN
		Select 'age' as status
	END
	else if(@Price>4 AND @Price<26) --Condition for Worker Price per hour
	BEGIN
		Select 'price' as status
	END
	else if exists(Select WorkPhoneNo   --Condition for unique Phone
			  from Worker 
			  where WorkPhoneNo=(Select WorkPhoneNo from inserted))
	BEGIN
		Select 'phone' as status
	END
	else if exists(Select Email   --Condition for unique Email
			  from Worker 
			  where Email=(Select Email from inserted))
	BEGIN
		Select 'email' as status
	END
	else if exists(Select CNIC   --Condition for unique CNIC
			  from Worker 
			  where CNIC=(Select CNIC from inserted))
	BEGIN
		Select 'cnic' as status
	END
	else
	BEGIN
	insert into Worker values (@Username,@FirstName,@Lastname,@DOB,@Gender,@Phone,@HNo,@Street,@City,@Experience,@Price,@Desc,@Password,@Email,@Sid,@CNIC)
	select 'success' as status
	END

GO

Select *
From Service

Select *
From Customer

Select *
From Worker where SId=3

Select *
From Booking

/* Drop table Booking
Drop table Worker
Drop table Customer
Drop table Service
*/


drop procedure get_Cards_Highest_Expereince
 drop procedure get_Cards_Lowest_Experience
drop procedure getCards
--drop procedure insertInBooking
drop procedure get_Cards_Highest_Orders
--drop procedure get_Cards_Highest_Orders
drop procedure get_Cards_Lowest_Orders
drop procedure get_Cards_Lowest_Price
drop procedure get_Cards_Highest_Price
drop procedure get_Cards_Highest_Rating
drop procedure get_Cards_Lowest_Rating
