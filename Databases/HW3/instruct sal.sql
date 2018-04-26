SELECT instructor.name, instructor.salary
FROM unidb.instructor
WHERE instructor.dept_name like 'Elec. Eng.' 
	or instructor.dept_name like 'Comp. Sci.'
ORDER BY instructor.salary DESC;