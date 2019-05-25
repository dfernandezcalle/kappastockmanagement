SET 'auto.offset.reset'='earliest';

CREATE TABLE LOCATIONS_TABLE (STOREID INT, GPSLOCATION VARCHAR, STORENAME VARCHAR) WITH (KEY='STOREID', KAFKA_TOPIC = 'LOCATIONS', VALUE_FORMAT = 'JSON');
 
CREATE STREAM STOCK_SRC (id BIGINT, storeId INT, sku BIGINT, rfidLocationId INT, quantity INT) WITH (KAFKA_TOPIC='STOCK', VALUE_FORMAT='JSON');
 
CREATE STREAM STOCK_ENRICH AS SELECT s.id, s.storeId AS storeId, s.sku, s.rfidLocationId, s.quantity, l.gpsLocation, l.storeName FROM STOCK_SRC s LEFT JOIN LOCATIONS_TABLE l ON s.storeId=l.STOREID;