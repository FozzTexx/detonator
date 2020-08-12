create table if not exists relay (
	yrow		integer		not null,
	xcol		integer		not null,
	label		varchar(64)	null,
	used		integer		null
);
