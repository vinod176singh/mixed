CREATE SCHEMA hr;
GO
CREATE TABLE hr.candidates(
    id INT PRIMARY KEY IDENTITY,
    fullname VARCHAR(100) NOT NULL
);

CREATE TABLE hr.employees(
    id INT PRIMARY KEY IDENTITY,
    fullname VARCHAR(100) NOT NULL
);

INSERT INTO 
    hr.candidates(fullname)
VALUES
    ('John Doe'),
    ('Lily Bush'),
    ('Peter Drucker'),
    ('Jane Doe');


INSERT INTO 
    hr.employees(fullname)
VALUES
    ('John Doe'),
    ('Jane Doe'),
    ('Michael Scott'),
    ('Jack Sparrow');

select * from hr.candidates
select * from hr.employees;

select a.*,b.* from hr.candidates a
inner join hr.employees b on a.fullname=b.fullname;

select a.fullname from hr.candidates a
inner join hr.employees b on a.fullname=b.fullname

select b.*,a.* from hr.employees b
left outer join hr.candidates a  on a.fullname=b.fullname
where a.id is not null;

select b.*,a.* from hr.employees b
left outer join hr.candidates a  on a.fullname=b.fullname
where a.id is not null;

select a.fullname,b.fullname from hr.candidates a
right outer join hr.employees b on a.fullname=b.fullname
where a.fullname  is  null
