truncate table Destination;
insert into Destination(s) select s from Source;