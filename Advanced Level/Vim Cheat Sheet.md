# Vim Cheatsheet

	vim {filename}

General |   |   
--------|---|
```:e {filename}``` | edit a file
```:q``` | quit
```:q!``` | quit without writing
```:wa``` | write all changed files (save all changes), and keep working
```:xa``` | exit all (save all changes and close Vim)
```:qa``` | quit all (close Vim, but not if there are unsaved changes)
```:qa!``` | quit all (close Vim without saving—discard any changes)
```:wq``` | write the current file and quit.
```:x``` | like ":wq", but write only when changes have been made.
```ZZ``` | write current file, if modified, and quit (same as ```:x```)
```.``` | repeat command
```u``` | undo
```CTRL+R``` | redo 
```CTRL-N``` | autocomplete next matching word
```CTRL+P``` | autocomplete previous matching word
```g;``` | goes back to the location of the last edit. This is “pick up where I left off before going somewhere else”. It keeps track of your edit history so that you can go back five edits ago. 
```g,``` | moves you back forward in the edit history.
```zR``` | open all folds .
```zM``` | close all folds .
```cck``` | Close the quickfix window.
```lcl``` | Close the window showing the location list for the current window..
```Explore``` | Opens netrw in the current window
```Sexplore``` | Opens netrw in a horizontal split
```Vexplore``` | Opens netrw in a vertical split

Navigation |  |
-----------|--|
```h``` |  move one character left
```j``` |  move one row down
```k``` |  move one row up
```l``` |  move one character right
```w``` |  move to beginning of next word
```b``` |  move to beginning of previous word
```e``` |  move to end of word
```W``` |  move to beginning of next word after a whitespace
```B``` |  move to beginning of previous word before a whitespace
```E``` |  move to end of word before a whitespace
```f``` |  move to the first...
```t``` |  move until the first...

**All the above movements can be preceded by a count; e.g. 4j will move down 4 lines.**

Navigation    |  |
--------------|--|
```0``` | move to beginning of line
```$``` | move to end of line
```^``` | move to first non-blank char of the line
```_``` | same as above, but can take a count to go to a different line
```g_``` | move to last non-blank char of the line (can also take a count as above)
```gg``` | move to first line
```G``` | move to last line
```nG``` | move to n'th line of file (where n is a number)
```H``` | move to top of screen
```M``` | move to middle of screen
```L``` | move to bottom of screen
```)``` | jump forward one sentence
```(``` | jump backward one sentence
```}``` | jump forward one paragraph
```{``` | jump backward one paragraph
```zz``` | put the line with the cursor at the center
```zt``` | put the line with the cursor at the top
```zb``` | put the line with the cursor at the bottom of the screen
```Ctrl-D``` | move half-page down
```Ctrl-U``` | move half-page up
```Ctrl-B``` | page up
```Ctrl-F``` | page down
```Ctrl-o``` | jump to last cursor position
```Ctrl-i``` | jump to next cursor position
```n``` | next matching search pattern
```N``` | previous matching search pattern
```*``` | next word under cursor
```#``` | previous word under cursor
```g*``` | next matching search pattern under cursor
```g#``` | previous matching search pattern under cursor
```%``` | jump to matching bracket { } [ ] ( )
```Go``` |jump to end of the file with a new line appended

