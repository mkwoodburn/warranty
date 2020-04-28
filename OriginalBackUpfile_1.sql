create table brand (
	brand_ID serial Primary KEY,
	brandName varchar(255),
	daysTofileClaim int,
	daysToFileAppeal int);
	
CREATE TABLE status (
	status_id serial Primary Key,
	statusName VARCHAR (255) NOT NULL,
	statusDescription VARCHAR (255));
	
 CREATE TABLE segment (
 	segment_id serial Primary KEY,
 	segment SMALLINT NOT NULL);	
	
CREATE TABLE claim_Segment (
	claimSegment_ID serial Primary KEY,
	description TEXT,
	claim_id integer REFERENCES claim,
	segment_id integer REFERENCES segment);	
	
CREATE TABLE part (
	part_id serial Primary KEY,
	partSerialNumber VARCHAR(255),
	partDescription VARCHAR(255));
	
CREATE TABLE labor (
	labor_id serial Primary KEY,
	techNumber VARCHAR(255));

CREATE TABLE claim (
 	CLAIM_ID serial Primary KEY,
 	claimNumber VARCHAR (255) NOT NULL,
 	serialNumber VARCHAR (255) NOT NULL,
 	WorkOrderHourMeter DECIMAL(8,2) NOT NULL,
 	dateOpened DATE NOT NULL,
 	WIPStartDate DATE NOT NULL,
 	WIPLastPunchDate DATE NOT NULL,
	totalWorkOrderAmount MONEY, 
	brand_ID integer REFERENCES brand NOT NULL, 
	status_id integer REFERENCES status);
	
CREATE TABLE claimsegment_labor_part (
	claimsegmentlaborpart_id serial Primary KEY,
	partCost Money,
	partQuanity int,
	laborHours int,
	part_id integer REFERENCES part,
	labor_id integer REFERENCES labor,
	claimsegment_id integer REFERENCES claim_Segment);

insert into brand (brandName, daysToFileClaim, daysToFileAppeal)
	values
	('CNH', 30, 45),
	('Hyundai', 30, 15);	
	
insert into status (statusName, statusDescription)
values
	('untouched', 'This is a brand new claim that has not been touched'),
	('Draft - No SRT', 'Claim is in draft but the SRTs need to be added'),
	('Pending Dealer Response', 'Sent question to the dealer waiting for the response.');

INSERT INTO segment (segment)
VALUES
 	(1),
 	(2),
 	(3),
 	(4),
 	(5);
	
INSERT INTO part (partSerialNumber, partDescription)
VALUES 
	('47778097', 'JOYSTICK'),
	('81865209', 'SCREW'),
	('378884A2','STRAP');
	
INSERT INTO labor (techNumber)
VALUES
	(2996);

INSERT INTO claim (claimNumber, serialNumber, WorkOrderHourMeter, dateOpened, WIPStartDate, WIPLastPunchDate, totalWorkOrderAmount, brand_ID, status_id)
VALUES 
 	('FC02861', 'NKM474589', 7.3, '03/02/2020', '03/02/2020', '03/11/2020', 1451.25,1, 1),
 	('FC02883', 'NHM439420', 708, '03/16/2020', '04/16/2020', '04/21/2020', 506.25,1, 1),
 	('FC02901', 'NJM449454', 280.5, '04/17/2020', '04/17/2020', '04/21/2020', 1121.72,1, 3),
 	('WA07811', 'NHM439916', 976, '03/27/2020', '03/27/2020', '04/16/2020', 1356.75,1, 2);

INSERT INTO claim_Segment (claim_id, segment_id, description)
VALUES
	(2, 1, 'Test description # 1');	
	
INSERT INTO claimsegment_labor_part (partCost, partQuanity, laborHours, part_id, labor_id, claimsegment_id)
VALUES
	(495.88, 1, 0, 1, 1, 1),
	(495.88, 1, 0, 1, 1, 1),
	(495.88, 1, 0, 1, 1, 1),
	(0, 0, 1.74, 1, 1, 1);

	
SELECT 
	c.claimnumber, 
	c.serialnumber,
	c.dateopened,
	c.wipstartdate,
	c.wiplastpunchdate,
	c.totalWorkOrderAmount,
	b.brandName,
	b.daysTofileClaim
FROM claim c
INNER JOIN brand b on c.brand_ID = b.brand_ID

select
	c.claimNumber,
	c.serialNumber,
	c.totalWorkOrderAmount,
	now() :: date - c.wiplastpunchdate :: date as date_diff,
	b.brandName
from claim c 
inner join brand b on c.brand_id = b.brand_id