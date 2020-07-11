-- STAGING TABLES

CREATE TABLE public.immigration (
    cicid int, 
    i94yr int, 
    i94mon int, 
    i94cit int, 
    i94res int, 
    i94port varchar, 
    arrdate int, 
    i94addr varchar, 
    depdate int, 
    i94visa int, 
    count int, 
    admnum int, 
    visatype varchar,
    CONSTRAINT immigration_pkey PRIMARY KEY ("cicid")
);

CREATE TABLE public.state (
    state_code varchar, 
    state varchar, 
    total_population int, 
    CONSTRAINT state_pkey PRIMARY KEY ("state_code")
);


CREATE TABLE public."date" (
    sas_date int, 
    date varchar, 
    day int, 
    month int, 
    year int, 
    weekday int,
    CONSTRAINT date_pkey PRIMARY KEY ("sas_date")
) ;