SQLite format 3   @                                                                          	 1 1�	                                                                                                                                                                                                                                                                                                                                                                                                                                                           �\	�tablegeneralgeneralCREATE TABLE general (
id INTEGER PRIMARY KEY,
mate_id INTEGER not null,
description VARCHAR(50) not null,
start_date date not null,
rating INTEGER not null,
latest INTEGER not null default 0
)�v�?tableexpensesexpensesCREATE TABLE expenses (
id INTEGER PRIMARY KEY,
mate_id INTEGER not null,
description VARCHAR(50) not null,
start_date date not null,
cost INTEGER not null,
rating INTEGER not null,
latest INTEGER not null default 0
)u ��ItablegeneralgeneralCREATE TABLE general (
id INTEGER PRIMARY KEY,
mate_id INTEGER not null,
description VARCHAR(50) not null,
start_date du �P�tablesexsexCREATE TABLE sex (
id INTEGER PRIMARY KEY,
mate_id INTEGER not null,
description VARCHAR(50) not null,
start_date date not null,
rating INTEGER not null,
latest INTEGER not null default 0
)   ��tablesocialsocialCREATE TABLE social (
id INTEGER PRIMARY KEY,
mate_id INTEGER not null,
description VARCHAR(50) not null,
start_date dat��_tablesocialsocialCREATE TABLE social (
id INTEGER PRIMARY KEY,
mate_id INTEGER not null,
description VARCHAR(50) not null,
start_date date not null,
expand_or_decrease VARCHAR(50) not null,
rating INTEGER not null,
latest INTEGER not null default 0
)�o
�=tablematesmatesCREATE TABLE mates (
id INTEGER PRIMARY KEY, 
name VARCHAR(50) not null, 
sex VARCHAR(4) not null,
age VARCHAR(3) not null,
relation VARCHAR(25) not null,
start_date date not null,
latest INTEGER not null default 0
)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      