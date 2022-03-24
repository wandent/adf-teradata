if object_id('dbo.sampledata') is not null
  Drop Table dbo.sampledata

create table dbo.sampledata
( id int identity(1,1) primary key,
  value_decimal decimal(14,4), 
  value_string varchar(14), 
  value_int integer)


  insert dbo.sampledata(value_string, value_int, value_decimal)
    values("1000.0000",1000, 1000.0000 )
  
 insert dbo.sampledata(value_string, value_int, value_decimal)
    values("1000,0000",1000, 1000.0000 )
    