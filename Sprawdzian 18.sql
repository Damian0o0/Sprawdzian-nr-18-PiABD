/*
CREATE PROCEDURE sp_nazwa
@parametr typ_danych -----parametr wej�ciowy
@parametr2 typ_danych OUTPUT --parametr wyj�ciowy
AS
	BEGIN
		SELECT ........ FROM.....WHERE.....@parametr
	END
		---wykonanie procedury
	execute sp_nazwa_procedury ewentualnie @parametr
	*/
----------------------------------------------------------------------------
---1. Napisz procedur� xyz01, kt�ra wyswietli nazwe kraju,powierzchni� i ludno�� Hiszpanii

select * from country;

create proc xyz09
as
begin
	select name,area,population from country where name like 'Spain'
end
go

exec xyz09
------------------------------------------------------

----2. Napisz procedur� xyz02, kt�ra wy�wietli miasta z ludno�ci�  poprzez podanie parametru wej�ciowego
--     liczby mieszkac�w powy�ej 5 mln 
  
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

----3. Napisz procedur� xyz03, kt�ra wy�wietli kod panstwa, pa�stwo wraz z ludno�ci�  poprzez podanie parametru wej�ciowego
--     liczby mieszkac�w powy�ej 10 mln i pocz�tku kodu pa�stwa
  
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

--4. Napisz procedur� xyz04, kt�ra wyswietli nazwy miast, kod pa�stwa oraz ludno�� poprzez podanie parametr�w  wej�ciowych
--     liczby mieszkac�w z z dowolnego zakresu. 

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

--5.Napisz procedur� xyz05, kt�ra wy�wietli nazwy kraj�w oraz kod tych kraj�w z j�zykiem urz�dowym  
--dla dw�ch jezyk�w i uwzgledniaj�c, �e znamy tylko cz�� nazwy jezyka.


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

--6. Utw�rz procedur� xyz06  gdzie w parametrze wej�ciowym podamy kod kraju a w parametrze wyj�ciowym
--ma si� wyswietli� nazwa kraju
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

--7. Utw�rz procedur� xyz07 kt�ra  w parametrze wyj�ciowym wy�wietli liczb� kraj�w , gdzie j�zykiem urz�dowym jest jezyk niemiecki i hiszpa�ski poprzez podanie 
-- dw�ch parametr�w - kodu kraju

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

--8. Utw�rz procedur� xyz08 , kt�ra w parametrze wyj�ciowym poda liczb� kraj�w
-- poprzez podanie w parametrze wejsciowym nazwy j�zyka.

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