## Pewlett-Hackard-Analysis

### Overview of the Analysis: 
Pewlett-Hackard, it looking to future-proof their company and prepare for the mass retirement of employees from the boomer generation. They are looking to offer employees who are eligible to retire, a retirement package. Bobby, an HR analyst asked for our assistance in creating an employee database and perform employee research. We are tasked in helping him determine which employees are retiring and how many employees are eligible to retire. We created two final queries to return the number of retiring employees by title and to return a list of employees that are eligibly for the mentorship program.

### Results:
#### Analysis 1. The number of retiring Employees by Title
* Engineering positions have the most employees retiring with 3 out of 7 of the titles being Engineering positions, and a total of 45,397 positions eligible for retirement.
* The positions with the title "Senior Engineer" have the most employees that are eligible for retirement.
* 3 out of the 7 positions are considered Senior or Manager level and those employees could be considered better candidates for mentorship as they have they could one of the most knowledge about the company.

     ![](https://i.imgur.com/TqE3T9c.png)


#### Analysis 2. The list of Employees Eligible for the Mentorship Program
* Generated a table of employees eligible for the mentorship program and exported into a CSV for future use and preparation.
* The table provides current titles of each employee which will be helpful for further research and developement of the mentorship program in matching potential mentees with mentors that have been promoted in the company and/or accumalted a high business acumen of the company.

    ![](https://i.imgur.com/O1Rwzp9.png)

### Summary:
1. How many roles will need to be filled as the "silver tsunami" begins to make an impact?
    * Pewlet-Hackard will need to fill 36,619 positions in the near future. The Development and Production department will have the most positions affected by the "silver tsunami." They will also benefit the most from the mentorship program. Below is the query and table output to determine the amount of employees eligible for retirement and by department.
    
        Table of Retiring Employees: 
        `SELECT ut.emp_no,
        ut.first_name,
        ut.last_name,
        d.dept_name
        INTO total_retiring
        FROM unique_titles AS ut
        INNER JOIN dept_info AS d
        ON (ut.emp_no = d.emp_no)
        ORDER BY dept_name;`

        The number of employees eligible to retire:
        `SELECT COUNT (emp_no)
        FROM total_retiring;`

        ![](https://i.imgur.com/wUarRJy.png)

       The number of eligible employees to retire by department: 
       `SELECT COUNT (emp_no), dept_name
        FROM total_retiring
        GROUP BY dept_name
        ORDER BY (COUNT(emp_no)) DESC;`
        
        ![](https://i.imgur.com/hxQC0iz.png)

2. Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?
    * Unfortunately, there is not enough retirement-ready employees to mentor each new position that will open with the "silver Tsunami". There is currently 1,549 potential mentors based on the mentor eligibilty table. To determine this we ran a count function on the mentor eligibility table. For future planning, it is best to look into these candiates and what departments they are currently in. This will be helpful in seeing which departments could be hit hard by the "silver tsunami." I've attempted the analysis with the queries below. 
        
        The total number of eligible mentors:
        `SELECT COUNT (emp_no)
        FROM mentorship_eligibility;`
        
        ![](https://i.imgur.com/gcySven.png)

        The number of eligible mentors by department:
        `SELECT COUNT (emp_no),
        dept_name
        FROM mentors_dept
        GROUP BY dept_name;`

       Table of Mentorship Eligibility by department:
        `SELECT  (me.emp_no),
        d.dept_name
        INTO mentors_dept
        FROM mentorship_eligibility AS me
        INNER JOIN dept_info AS di
        ON (me.emp_no = di.emp_no);`
