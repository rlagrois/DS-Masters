SELECT distinct student.name, takes.id
FROM unidb.student, unidb.takes
WHERE student.id = takes.id and takes.year >= 2009;


