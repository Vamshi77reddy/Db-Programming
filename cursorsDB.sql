create database CursorDB
use cursorDB

create table studentmarks(
roll_no int,
student_name varchar(50),
class int, 
maths_marks int,
eng_marks int,
sci_marks int,
)

insert into studentmarks values (1,'vamshi',8,77,76,87),
(2,'sai',8,97,96,93),
(3,'rohith',8,76,56,78),
(4,'rahul',8,87,78,65),
(5,'sudha',8,77,88,67),
(6,'malli',8,87,78,69),
(7,'linga',8,56,87,98),
(8,'rani',8,87,78,91)

select * from studentmarks

declare @roll_no int,
@student_name varchar(50),
@class int,
@maths_marks int,
@eng_marks int,
@sci_marks int,

@total_marks int,
@percentage dec(10,2);

 declare student_cursor cursor for select roll_no,student_name,class,maths_marks,eng_marks,sci_marks
 from studentmarks;

 open student_cursor;

 fetch next from student_cursor into @roll_no,@student_name,@class,@maths_marks,@eng_marks,@sci_marks;
 while @@FETCH_STATUS=0
 begin
 print concat('Name: ',@student_name);
  print concat('RollNo: ',@roll_no);
 print concat('Class: ',@class);
 print concat('Maths: ',@maths_marks);
 print concat('English: ',@eng_marks);
 print concat('Science: ',@sci_marks);
 
 set @total_marks=@maths_marks+@eng_marks+@sci_marks;
 print concat ('Total: ',@total_marks);

  set @percentage=@total_marks/3;

 set @percentage=@total_marks/3;
 print concat ('Percentage: ',@percentage,'%');
 if @percentage>=80
 begin 
 print 'Grade: A';
 end 
 else if @percentage >60 and @percentage<80
 begin
 print 'Grade: B'
 end 
 else
 begin
 print 'Grade: C';
 end
 print '===========';
  fetch next from student_cursor into @roll_no,@student_name,@class,@maths_marks,@eng_marks,@sci_marks;
end
close student_cursor;
deallocate student_cursor;

declare student cursor scroll for select * from studentmarks
open student
fetch first from student
fetch next from student
fetch last from student
fetch prior from student
fetch absolute 2 from student
fetch relative 3from student
close student
deallocate student

declare student cursor scroll for select student_name,maths_marks,eng_marks,sci_marks from studentmarks
declare @student_name varchar(50),@maths_marks int,@eng_marks int,@sci_marks int;
open student
fetch first from student into @student_name,@maths_marks,@eng_marks,@sci_marks
 print concat('student : ',@student_name,@maths_marks,@eng_marks,@sci_marks);


close student
deallocate student

