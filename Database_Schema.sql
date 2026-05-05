-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: gdb0041
-- ------------------------------------------------------
-- Server version	9.6.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '49aa23c8-19f8-11f1-9f2e-009337db2f8a:1-1143';

--
-- Table structure for table `dim_customer`
--

DROP TABLE IF EXISTS `dim_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_customer` (
  `customer_code` int unsigned NOT NULL,
  `customer` varchar(150) NOT NULL,
  `platform` varchar(45) NOT NULL,
  `channel` varchar(45) NOT NULL,
  `market` varchar(45) DEFAULT NULL,
  `sub_zone` varchar(45) DEFAULT NULL,
  `region` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`customer_code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dim_date`
--

DROP TABLE IF EXISTS `dim_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_date` (
  `calender_date` date NOT NULL,
  `fiscal_year` year GENERATED ALWAYS AS (year((`calender_date` + interval 4 month))) VIRTUAL,
  PRIMARY KEY (`calender_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dim_product`
--

DROP TABLE IF EXISTS `dim_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_product` (
  `product_code` varchar(45) NOT NULL,
  `division` varchar(45) NOT NULL,
  `segment` varchar(45) NOT NULL,
  `category` varchar(45) NOT NULL,
  `product` varchar(200) NOT NULL,
  `variant` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`product_code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fact_forecast_monthly`
--

DROP TABLE IF EXISTS `fact_forecast_monthly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fact_forecast_monthly` (
  `date` date NOT NULL,
  `fiscal_year` year DEFAULT NULL,
  `product_code` varchar(45) NOT NULL,
  `customer_code` int NOT NULL,
  `forecast_quantity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fact_freight_cost`
--

DROP TABLE IF EXISTS `fact_freight_cost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fact_freight_cost` (
  `market` varchar(45) NOT NULL,
  `fiscal_year` year NOT NULL,
  `freight_pct` decimal(5,4) unsigned NOT NULL,
  `other_cost_pct` decimal(5,4) unsigned NOT NULL,
  PRIMARY KEY (`market`,`fiscal_year`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fact_gross_price`
--

DROP TABLE IF EXISTS `fact_gross_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fact_gross_price` (
  `product_code` varchar(45) NOT NULL,
  `fiscal_year` year NOT NULL,
  `gross_price` decimal(15,4) unsigned NOT NULL,
  PRIMARY KEY (`product_code`,`fiscal_year`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fact_manufacturing_cost`
--

DROP TABLE IF EXISTS `fact_manufacturing_cost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fact_manufacturing_cost` (
  `product_code` varchar(45) NOT NULL,
  `cost_year` year NOT NULL,
  `manufacturing_cost` decimal(15,4) unsigned NOT NULL,
  PRIMARY KEY (`product_code`,`cost_year`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fact_post_invoice_deductions`
--

DROP TABLE IF EXISTS `fact_post_invoice_deductions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fact_post_invoice_deductions` (
  `customer_code` int unsigned NOT NULL,
  `product_code` varchar(45) NOT NULL,
  `date` date NOT NULL,
  `discounts_pct` decimal(5,4) NOT NULL,
  `other_deductions_pct` decimal(5,4) NOT NULL,
  PRIMARY KEY (`customer_code`,`product_code`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fact_pre_invoice_deductions`
--

DROP TABLE IF EXISTS `fact_pre_invoice_deductions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fact_pre_invoice_deductions` (
  `customer_code` int unsigned NOT NULL,
  `fiscal_year` year NOT NULL,
  `pre_invoice_discount_pct` decimal(5,4) NOT NULL,
  PRIMARY KEY (`customer_code`,`fiscal_year`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fact_sales_monthly`
--

DROP TABLE IF EXISTS `fact_sales_monthly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fact_sales_monthly` (
  `date` date NOT NULL,
  `fiscal_year` year GENERATED ALWAYS AS (year((`date` + interval 4 month))) VIRTUAL,
  `product_code` varchar(45) NOT NULL,
  `customer_code` int unsigned NOT NULL,
  `sold_quantity` int unsigned NOT NULL,
  PRIMARY KEY (`date`,`product_code`,`customer_code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `net_sales`
--

DROP TABLE IF EXISTS `net_sales`;
/*!50001 DROP VIEW IF EXISTS `net_sales`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `net_sales` AS SELECT 
 1 AS `date`,
 1 AS `fiscal_year`,
 1 AS `customer_code`,
 1 AS `market`,
 1 AS `product_code`,
 1 AS `product`,
 1 AS `variant`,
 1 AS `sold_quantity`,
 1 AS `gross_price_total`,
 1 AS `pre_invoice_discount_pct`,
 1 AS `net_invoice_sale`,
 1 AS `post_invoice_discount_pct`,
 1 AS `net_sales`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `sales_postinv_discount`
--

DROP TABLE IF EXISTS `sales_postinv_discount`;
/*!50001 DROP VIEW IF EXISTS `sales_postinv_discount`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `sales_postinv_discount` AS SELECT 
 1 AS `date`,
 1 AS `fiscal_year`,
 1 AS `customer_code`,
 1 AS `market`,
 1 AS `product_code`,
 1 AS `product`,
 1 AS `variant`,
 1 AS `sold_quantity`,
 1 AS `gross_price_total`,
 1 AS `pre_invoice_discount_pct`,
 1 AS `net_invoice_sale`,
 1 AS `post_invoice_discount_pct`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `sales_preinv_discount`
--

DROP TABLE IF EXISTS `sales_preinv_discount`;
/*!50001 DROP VIEW IF EXISTS `sales_preinv_discount`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `sales_preinv_discount` AS SELECT 
 1 AS `date`,
 1 AS `fiscal_year`,
 1 AS `customer_code`,
 1 AS `market`,
 1 AS `product_code`,
 1 AS `product`,
 1 AS `variant`,
 1 AS `sold_quantity`,
 1 AS `gross_price`,
 1 AS `gross_price_total`,
 1 AS `pre_invoice_discount_pct`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'gdb0041'
--

--
-- Dumping routines for database 'gdb0041'
--
/*!50003 DROP FUNCTION IF EXISTS `get_fiscal_quarters` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_fiscal_quarters`(calender_date date) RETURNS char(2) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
declare m tinyint;
declare qtr char(2);

set m=month(calender_date);
case

when m in (9,10,11) then 
set qtr="Q1";
when m in (12,1,2) then 
set qtr="Q2";
when m in (3,4,5) then 
set qtr="Q3";
else 
set qtr="Q4";
END CASE ;
RETURN qtr;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_fiscal_year` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_fiscal_year`( 
calender_date DATE) RETURNS int
    DETERMINISTIC
BEGIN
declare fiscal_year INT;

SET fiscal_year=year(date_add(calender_date,interval 4 month));
return fiscal_year;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_market_badge` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_market_badge`(
in in_market varchar(45),
in in_fiscal_year year,
out out_badge varchar(45)
)
BEGIN
declare qty int default 0;
if in_market="" then 
set in_market="india";
end if;
select
sum(sold_quantity) into qty
from fact_sales_monthly s 
join dim_customer c 
on s.customer_code=c.customer_code
where get_fiscal_year(s.date)=  in_fiscal_year and market=in_market 
group by c.market;

# determine 
if qty>500000 then 
set out_badge ="Gold";
else
set out_badge="Silver";
end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_monthly_gross_sales_for_customer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_monthly_gross_sales_for_customer`(
in_customer_codes text )
BEGIN
select s.date,sum(g.gross_price*s.sold_quantity)as gross_price_total
from fact_sales_monthly s 
join fact_gross_price g 
on 
g.product_code=s.product_code and g.fiscal_year=get_fiscal_year(s.date)
where find_in_set(s.customer_code,in_customer_code)>0
group by s.date;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_top_n_customer_by_net_sales` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_top_n_customer_by_net_sales`( in_fiscal_year year,in_market varchar(45),in_top_n int
)
BEGIN
SELECT customer,round(sum(net_sales)/1000000,2)as net_sales_mln FROM 
gdb0041.net_sales ns
join dim_customer dc
on ns.customer_code=dc.customer_code
where fiscal_year=in_fiscal_year and ns.market=in_market
group by customer
order by net_sales_mln desc 
limit in_top_n;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_top_n_market_by_net_sales` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_top_n_market_by_net_sales`(
in_fiscal_year year,in_top_n int
)
BEGIN
SELECT market,round(sum(net_sales)/1000000,2)as net_sales_mln FROM 
gdb0041.net_sales
where fiscal_year=in_fiscal_year
group by market
order by net_sales_mln desc 
limit in_top_n;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_top_n_products_per_division_by_sold` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_top_n_products_per_division_by_sold`(
in_fiscal_year year ,in_top_n int
)
BEGIN

with cte1  as (select p.division,
p.product,sum(sold_quantity)as total_qty
from fact_sales_monthly s 
join dim_product p 
on p.product_code=s.product_code
where fiscal_year=in_fiscal_year
group by p.product,p.division),
cte2 as (select *,dense_rank() over(partition by division order by total_qty desc) as drnk from cte1)
select *from cte2 where drnk<=in_top_n;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_top_n_product_by_netsales` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_top_n_product_by_netsales`(
in_fiscal_year year,in_top_n int)
BEGIN
SELECT  product,round(sum(net_sales)/1000000,2)as net_sale_mln FROM gdb0041.net_sales
where fiscal_year=in_fiscal_year
group by product 
limit in_top_n ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `net_sales`
--

/*!50001 DROP VIEW IF EXISTS `net_sales`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `net_sales` AS select `sales_postinv_discount`.`date` AS `date`,`sales_postinv_discount`.`fiscal_year` AS `fiscal_year`,`sales_postinv_discount`.`customer_code` AS `customer_code`,`sales_postinv_discount`.`market` AS `market`,`sales_postinv_discount`.`product_code` AS `product_code`,`sales_postinv_discount`.`product` AS `product`,`sales_postinv_discount`.`variant` AS `variant`,`sales_postinv_discount`.`sold_quantity` AS `sold_quantity`,`sales_postinv_discount`.`gross_price_total` AS `gross_price_total`,`sales_postinv_discount`.`pre_invoice_discount_pct` AS `pre_invoice_discount_pct`,`sales_postinv_discount`.`net_invoice_sale` AS `net_invoice_sale`,`sales_postinv_discount`.`post_invoice_discount_pct` AS `post_invoice_discount_pct`,((1 - `sales_postinv_discount`.`post_invoice_discount_pct`) * `sales_postinv_discount`.`net_invoice_sale`) AS `net_sales` from `sales_postinv_discount` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `sales_postinv_discount`
--

/*!50001 DROP VIEW IF EXISTS `sales_postinv_discount`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `sales_postinv_discount` AS select `s`.`date` AS `date`,`s`.`fiscal_year` AS `fiscal_year`,`s`.`customer_code` AS `customer_code`,`s`.`market` AS `market`,`s`.`product_code` AS `product_code`,`s`.`product` AS `product`,`s`.`variant` AS `variant`,`s`.`sold_quantity` AS `sold_quantity`,`s`.`gross_price_total` AS `gross_price_total`,`s`.`pre_invoice_discount_pct` AS `pre_invoice_discount_pct`,(`s`.`gross_price_total` - (`s`.`gross_price_total` * `s`.`pre_invoice_discount_pct`)) AS `net_invoice_sale`,(`po`.`discounts_pct` + `po`.`other_deductions_pct`) AS `post_invoice_discount_pct` from (`sales_preinv_discount` `s` join `fact_post_invoice_deductions` `po` on(((`s`.`date` = `po`.`date`) and (`s`.`product_code` = `po`.`product_code`) and (`s`.`customer_code` = `po`.`customer_code`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `sales_preinv_discount`
--

/*!50001 DROP VIEW IF EXISTS `sales_preinv_discount`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `sales_preinv_discount` AS select `s`.`date` AS `date`,`s`.`fiscal_year` AS `fiscal_year`,`s`.`customer_code` AS `customer_code`,`c`.`market` AS `market`,`s`.`product_code` AS `product_code`,`p`.`product` AS `product`,`p`.`variant` AS `variant`,`s`.`sold_quantity` AS `sold_quantity`,`g`.`gross_price` AS `gross_price`,round((`g`.`gross_price` * `s`.`sold_quantity`),2) AS `gross_price_total`,`pre`.`pre_invoice_discount_pct` AS `pre_invoice_discount_pct` from ((((`fact_sales_monthly` `s` join `dim_customer` `c` on((`s`.`customer_code` = `c`.`customer_code`))) join `dim_product` `p` on((`p`.`product_code` = `s`.`product_code`))) join `fact_gross_price` `g` on(((`g`.`product_code` = `s`.`product_code`) and (`g`.`fiscal_year` = `s`.`fiscal_year`)))) join `fact_pre_invoice_deductions` `pre` on(((`pre`.`customer_code` = `s`.`customer_code`) and (`pre`.`fiscal_year` = `s`.`fiscal_year`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-05 19:37:06
