CREATE TABLE claim (
 	CLAIM_ID serial Primary KEY,
 	claimNumber VARCHAR (255) NOT NULL,
 	serialNumber VARCHAR (255) NOT NULL,
 	WorkOrderHourMeter DECIMAL(8,2) NOT NULL,
 	dateOpened DATE NOT NULL,
 	WIPStartDate DATE NOT NULL,
 	WIPLastPunchDate DATE NOT NULL
 );

INSERT INTO claim (claimNumber, serialNumber, WorkOrderHourMeter, dateOpened, WIPStartDate, WIPLastPunchDate)
VALUES 
 	('FC02861', 'NKM474589', 7.3, '03/02/2020', '03/02/2020', '03/11/2020'),
 	('FC02883', 'NHM439420', 708, '03/16/2020', '04/16/2020', '04/21/2020'),
 	('FC02901', 'NJM449454', 280.5, '04/17/2020', '04/17/2020', '04/21/2020'),
 	('WA07811', 'NHM439916', 976, '03/27/2020', '03/27/2020', '04/16/2020');

 CREATE TABLE segment (
 	SEGMENT_ID serial Primary KEY,
 	segment SMALLINT NOT NULL
 	);

INSERT INTO segment (segment)
 VALUES
 	(1),
 	(2),
 	(3),
 	(4),
 	(5);

CREATE TABLE claim_Segment (
	claimSegment_ID serial Primary KEY,
	description TEXT,
	claim_id integer REFERENCES claim,
	segment_id integer REFERENCES segment
	);	
	
	
INSERT INTO claim_Segment (claim_id, segment_id, description)
VALUES
	(2, 1, 'Test description # 1');	
	
create table brand (
	brand_ID serial Primary KEY,
	brandName varchar(255),
	daysTofileClaim int,
	daysToFileAppeal int);
	
insert into brand (brandName, daysToFileClaim, daysToFileAppeal)
	values
	('CNH', 30, 45),
	('Hyundai', 30, 15);