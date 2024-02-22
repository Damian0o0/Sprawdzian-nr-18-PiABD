/*
CREATE PROCEDURE sp_nazwa
@parametr typ_danych -----parametr wejœciowy
@parametr2 typ_danych OUTPUT --parametr wyjœciowy
AS
	BEGIN
		SELECT ........ FROM.....WHERE.....@parametr
	END
		---wykonanie procedury
	execute sp_nazwa_procedury ewentualnie @parametr
	*/
----------------------------------------------------------------------------
---1. Napisz procedurê xyz01, która wyswietli nazwe kraju,powierzchniê i ludnoœæ Hiszpanii

select * from country;

create proc xyz09
as
begin
	select name,area,population from country where name like 'Spain'
end
go

exec xyz09
------------------------------------------------------

----2. Napisz procedurê xyz02, która wyœwietli miasta z ludnoœci¹  poprzez podanie parametru wejœciowego
--     liczby mieszkaców powy¿ej 5 mln 
  
select * from city;

  create proc xyz10
  @pop int
  as
  begin
	select name,population from city where population>@pop
  end
  go

  exec xyz10 5000000

-------------------------------------------------------------

----3. Napisz procedurê xyz03, która wyœwietli kod panstwa, pañstwo wraz z ludnoœci¹  poprzez podanie parametru wejœciowego
--     liczby mieszkaców powy¿ej 10 mln i pocz¹tku kodu pañstwa
  
 select * from country;

  create proc xyz11
  @pop int,
  @kod varchar(10)
  as
  begin
	select name,code,population from country where population>@pop and Code like @kod + '%'
  end
  go

  exec xyz11 10000000,'p'

---------------------------------------------------------------------

--4. Napisz procedurê xyz04, która wyswietli nazwy miast, kod pañstwa oraz ludnoœæ poprzez podanie parametrów  wejœciowych
--     liczby mieszkaców z z dowolnego zakresu. 

select * from city;


create proc xyz12
@pop1 int,
@pop2 int
as
begin
	select name,country,population from city where population between @pop1 and @pop2
end
go

exec xyz12 100000, 150000 


------------------------------------------------------------------------

--5.Napisz procedurê xyz05, która wyœwietli nazwy krajów oraz kod tych krajów z jêzykiem urzêdowym  
--dla dwóch jezyków i uwzgledniaj¹c, ¿e znamy tylko czêœæ nazwy jezyka.


select * from country;
select * from language;

create proc xyz13
@jez1 varchar(15),
@jez2 varchar(15)
as
begin
	select c.name,c.code,l.name from country c inner join language l on l.Country=c.Code where l.Name like @jez1+'%' or l.Name like @jez2+'%'
end
go

exec xyz13 'polis','germa'

-------------------------------------------------------

--6. Utwórz procedurê xyz06  gdzie w parametrze wejœciowym podamy kod kraju a w parametrze wyjœciowym
--ma siê wyswietliæ nazwa kraju
select * from country

create proc xyz14
@kod varchar(20),
@nazwa varchar(20)out
as
begin
	select @nazwa=name from country where Code like @kod
end
go

declare @wynik varchar(20)
exec xyz14 'pl',@wynik out
print @wynik
---------------------------

--7. Utwórz procedurê xyz07 która  w parametrze wyjœciowym wyœwietli liczbê krajów , gdzie jêzykiem urzêdowym jest jezyk niemiecki i hiszpañski poprzez podanie 
-- dwóch parametrów - kodu kraju

use mondial

select *from country;
select * from language;

create proc xyz15
@kod1 varchar(20),
@kod2 varchar(20),
@liczba int out
as
begin
	select @liczba=count(country) from language where country like @kod1 or country like @kod2 group by Name
end
go
declare @wynik int
exec xyz15 'E','Ge',@wynik out
print @wynik


---------------------------------------------------------------

--8. Utwórz procedurê xyz08 , która w parametrze wyjœciowym poda liczbê krajów
-- poprzez podanie w parametrze wejsciowym nazwy jêzyka.

select * from country;
select * from language;

create proc xyz16
@jezyk varchar(20),
@liczba int out
as
begin
	select @liczba=count(country)from language where name like @jezyk
end
go

declare @wynik int
exec xyz16 'Polish',@wynik out
print @wynik