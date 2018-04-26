SELECT instructor.dept_name, max(salary)
FROM unidb.instructor
GROUP BY instructor.dept_name;