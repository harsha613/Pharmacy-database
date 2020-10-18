CREATE TABLE Customer( 
        customer_id CHAR(5) NOT NULL PRIMARY KEY,
        first_name VARCHAR(15) NOT NULL,
        middle_name VARCHAR(15),
        last_name VARCHAR(15),
        email VARCHAR(25),
	city VARCHAR(15),
	street VARCHAR(15),
	building VARCHAR(15));

CREATE TABLE Doctor( 
        medical_license_number CHAR(5) NOT NULL PRIMARY KEY,
        first_name VARCHAR(15) NOT NULL,
        middle_name VARCHAR(15),
        last_name VARCHAR(15),
        speciality VARCHAR(15),
        phone_number BIGINT(10) NOT NULL);

CREATE TABLE Drug_Supplier( 
        supplier_id CHAR(5) NOT NULL PRIMARY KEY,
        supplier_name VARCHAR(15) NOT NULL,
        city VARCHAR(15),
	street VARCHAR(15),
	zip BIGINT(6),
        phone_number BIGINT(10) NOT NULL);

CREATE TABLE Drug( 
        drug_name VARCHAR(30) NOT NULL,
        supplier_id CHAR(5) NOT NULL,
	avail_quantity BIGINT NOT NULL,
        price BIGINT(10) NOT NULL,
	PRIMARY KEY(drug_name,supplier_id),
        FOREIGN KEY (supplier_id)
            REFERENCES Drug_Supplier (supplier_id) ON DELETE RESTRICT ON UPDATE CASCADE);

create table drug_detail(
		drug_name VARCHAR(30) NOT NULL primary key,
        contents VARCHAR(20),
        FOREIGN KEY (drug_name)
			REFERENCES Drug (drug_name) ON DELETE RESTRICT ON UPDATE CASCADE);
            
CREATE TABLE Zero( 
        Drug_Name VARCHAR(30) NOT NULL PRIMARY KEY,
        FOREIGN KEY (Drug_Name)
            REFERENCES Drug (Drug_Name));

