create table if not exists relay (
	row		integer		not null,
	col		integer		not null,
	label		varchar(64)	null,
	used		integer		null
);
