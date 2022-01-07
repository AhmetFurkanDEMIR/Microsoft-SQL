select ascii('A')
select char(80)

declare @start int
set @start = 65
while(@start<=90)
begin
	print char(@start)
	set @start = @start + 1
end

select trim('         Hello      ')


select ltrim('    Hello')


select rtrim('Hello    ')


select rtrim(ltrim('    Hello   '))


select lower ('HeLlO')


select upper('HeLlO')


select len('Hello')

select len('Hello   ')

select len('   Hello')

select left('Necmettin Erbakan Üniversitesi Bil Muh.', 5)

select right('Necmettin Erbakan Üniversitesi Bil Muh.', 3)

select charindex('@', 'demir@ahmetfurkandemir.com')

select substring('demir@ahmetfurkandemir.com', 5, 9)