CREATE TABLE `pharma`.`prescription` (
  `pno` INT NOT NULL,
  `customer_id` CHAR(5) NOT NULL,
  `medical_license_number` CHAR(5) NULL,
  PRIMARY KEY (`pno`, `customer_id`),
  INDEX `c_id_idx` (`customer_id` ASC) ,
  INDEX `m_no_idx` (`medical_license_number` ASC),
  CONSTRAINT `c_id`
    FOREIGN KEY (`customer_id`)
    REFERENCES `pharma`.`customer` (`customer_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `m_no`
    FOREIGN KEY (`medical_license_number`)
    REFERENCES `pharma`.`doctor` (`medical_license_number`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE);

CREATE TABLE `pharma`.`drug_list` (
  pno INT NOT NULL,
  drug_name VARCHAR(30) NOT NULL,
  dose INT NULL,
  PRIMARY KEY (pno,drug_name),
  INDEX `drug_name_idx` (`drug_name` ASC) ,
      FOREIGN KEY (`pno`)
    REFERENCES `pharma`.`prescription` (`pno`) ON DELETE RESTRICT ON UPDATE CASCADE,
      FOREIGN KEY (`drug_name`)
    REFERENCES `pharma`.`drug` (`drug_name`) ON DELETE RESTRICT ON UPDATE CASCADE);

CREATE TABLE Health_Insurance(
	insurance_number BIGINT NOT NULL PRIMARY KEY,
	amount INTEGER,
	company VARCHAR(15),
	customer_id CHAR(5) NOT NULL,
	FOREIGN KEY (customer_id)
            REFERENCES Customer (customer_id)ON DELETE RESTRICT ON UPDATE CASCADE);

DELIMITER $$
CREATE TRIGGER `zero` AFTER INSERT ON `drug` FOR EACH ROW BEGIN
if new.avail_quantity = 0 then
insert into zero values(new.drug_name);
end if;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `zero1` AFTER UPDATE ON `drug` FOR EACH ROW BEGIN
if new.avail_quantity = 0 then
insert into zero values(new.drug_name);
end if;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `nonzero` AFTER UPDATE ON `drug` FOR EACH ROW BEGIN
if new.avail_quantity > 0 and old.avail_quantity=0 then
delete from zero where Drug_Name=old.drug_name;
end if;
END$$
DELIMITER ;


INSERT INTO Customer Values('00001','sherman','k','maple','sher@gmail.com','california','2ndstreet','3rdbuiding');
INSERT INTO Customer Values('00002','volga','a','buckler','vvv@gmail.com','new jersy','johnson street','mape villa');
INSERT INTO Customer Values('00003','judy','h','william','jud54@gmail.com','mexico','main street','4th apartment');
INSERT INTO Customer Values('00004','jack','','christ','jack4@gmail.com','lasvegas','5th street','br mansion');
INSERT INTO Customer Values('00005','randy','s','oslo','rand23@gmail.com','las angeles','chinatown','sushi palace');

INSERT INTO Doctor Values('10001','sturgis','B','mafalo','ENT',9111111110);
INSERT INTO Doctor Values('10002','richard','E','finnagan','skin',9111111111);
INSERT INTO Doctor Values('10003','keng','P','wagon','heart',9111111112);

INSERT INTO Drug_Supplier Values('20001','hendrickson','london','main street',548621,2111111111);
INSERT INTO Drug_Supplier Values('20002','shawn','paris','valac street',500124,2111111112);
INSERT INTO Drug_Supplier Values('20003','peter','bern','6th street',554210,8111111113);

INSERT INTO Drug Values('luliz','20001',14,500);
INSERT INTO Drug Values('luliz','20002',12,500);
INSERT INTO Drug Values('dolokind','20001',13,40);
INSERT INTO Drug Values('dolokind','20002',20,38);
INSERT INTO Drug Values('meftholforte','20003',10,95);
INSERT INTO Drug Values('alercet cold','20002',0,15);
INSERT INTO Drug Values('solvin cold','20001',5,55);
INSERT INTO Drug Values('dolo 650','20003',8,17);
INSERT INTO Drug Values('ketozole','20001',7,36);
INSERT INTO Drug Values('citrozen','20002',10,24);
INSERT INTO Drug Values('dolovin+','20003',0,35);
INSERT INTO Drug Values('rantac','20001',0,15);
INSERT INTO Drug Values('rantac','20003',8,15);
INSERT INTO Drug Values('dsr','20002',22,15);

INSERT INTO drug_detail values('luliz','lulicanozole');
INSERT INTO drug_detail values('dolokind','paracetemol');
INSERT INTO drug_detail values('meftholforte','antibiotec');
INSERT INTO drug_detail values('alercet cold','antibiotec');
INSERT INTO drug_detail values('solvin cold','aceclofenac');
INSERT INTO drug_detail values('dolo 650','antibiotec');
INSERT INTO drug_detail values('ketozole','antibiotec');
INSERT INTO drug_detail values('citrozen','liv citrozen');
INSERT INTO drug_detail values('dolovin+','aceclofenac');
INSERT INTO drug_detail values('rantac','rabiprazole');
INSERT INTO drug_detail values('dsr','domperdine');

INSERT INTO PRESCRIPTION values(1,'00001','10001');
INSERT INTO PRESCRIPTION values(2,'00002','10002');
INSERT INTO PRESCRIPTION values(3,'00001','10003');
INSERT INTO PRESCRIPTION values(4,'00004','10002');
INSERT INTO PRESCRIPTION values(5,'00005','10001');
INSERT INTO PRESCRIPTION values(6,'00003','10003');
INSERT INTO PRESCRIPTION values(7,'00004','10001');

INSERT INTO drug_list values(1,'luliz',4);
INSERT INTO drug_list values(1,'solvin cold',2);
INSERT INTO drug_list values(1,'dsr',2);
INSERT INTO drug_list values(2,'dolokind',5);
INSERT INTO drug_list values(2,'citrozen',3);
INSERT INTO drug_list values(2,'rantac',1);
INSERT INTO drug_list values(3,'meftholforte',9);
INSERT INTO drug_list values(3,'ketozole',4);
INSERT INTO drug_list values(3,'dolovin+',2);
INSERT INTO drug_list values(4,'dolo 650',8);
INSERT INTO drug_list values(4,'alercet cold',10);
INSERT INTO drug_list values(4,'luliz',4);
INSERT INTO drug_list values(5,'dsr',5);
INSERT INTO drug_list values(5,'dolokind',7);
INSERT INTO drug_list values(5,'luliz',3);
INSERT INTO drug_list values(6,'citrozen',4);
INSERT INTO drug_list values(6,'dolo 650',7);
INSERT INTO drug_list values(6,'rantac',2);
INSERT INTO drug_list values(7,'dolokind',7);
INSERT INTO drug_list values(7,'ketozole',8);
INSERT INTO drug_list values(7,'dolovin+',2);

INSERT INTO Health_Insurance values(12001,1000000,'pragathi','00001');
INSERT INTO Health_Insurance values(12002,800000,'rictall','00003');
INSERT INTO Health_Insurance values(12003,1300000,'carefree','00004');
