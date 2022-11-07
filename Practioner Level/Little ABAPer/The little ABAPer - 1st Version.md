# The game with the numbers
-------- -------- 
Is 14 a numeric number? 
 - Yes, because as INT1 it is a numeric number.
-------- -------- 
Is n CO '12345677890' TRUE or FALSE?
   - TRUE, because 14 is INT1.
-------- -------- 
Is -3 a number?
  - Yes, but we do not consider negative numbers like INT2.
-------- -------- 
Is 3.12 a number?
 - Yes, but we do not consider decimal numbers like DEC or FLTP do.
-------- -------- 
Are -3 and 3.12 numbers?
 - Yes, sure, but the only numbers we use are the nonnegative 1-byte-integers 0,1,2,... up to 255.
-------- -------- 
What is "ADD 1 TO n", where n is 67?
 - 68
-------- -------- 
And, what is n = n + 1, where n is 67?
 - Also 68, but less encrypted.
-------- -------- 
What is "SUBTRACT 1 FROM n", where n = 5?
 - 4
-------- -------- 
...and n = n - 1?
 - Also, 4. Stop using these statements. They have no value.
-------- -------- 
What is "SUBTRACT 1 FROM 0"?
 - As I said, stop using it. It serves you right, you receive a hard system crash. -1 is out of range. Catch exception by proofing the input.
-------- -------- 
Is "0 IS INITIAL" TRUE or FALSE?
 - TRUE. 0 is the initial value for numbers. 
-------- -------- 
How to check in another way?
 - n = 0? n is your input.
-------- -------- 
Is "67 IS INITIAL" TRUE or FALSE?
 - Obviously FALSE :)
-------- -------- 
How to add numbers?
 - Easy, just set x = n + m.
-------- -------- 
And now, write a function, which is understandable (no IOSP needed ;) )?
``` 
DATA m TYPE INT1.
       
m = 4.

DATA(result) = COND INT1( WHEN m = 0 THEN m + 1
                          ELSE m - 1).
```
Wasn't this easy?
-------- -------- 
To be continued...

  
