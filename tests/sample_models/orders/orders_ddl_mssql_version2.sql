
CREATE TABLE orders (
	pk_orders INTEGER NOT NULL IDENTITY, 
	batch_id VARCHAR(1000) NULL, 
	version INTEGER NULL, 
	input_file_path VARCHAR(256) NULL, 
	xml2db_record_hash BINARY(20) NULL, 
	CONSTRAINT cx_pk_orders PRIMARY KEY CLUSTERED (pk_orders), 
	CONSTRAINT orders_xml2db_record_hash UNIQUE (xml2db_record_hash)
)


CREATE TABLE orderperson (
	pk_orderperson INTEGER NOT NULL IDENTITY, 
	name_attr VARCHAR(1000) NULL, 
	name VARCHAR(1000) NULL, 
	address VARCHAR(1000) NULL, 
	city VARCHAR(1000) NULL, 
	[zip_codingSystem] VARCHAR(1000) NULL, 
	zip_state VARCHAR(1000) NULL, 
	zip_value VARCHAR(1000) NULL, 
	country VARCHAR(1000) NULL, 
	[phoneNumber] VARCHAR(8000) NULL, 
	[companyId_type] CHAR(3) NULL, 
	[companyId_value] VARCHAR(1000) NULL, 
	coordinates VARCHAR(1000) NULL, 
	xml2db_record_hash BINARY(20) NULL, 
	CONSTRAINT cx_pk_orderperson PRIMARY KEY CLUSTERED (pk_orderperson), 
	CONSTRAINT orderperson_xml2db_record_hash UNIQUE (xml2db_record_hash)
)


CREATE TABLE intfeature (
	pk_intfeature INTEGER NOT NULL IDENTITY, 
	id VARCHAR(1000) NULL, 
	value INTEGER NULL, 
	xml2db_record_hash BINARY(20) NULL, 
	CONSTRAINT cx_pk_intfeature PRIMARY KEY CLUSTERED (pk_intfeature), 
	CONSTRAINT intfeature_xml2db_record_hash UNIQUE (xml2db_record_hash)
)


CREATE TABLE stringfeature (
	pk_stringfeature INTEGER NOT NULL IDENTITY, 
	id VARCHAR(1000) NULL, 
	value VARCHAR(1000) NULL, 
	xml2db_record_hash BINARY(20) NULL, 
	CONSTRAINT cx_pk_stringfeature PRIMARY KEY CLUSTERED (pk_stringfeature), 
	CONSTRAINT stringfeature_xml2db_record_hash UNIQUE (xml2db_record_hash)
)


CREATE TABLE product (
	pk_product INTEGER NOT NULL IDENTITY, 
	name VARCHAR(1000) NULL, 
	version VARCHAR(1000) NULL, 
	xml2db_record_hash BINARY(20) NULL, 
	CONSTRAINT cx_pk_product PRIMARY KEY CLUSTERED (pk_product), 
	CONSTRAINT product_xml2db_record_hash UNIQUE (xml2db_record_hash)
)


CREATE TABLE product_features_intfeature (
	fk_product INTEGER NOT NULL, 
	fk_intfeature INTEGER NOT NULL, 
	FOREIGN KEY(fk_product) REFERENCES product (pk_product), 
	FOREIGN KEY(fk_intfeature) REFERENCES intfeature (pk_intfeature)
)


CREATE TABLE product_features_stringfeature (
	fk_product INTEGER NOT NULL, 
	fk_stringfeature INTEGER NOT NULL, 
	FOREIGN KEY(fk_product) REFERENCES product (pk_product), 
	FOREIGN KEY(fk_stringfeature) REFERENCES stringfeature (pk_stringfeature)
)


CREATE TABLE item (
	pk_item INTEGER NOT NULL IDENTITY, 
	fk_product INTEGER NULL, 
	note VARCHAR(1000) NULL, 
	quantity INTEGER NULL, 
	price DOUBLE PRECISION NULL, 
	currency CHAR(3) NULL, 
	xml2db_record_hash BINARY(20) NULL, 
	CONSTRAINT cx_pk_item PRIMARY KEY CLUSTERED (pk_item), 
	CONSTRAINT item_xml2db_record_hash UNIQUE (xml2db_record_hash), 
	FOREIGN KEY(fk_product) REFERENCES product (pk_product)
)


CREATE TABLE shiporder (
	pk_shiporder INTEGER NOT NULL IDENTITY, 
	temp_pk_shiporder INTEGER NULL, 
	fk_parent_orders INTEGER NULL, 
	orderid VARCHAR(1000) NULL, 
	processed_at DATETIMEOFFSET NULL, 
	orderperson_name_attr VARCHAR(1000) NULL, 
	orderperson_name VARCHAR(1000) NULL, 
	orderperson_address VARCHAR(1000) NULL, 
	orderperson_city VARCHAR(1000) NULL, 
	[orderperson_zip_codingSystem] VARCHAR(1000) NULL, 
	orderperson_zip_state VARCHAR(1000) NULL, 
	orderperson_zip_value VARCHAR(1000) NULL, 
	orderperson_country VARCHAR(1000) NULL, 
	[orderperson_phoneNumber] VARCHAR(8000) NULL, 
	[orderperson_companyId_type] CHAR(3) NULL, 
	[orderperson_companyId_value] VARCHAR(1000) NULL, 
	orderperson_coordinates VARCHAR(1000) NULL, 
	shipto_fk_orderperson INTEGER NULL, 
	CONSTRAINT cx_pk_shiporder PRIMARY KEY CLUSTERED (pk_shiporder), 
	FOREIGN KEY(fk_parent_orders) REFERENCES orders (pk_orders), 
	FOREIGN KEY(shipto_fk_orderperson) REFERENCES orderperson (pk_orderperson)
)


CREATE TABLE shiporder_item (
	fk_shiporder INTEGER NOT NULL, 
	fk_item INTEGER NOT NULL, 
	FOREIGN KEY(fk_shiporder) REFERENCES shiporder (pk_shiporder), 
	FOREIGN KEY(fk_item) REFERENCES item (pk_item)
)

CREATE CLUSTERED INDEX ix_fk_product_features_intfeature ON product_features_intfeature (fk_product, fk_intfeature)

CREATE INDEX ix_product_features_intfeature_fk_intfeature ON product_features_intfeature (fk_intfeature)

CREATE CLUSTERED INDEX ix_fk_product_features_stringfeature ON product_features_stringfeature (fk_product, fk_stringfeature)

CREATE INDEX ix_product_features_stringfeature_fk_stringfeature ON product_features_stringfeature (fk_stringfeature)

CREATE CLUSTERED INDEX ix_fk_shiporder_item ON shiporder_item (fk_shiporder, fk_item)

CREATE INDEX ix_shiporder_item_fk_item ON shiporder_item (fk_item)

