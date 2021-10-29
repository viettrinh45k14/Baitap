Create database HOUSEDB
Use HOUSEDB
Select * from HOUSES
--Q1 Down price to 20%
Update HOUSES
Set Price= Price*0.9
where ((HouseType ='A' and BedRoom ='3')or (HouseType ='B' and BedRoom ='1')or (HouseType ='B' and BedRoom ='3')or 
	(HouseType ='C' and BedRoom ='2'))
-- Q2
Update HOUSES
set HouseType=
	Case 
		When HouseID='A201' or HouseID='A202' or HouseID='A203' then 'A'
		When HouseID='B301' or HouseID='B302' then 'B'
		Else 'C'
	end
--Q3
Update HOUSES
set Price=
	Case 
		When HouseType='A' then 300
		When HouseType='B' then 250
		When HouseType='C' then 250
		Else 180
	end
--Q4 
update HOUSES
set BedRoom='2'
where HouseID='A203'
-- Q5
Select * from CONTRACTS
update CONTRACTS
set Duration=iif(DATEDIFF(month,StartDate, EndDate)=0,1,
DATEDIFF(month,StartDate, EndDate))
Select DATEDIFF(month, '2018-10-01', '2019-10-01') 
--Q6
update CONTRACTS
set ContractValue=Duration*Price
from CONTRACTS inner join HOUSES on 
CONTRACTS.HouseID = HOUSES.HouseID
--Q7
update CONTRACTS
set PrePaid= ContractValue*iif(Duration>9,0.5,
iif(Duration>6,0.7,1))
--Q8
update CONTRACTS
set OutstandingAmount= ContractValue- PrePaid+ 0.1*ContractValue