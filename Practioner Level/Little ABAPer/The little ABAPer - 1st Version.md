# The game with the primitive objects

|  You    | Code      |  Me      |
| ------------ | ------------- | ------------------ | 
| Is 14 a numeric number? |   | Yes, because as INT1 it is a numeric number. | 
| Is n CO '12345677890' TRUE or FALSE?       |   | TRUE, because 14 is INT1.    | 
| Is -3 a number?      |     | Yes, but we do not consider negative numbers like INT2. | 
| Is 3.12 a number?    |     | Yes, but we do not consider decimal numbers like DEC or FLTP do. |
| Are -3 and 3.12 numbers? | | Yes, sure, but the only numbers we use are the nonnegative 1-byte-integers 0,1,2,... up to 255. |
| What is "ADD 1 TO n", where n is 67? | | 68 |
| And, what is n = n + 1, where n is 67? | | Also 68, but less encrypted. |
| What is "SUBTRACT 1 FROM n", where n = 5? | | 4 |
| ...and n = n - 1? | | Also, 4. Stop using these statements. They have no value. |
| What is "SUBTRACT 1 FROM 0"? | | As I said, stop using it. It serves you right, you receive a hard system crash. -1 is out of range. Catch exception by proofing the input. |
| Is "0 IS INITIAL" TRUE or FALSE? | | TRUE. 0 is the initial value for numbers. |
| How to check in another way? | n = 0 | ..., where n is your input. |
| Is "67 IS INITIAL" TRUE or FALSE? | | Obviously FALSE :) | 
| How to add numbers? | | Easy, just set x = n + m. |
| And now, write a function, which is understandable (no IOSP needed ;) )? | 
``` 
    DATA m TYPE INT1.
    m = 4.
    DATA(result) = COND INT1( WHEN m = 0 THEN m + 1
                              ELSE m - 1). 
``` 
|  You    | Code      |  Me      |
| ------------ | ------------- | ------------------ | 
| | | Is this good? |
| Japp, Wasn't this easy? | | |
| Coming back to CURR: Is assignment INT to CURR possible? | | For sure. |
| And the other way round? | | For sure, but be aware of lossing the decimal places. If needed use conversion logic for the decimal places. |
| Ok, I will be careful. When to use CURR? | | For working with currencies |
| I always struggle with the digits before the decimal point. How many has CUSS11_2? | | 8 |
| Why? | | Length is 11, two digits behind the decimal point, plus decimal point, we have 11 - 2 - 1 = 8. |
| Is there something else I have to be aware of, using CURR type? | | Japp, in table type declaration we need to set a reference table for the currency. |
| Oh wow, that is complicated. Do you know one of them? | | Use T001, field WAERS, if no relation with the declared table type existing. |
| What is 'A'? | | It is a CHAR |
| Type used? | | CHAR1 |
| Can I assign 'B', too? | | Yes, of course. Any character, even the special ones. |
| Is it case sensitive? | | Nope. Use TEXT1 if you need small characters, too. |
| Do you have a suggesetion for the declaration of "Hello World"? | | Use TEXT11. |
| Is the length dynamic? | | No, of course not. |
| And if I do not know the length in the beginning? | | Use string. |
| I read about strlen, what is it good for? | | You can use it to detmermine the length of the string. |
| And how does it work? | | |
```
  DATA: lv_string TYPE string VALUE 'This is a test'.
  DATA(lv_length) = strlen(lv_string).
  ``` 

|  You    | Code      |  Me      |
| ------------ | ------------- | ------------------ | 
| Nice, result? | | 13 |
| Sure? | | Of course, do you doubt my abilities? :) |
| Coming back to this thing with assigments: Is there another way, make assignments, instead of using values? | | Japp, with field symbols. |
| How can I declare them? | |FIELD-SYMBOLS <fs> TYPE CHAR1 |
| When do we use them? What is the advantage? || By assigning we are changing entries in the root source. Or use them for casting. |
| Do you have an coding example? |||
```
  LOOP AT itab ASSIGNING FIELD-SYMBOL(<fs>).
    <fs>-field1 = 'Test'.
  ENDLOOP.
``` 
|  You    | Code      |  Me      |
| ------------ | ------------- | ------------------ | 
|Ah nice. I got the idea. What is <value> in?|||
```
  FIELD-SYMBOLS: <value> TYPE INT1.
  DATA(var) = 2.
  ASSIGN var TO <value>.
``` 
|  You    | Code      |  Me      |
| ------------ | ------------- | ------------------ | 
|||It is 2. But why do you not set simply: <value> = var, or much easies FIELD-SYMBOLS(<value>) = 2?|
| Good question, still to learn ...|||
| There is a more generic way to make an assignment?|| Yes, there is.|
|  You    | Code      |  Me      |
| ------------ | ------------- | ------------------ | 
```
  ASSIGN COMPONENT 'FIELD1' OF STRUCTURE <structure> TO <value>
``` 
|  You    | Code      |  Me      |
| ------------ | ------------- | ------------------ | 
| And if the assignment does not work? || Hard dump. Check "IS ASSIGNED" before working with the FIELD-SYMBOL.|
| And how to cut the assignment? || Use UNASSIGN <value> |
| Anything else to be aware of? || If assignment still living and you change the field symbol value, you change the value in the source, too. |
-------- --------
