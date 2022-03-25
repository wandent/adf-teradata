if object_id('dbo.sampledata') is not null
  Drop Table dbo.sampledata

create table dbo.sampledata
( id int identity(1,1) primary key,
  value_decimal decimal(14,4), 
  value_string decimal(14,4), 
  value_int integer)


  