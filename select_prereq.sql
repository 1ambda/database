SELECT p.course_id, c1.title AS course_title, p.prereq_id, c2.title AS prereq_title
FROM prereq p
     INNER JOIN course c1
     ON p.course_id = c1.course_id
     INNER JOIN course c2
     ON p.prereq_id = c2.course_id;