[Marks](http://vim.wikia.com/wiki/Using_marks) |   |
-----------------------------------------------|---|
```ma``` | set mark a at current cursor location
```'a``` | jump to line of mark a (first non-blank character in line)
`` `a`` | jump to position (line and column) of mark a

Shell commands|   |
--------------|---|
```:! cmd``` | execute ```cmd``` in the shell
```:! cmd %``` | execute ```cmd``` in the shell on the current file (%)
```Ctrl-Z``` | putting vim into the background<br>type ```fg``` in your shell to bring vim back to the foreground
```:w !cmd``` | write the current buffer to the stdin of an external command
```:%!cmd``` | write the current buffer to the stdin of an external command and then replaces the current buffer with the output of the command.
	
Search  | |
--------|---------------------------------------------------------------------
```/``` | search for a pattern which will take you to the next occurrence.
```?``` | search for a pattern which will take you to the previous occurrence.
```n``` | for next match in forward
```N``` | for previous match in backward

Insert / Delete | |
----------------|-----------------------------------------------------------------
```I``` | Insert at start
```A``` | Append at end
```D``` | Delete to end of line
```;``` | Clear current line, to insert mode: S
```o``` | Insert new line below
```O``` | Insert new line above
```x``` | Delete
```X``` | Backspace X
```r``` | Replace under cursor
```d``` | Delete word (like d2w for deleting 2 words)

Copy / Paste | |
----------------|-----------------------------------------------------------------
```yy``` | Copy current line
```p``` | Paste copied text after cursor

Comments| |
----------------|-----------------------------------------------------------------
```CTRL+V (select lines) I#``` | Comment
```CTRL+V (select lines) X``` | Uncomment

Tabs | |
----------------|-----------------------------------------------------------------
```:tabedit {file}``` | edit specified file in a new tab
```:tabfind {file}``` | open a new tab with filename given, searching the 'path' to find it
```:tabclose``` | close current tab 
```:tabclose {i}``` | close i-th tab
```:tabobly``` |  close all other tabs (show only the current tab)
```:tab ball``` | show each buffer in a tab (up to 'tabpagemax' tabs)
```:tab help``` | open a new help window in its own tab page
```:tab drop {file}``` | open {file} in a new tab, or jump to a window/tab containing the file if there is one
```:tab split``` | copy the current window to a new tab of its own
```:tabs``` | list all tabs including their displayed windows
```:tabm 0``` | move current tab to first
```:tabm``` | move current tab to last
```:tabm {i}``` | move current tab to position i+1
```:tabn``` | go to next tab
```:tabp``` | go to previous tab
```:tabfirst``` | go to first tab
```:tablast``` | go to last tab
 | In normal mode, you can type:
```gt``` | go to next tab
```gT``` | go to previous tab
```{i}gt``` | go to tab in position i

Buffers | |
----------------|-----------------------------------------------------------------
```:ls``` | list of all listed buffers
```:ls!```| list of all listed and unlisted buffers
```:badd {filename}```| add a new buffer for a file without opening it
```:b{i}```| open i-th buffer
```:ball```| open all buffers in windows
```:vertical ball```| open all buffers in vertical windows
```:bn```| next buffer
```:bp```| previous buffer
```:b#```| alternate buffer
```:bd```| delete a buffer
```:sb```| split window and edit buffer
```:vertical sb```| vertical split window and edit buffer
```:vert sb N``` | Open buffer N as a vertical split
```:r {filename}``` |  read a file into the current buffer
```:sp {filename}``` |  open a file in a horizontal split
```:vsp {filename}```  | open a file in a vertical split

Windows |   |
--------|---|
```CTRL-W =``` | make all split screens have the same width
```CTRL-W >``` | resize the width of the current window by a single column
```CTRL-W <``` | resize the width of the current window by a single column
```CTRL-W +``` | resize the height of the current window by a single row
```CTRL-W -``` | resize the height of the current window by a single row
```CTRL-W r``` | rotate window

Popupmenu |   |
----------|---|
```:help popupmenu-keys``` | help about the popup menu keys
```:help popupmenu-completion``` | help about the popup menu state
```CTRL-Y``` | Yes: Accept the currently selected match and stop completion
```CTRL-E``` | End completion, go back to what was there before selecting a match
```CTRL-P``` | Select the previous match
```CTRL-N``` | Select the next match

## Various Nifty commmands ;)
- Pretty print JSON: ```:%!python -m json.tool``` 

## Registers
All text cut and copy operations are saved into registers. If you have cut text and then cut something else, you haven’t lost the first cut – just type ```:reg``` (short for ```:registers```) to see all of the registers. You can then type the name of the register and then ```p```, such as ```"3p```, to paste whatever you cut three or four operations prior.

It’s a good habit to use registers for longer-term copies and pastes. If there’s anything you want to save “in the clipboard” for a while, you cut or copy it to register ```a``` , such as with ```"ay``` (copy) or ```"ad``` (cut). That way, no matter how many operations later, you're still able to paste what you wanted with ```"ap```.

## Macros
Hit ```qa``` to record keystrokes to register ```a```, hit ```q``` when you’re finished, hit ```@a``` to play the macro in register ```a``` and ```@@``` to repeat the last macro.

## Substitute
[Search and replace](http://vim.wikia.com/wiki/Search_and_replace)

## Global
[The power of g](http://vim.wikia.com/wiki/Power_of_g)

## THE BEST VIM COMMANDS
If you already use Vim, but don’t use the following commands to their fullest, you’re not living right.

- ```CTRL-]``` jumps to the location of the definition of the function under the cursor, and ```CTRL-t``` gets you back. Go as deep as you want — hitting ```CTRL-t``` until it doesn’t work anymore will get you back where you started. (You’ll need a tags file to make this work.) This is fully 1/2 of the value of an IDE like Eclipse for me, built in, with less screen clutter.
- The other half of an IDE is tab-completion of long variable or function names. This is done in Vim with ```CTRL-n``` and ```CTRL-p``` to scroll up and down the possible list. If you are using a tags file, or if you have the file with the other definitions open in Vim, it will complete the name for you.
- ```gg=G``` jumps to the top of the document (```gg```) and auto-indents it (```=```) until the end of the document (```G```). This makes all your open and close braces line up, and makes it very easy to spot the one that you forgot.
- ```u``` undoes the last command. ```CTRL-r``` redoes. ```:earlier 2m``` reverts to the state that it was two minutes ago. If you end up undoing, editing, and then want to undo some previous changes, you can. ```g+``` and ```g-``` will step up and down the undo tree. It gets complicated.
- ```/``` and ```f```, the search commands, are vital as a motion in a compound command. ```df,``` deletes everything up to the first comma. ```d/foo``` lets you delete until the first (interactive) match on “foo”. This can replace many other movements if you’re so inclined.
- ```:r``` reads in a file. ```:!``` runs a command in the shell. ```:r!``` pastes the output of a command into your document. ```:r!ls whatever*``` is often faster than typing in a filename. I’m not going to get started on how UNIXy the ability to run your text through arbitrary shell scripts is.

## References
- [EDITOR WARS: THE REVENGE OF VIM](http://hackaday.com/2016/08/08/editor-wars-the-revenge-of-vim/)
