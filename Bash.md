# Bash handbook 


> This is a practical handbook about the basic functions and concepts in BASH that I wrote for my own reference in case I forget a certain BASH function. If you stumble upon this handbook and find it useful, the pleasure is mine :)    
> .   
> Evgenii Zorin

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC_BY_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)

# Contents
- [Bash handbook](#bash-handbook)
- [Contents](#contents)
- [Basic commands and infor](#basic-commands-and-infor)
  - [Processes](#processes)
  - [Nano](#nano)
- [Navigation](#navigation)
  - [pwd](#pwd)
  - [cd](#cd)
  - [Directory manipulation](#directory-manipulation)
  - [ls](#ls)
  - [find](#find)
  - [search str](#search-str)
  - [misc](#misc)
  - [pushd / popd](#pushd--popd)
- [Standard streams](#standard-streams)
- [Permissions](#permissions)
- [Variables](#variables)
- [Data Types](#data-types)
  - [String](#string)
  - [Array](#array)
  - [Int and float](#int-and-float)
- [Date and time](#date-and-time)
- [Regular expressions](#regular-expressions)
- [Conditional statements and loops](#conditional-statements-and-loops)
  - [IF](#if)
  - [WHILE](#while)
  - [UNTIL](#until)
  - [FOR](#for)
  - [CASE statements](#case-statements)
- [Operators](#operators)
- [Function definition](#function-definition)
- [Encoding](#encoding)
- [Main commands](#main-commands)
  - [Running jobs](#running-jobs)
  - [Processing data and pipelines](#processing-data-and-pipelines)
    - [Pipes](#pipes)
    - [AWK](#awk)
    - [CAT](#cat)
    - [CUT](#cut)
    - [SED](#sed)
    - [SORT](#sort)
    - [UNIQ](#uniq)
    - [HEAD, TAIL](#head-tail)
  - [Compression](#compression)
  - [CP](#cp)
  - [CURL](#curl)
  - [ECHO\_PRINTF](#echo_printf)
  - [FIND](#find-1)
  - [GREP](#grep)
  - [RANDOM](#random)
  - [RENAME](#rename)
  - [SCREEN](#screen)
  - [SHUF](#shuf)
  - [TMUX](#tmux)
  - [TR](#tr)
  - [TREE](#tree)
  - [WC](#wc)
  - [WGET](#wget)
  - [XARGS](#xargs)
  - [CRON](#cron)
- [Workload managers](#workload-managers)
- [Bioinformatics commands](#bioinformatics-commands)
- [BASH scripting](#bash-scripting)
  - [Error handling](#error-handling)


# Basic commands and infor

If you are working on WSL Ubuntu terminal, you could cd to the Desktop folder with the following command:
```cd /mnt/c/Users/evgen/Desktop```

Exit status:
- 0: true
- 1: false

**Flags** in linux are command modifiers used to modify the behaviour of command-line utilities. Flags are represented by a hyphen (-) followed by a letter. 

Commands like echo etc. are located in `/usr/bin`.

Examples of some commands: `pwd`, `cd`, `ls`, `etc`:
- Change pw ```passwd```
- Print current date ```date```
- Check the server's load ```top``` or ```htop```
- Check how many resources we have ```df -h```
- See info about the file ```file file.txt```
- See where the program is installed ```which fastqc```
- Gen full path of a file ```readlink -f file.txt```
- Print files in the current dir ```for i in $(ls); do echo $i; done```
- Print .txt files in the current dir ```for i in *.txt; do echo $i; done```
- Print difference btw two files, or print nothing if equal ```diff file1.txt file2.txt``` add flag -u for a more readable output
- Clear the screen w/o deleting the scroll history ```clear -x``` or shortcut in Win ```ctrl + L```
- Check exit status of the last cmd `echo $?`. Zero errors is 0, doesn't exist or False is 1. 

**History**
- Print history: `history`
- Find a specific command within history: `history | grep "<command>"`
- Execute cmd from a line number X from history `!X`

```bash
: '
comment out
multiple lines
'
```

| Command | Action |
| --- | --- |
| `<cmd> --help`, `man <cmd>`, `help <cmd>`, `whatis pwd` | Get help for a command `<cmd>` |
| `du -h file.txt`, `du -hc directory` | Check size of file or directory |
| `df -H` | Check available memory |
| `nvtop`, `watch -n0.1 nvidia-smi` | A command to show the GPU status for the brands such as AMD, Intel, and Nvidia |

**Deleting files and directories**

Flags:
- `-d`: remove empty directory
- `-r`: remove non-empty directory and its contents
- `-f`: ignore any prompt when deleting a file

```bash
### Remove SILENTLY a non-empty folder with all its contents
rm -rf dirname
### Remove all contents of the folder (including all interior folders) but not the folder itself
rm -rf /path/to/directory/*
```

## Processes

`top`: an older command. Shows processes that consume system resources.

`htop`: a more modern version of `top`. Show every process currently ongoing. 

## Nano

Here are some useful hotkeys to use in Nano:

**(Note: where applicable, `Alt+R` or `Esc+R` toggles REGEXP)**

Edit lines
| Shortcut | Action|
| - | - |
| `Alt+6`, `Ctrl+K`, `Ctrl+U` | Copy, cut, and paste selected text |
| `Ctrl+K` | Delete current line |
| `Ctrl+\` | Replace string with something else. |
| `Alt+3` | Comment / uncomment the current line |

Navigation
| Shortcut | Action |
| - | - |
| `Alt+▲`, `Alt+▼` | Scroll up / down one line without moving the cursor |
| `Ctrl+_` | Go to line and column number ... |
| `Ctrl+◀` and `Ctrl+▶` | Go backward / forward one word. |
| `Ctrl+A` and `Ctrl+E` | Go to start / end of the current line. |
| `Ctrl+P` and `Ctrl+N` | Go to previous / next line. |
| `Ctrl+W` | Search forward for the first occurrence. |
| `Ctrl+Q` | Search backwards for occurrence. You can navigate forward with `Alt+W` and backward with `Alt+Q`. |
| `Ctrl+A`, `Ctrl+E` | Move cursor to the start / end of the line |

Time travel
| Shortcut | Action |
| - | - |
| `Alt+U` | Undo |
| `Alt+E` | Redo |

Information / preferences
| `Ctrl+G` | Display help text |
| `Alt+X` | Enable / disable help mode |
| `Alt+S` | Toggle soft wrapping of overlong lines |
| `Alt+N`, `Alt+Shift+3` | Toggle line numbering on the left |
| `Alt+P` | Toggle whitespace display |
| `Ctrl+I` | Toggle auto indent |

# Navigation

There are two methods for accessing directory paths: 
- Absolute path: specify the location of a file / directory from the root directory; always start with a forward slash. E.g. `/home/user/data/file.txt`
- Relative path: specify the location of a file / directory relative to the current directory. E.g. `cd data`

## pwd

Print working directory (path): `pwd`

## cd 

`cd` is the command to change directory. `cd` command can be used with relative and absolute paths:
| Environment | Current directory | Path to cd | Resulting path |
| - | - | - | - |
| Local (Windows) | `c:/tmp` | Relative: `dir1` | `c:/tmp/dir1` |
| Local (Windows) | `c:/tmp` | Relative: `dir1/dir2` | `c:/tmp/dir1/dir2` |
| Local (Windows) | `c:/tmp` | Absolute: `c:/another/one` | `c:/another/one` |
| Remote (Linux) | `/var` | Relative: `dir1` | `/var/dir1` |
| Remote (Linux) | `/var` | Absolute: `/home/users` | `/home/users` |

```bash
cd # without any arguments, it will take you back to your home directory

cd /mnt/c/Users/your-username-here/Desktop # In WSL, make Desktop your workdir

cd . # stay at your current directory - so this does nothing
cd .. # go back one level
cd ../.. # go back two levels
```


## Directory manipulation

```bash
# `touch` - create a file or a directory: 
`touch <file_or_directory>`

# `mkdir` - create a directory:
# Create a nested directory
mkdir -p nested1/nested2`

# | Flag | Meaning |
# | - | - | 
# | -f, --force | Never prompt upon deleting |
# `rm` - remove a file or directory:
`rm file.py`
# Delete a directory and its files
rm -r directory_with_files
# Delete a directory and its files without prompting (not interactively)
rm -rf directory_with_files
# In the current directory, interactively delete files and directories
rm -ir *

# `rmdir` - remove an empty directory:
rmdir empty_directory

# `mv` - moving and renaming files or directories
# Rename a file
mv oldname.txt newname.txt
# Rename a directory
mv oldDirName newDirName
# Move a file
mv file.jpg target_directory
# move file to the previous directory
mv file.jpg ..


# Copy a file to a target directory:
cp file.jpg target-directory
# copy multiple files
cp /home/usr/dir/{file1.txt,file2.txt,file3.txt} /home/usr/destination
cp file{1,2,3} Destination_folder
# Copy files and nested directories from one path to another
cp -r test-prospect-evgenii-zorin /home/jovyan/work/Evgenii

```


## ls 

`ls` - list contents of a directory. Flags:
- `-1`: one per line
- `-s`: sort by size
- `-a`, `-all`: all files including hidden ones
- `-t`: sorted by time
- `-l`: list of extended information, including permissions
- `-h`: human-readable

## find

This command searches for a specified file.

```bash
# print tree of a specified folder or root folder
find
find folderName
find dir1/dir2
# find a specific file in the current directory and its subdirectories
find -name index.html
# ... in the specified directory and its subdirectories
find path/here filename.html

# search for a file recursively
find . -name ".sqlfluff"
# you can add flag -i for case-insensitive search, like `-iname`
```

## search str

Search for a specific string in all the files in all the directories: `grep "precision" . -R`

Same but specify directories: `grep "precision" -R dirnamenumber*`

A more complex use case: 

```bash
grep -HiRE "some string|other string"
# switches used:
# -H for file printing, 
# -i for case-insensitive, 
# -R for recursive search, 
# -E for regex 
```

## misc

Let's say you have a `file.csv` file:
```csv
name,surname
John,Doe
Jane,Doe
Chris,Evans
```

Iterate row-by-row, printing one column only
```bash
cat file.csv | while IFS="," read NAME SURNAME
do
  echo SURNAME
done
```

Another function worth mentioning is opening online links:
```bash
xdg-open <http://link_here>
```

## pushd / popd



# Standard streams

One of the most important features in bash is **piping**, which sends command output to other commands. For example, 
```bash
echo "Hello there" | grep "there"
```

Output / input redirection

| Redirecting sign | Action |
| --- | --- |
| `1>` | Output stdout to file, e.g. `good_command 1> stdout.txt` |
| `2>` | Output stderror to file, e.g. `bad_command 2> stderr.txt` |
| `>` | Write to a file; redirect both stderr and stdout. If file exists, **rewrites the file** |
| `>>` | Appends to a file if exists. |
| `<` | Direct input from file on the right to the command on the left. |

Examples:
```bash
### Redirect terminal output (stdout) to a file
SomeCommand > SomeFile.txt  

### Same but append
SomeCommand >> SomeFile.txt

### If you want stderr as well use this:
SomeCommand &> SomeFile.txt  

### or this to append:
SomeCommand &>> SomeFile.txt  

###if you want to have both stderr and output displayed on the console and in a file use this:
SomeCommand 2>&1 | tee SomeFile.txt
```


**File management**:
- Create nested dirs ```mkdir -p```
- Move several files to a dir ```mv file1.txt file2.txt dirname```
- Delete dir with files ```rm -r``` or ask before delete ```rm -ri```

# Permissions

We can check permission by running `ls -l` in a directory. Each file / directory will have 10 lines associated with permissions:
- 1st character: type of entry. `-` for file, `d` for directory
- 2-4 show user permissions
- 5-7 show group permissions
- 8-10 show other permissions

Example: `-rw-r--r--`
- `r`: read
- `w`: write
- `x`: execute

The chmod command operates on the WHO-WHAT-WHICH principle:
- WHO: Who we are setting permissions for.
- WHAT: What change are we making? Are we adding or removing the permission?
- WHICH: Which of the permissions are we setting?

WHO - Main arguments for specifying for whom the permissions are set:
- `u` - user
- `g` - group
- `o` - others
- `a` - all

WHAT:
- `–` Minus sign. Removes the permission.
- `+` Plus sign. Grants the permission. The permission is added to the existing permissions. If you want to have this permission and only this permission set, use the = option, described below.
- `=` Equals sign. Sets very specific permissions, removing all the others that are not specified.

WHICH - Three main arguments for actions: 
- `r` - read: a file can be viewed and opened
- `w` - write: a file can be edited and deleted
- `x` - execute: a file can be run

Let's consider some example commands:


Let's say that we have a file with all permisions: `-rwxrwxrwx 1 root root 13 May 19 10:01 textfile.txt`

If we want for the user to be able to read, write, and execute, and for group and other - to read only, while removing all permissions that you don't explicitly specify,
you can set like this: `chmod u=rwx,og=r textfile.txt`

We can later add some extra permissions, so that the group can edit: `chmod g+w textfile.txt`

Settings permissions for multiple files: `chmod o-r *.sh`




Give permission to run an executable `chmod +x <filename>`

# Variables

Environment variables:
| Action with env vars | Command | 
| - | - |
| Print all | `printenv`, `env` |
| Print a specific one | `echo $NAME`, `printenv NAME` |
| Permanently set an env var | `nano ~/.bashrc`, then add the var value at the end: `export VAR_NAME="value"`, finally update the .bashrc file using the command: `source .bashrc` |


```bash
# Assign variables:
a="Hello"; b=22; c="${a}, I am ${b} years old!"; 

VAR1="Name"
echo $VAR1

# Assign expression to a variable via subshell
d=$(( b - 6 ))
d=$(echo $VAR | sed 's/_/-/')
var1=$(ls | wc -l)

echo "$(echo ' M e ')."

# Read user input
read VARNAME
echo "You wrote this variable: \"$VARNAME\""

# Use a variable
echo $a
echo $a more stuff
echo "${a} is the username."

# Check variables and their values
declare -p VARNAME

```
- Print number of variables passed `$#`    
- Arithmetic operation (INT-based) with the variable: `b=$(( a + 100 ))`
echo $(($var1 + 2)) # or
echo $(($(ls | wc -l) - 2))

- Give default value to a variable if a value not assigned: `VAR1="${1:-you}" `

`${1,,}` - means consider variable as lowercase.

**Environmental variables in Linux**

You can check the available environmental variables by the commands `env`, `printenv`; alternatively, print a specific env variable by `printenv NAME` or `echo $NAME`. 

To permanently assign an environmental variable, perform the following steps:
- `nano ~/.bashrc`
- At the bottom of the file, add the following line: `export NAME="value"`
- Subsequently, update the .bashrc file: `source .bashrc`

Another way to do the operation described above is by echo and append: 
```bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
```

# Data Types

## String
echo "Welcome, $1"

Slice strings: 
- `echo '((string))' | awk '{print substr($0, 3, length($0) - 4)}'`
- `v1='((string))'; echo "${v1:2:-2}"`

Concatenate string: `echo $a$b`   
In string, sort unique values `echo $a | grep -o "[a-zA-Z]" |sort|uniq| tr -d "\n\r"`

## Array

```bash
arr1=(a b c)

arr1=("a" "b" "c")

arr1=(
  "item1"
  "item2"
)

# Print the first item
echo $arr1

# Access a list's item by its index
echo ${arr1[0]}

# Print the whole array
echo ${arr1[@]} # or...
echo ${arr1[*]} # or ...
N=5
echo ${arr1[$N]}
```

## Int and float

```bash
var1=$(( 5 + 5 ))
var2=$(( $var1 + 5))

echo $(( a * b ))

x=$(( $x + 1 ))
```

Check if $factor is factor of $base: 
```if (($base%$factor == 0)); then echo "true"; else echo "false"; fi```

# Date and time
```bash
start_time=$SECONDS # Get current time in seconds
elapsed=$(( SECONDS - start_time )) # How many seconds have passed

# Get current time
now=$(date +"%FORMAT") # where FORMAT - different arguments
now=$(date +'%y/%m/%d'); echo "Today is $now"
```
date FORMAT arguments
| Argument | Function |
| --- | --- |
| `-R` | Mon, 26 Jun 2022 HH:MM:SS GMT |
| `+"%T"` | HH:MM:SS (24-hr format) |
| `+"%r"` | HH:MM:SS PM (12-hr format) |
| `+"%I:%M:%S"` | HH:MM:SS (12-hour) |
| `+'%m/%d/%Y'` | mm/dd/yyyy  |

Some interesting abilities:
```bash
cal # print calendar
```


# Regular expressions
Meta characters which need to be escaped with a backslash ```\``` : ```.[{(\^$|?*+```

| Command | Action |
| :----------- | :------------------------------------------------------------ |
| `*` | Zero or more characters. |
| `?` | Zero or one character. |
| `.` | One occurrence of a character. |
| `[abc]` | Any of the stated characters. |
| `[^abc]` | Any character NOT specified. |
| `\` | Removes special meaning of a character. |
| `|` | Logical OR operator. |
| `^X` | Character at the line start. |
| `X$` | Character at the line end. |
| `{}` | FOR loop. |
| `[[ hello =~ el ]]` | pattern matching: does "hello" contain "el"? |
| `+` | any number of character to the left of "+" |


Example: 
- Print all these files: `echo {a,b,c}.txt` or `echo {1..5}.txt`
- Expression start with "h", has at least one character after it, and ends with "d": `^h.+d$`
- Check if variable var1 ends with "?": `[[ $var1 =~ \?$ ]]`
- Is a string a number? `[[ a =~ [0-9] ]]`
- Does the string NOT consist of any number of numbers from start to end? `[[ ! 11 =~ ^[0-9]+$ ]]; echo $?`
= Ends with a question mark? `[[ $VAR =~ \?$ ]]; echo $?`


# Conditional statements and loops

`[ condition ]` and `[[ condition ]]` are interchangeable. 

> Note: you can get a manual on how to use these by running `help if`, for instance

## IF



```bash
if [[ condition ]]; then STATEMENT; fi
# or
if [[ CONDITION ]]
then
  STATEMENTS
fi

if [[ condition ]]; then STATEMENT1; elif [[ condition2 ]]; then STATEMENT2; else STATEMENT3; fi
# or
if [[ CONDITION ]]
then
  STATEMENTS
else
  STATEMENTS
fi

```



Examples:
```bash
if [ $a -eq 0 ]; then echo "a"; else echo "b"; fi
if [ $1 == "Johnny" ]; then echo "a"; else echo "$1"; fi
if [ ${1,,} == "johnny" ]; then echo "yes"; else echo "no"; fi


NUMBER=$(( RANDOM % 75 + 1 ))
TEXT="The next number is, "
if (( NUMBER <= 15 ))
then
        echo $TEXT B:$NUMBER
elif [[ $NUMBER -le 30 ]]
then
        echo $TEXT I:$NUMBER
elif (( NUMBER < 46 ))
then
        echo $TEXT N:$NUMBER
elif [[ $NUMBER -lt 61 ]]
then
        echo $TEXT G:$NUMBER
else
        echo $TEXT O:$NUMBER
fi

```



Check if directory exists: `if [ -d "Dirname" ]; then echo "Exists!"; fi`   
Create directory if it does not exist: `if [ ! -d "Dirname" ]; then mkdir Dirname; fi`   
    

## WHILE 

```bash
while [[ CONDITION ]]; do STATEMENTS; done
```

Examples:
```bash
# Print a string until you exit
while : ; do echo "Press <CTRL+C> to exit."; sleep 1; done

x=1; while [ $x -le 5 ]; do echo "Welcome $x times"; x=$(( $x + 1 )); done
```

```bash
I=$1
while [[ $I -ge 0 ]]
do
        echo $I
        (( I-- ))
done
```

## UNTIL

```bash
until [[ condition ]]; do STATEMENT; done
```

## FOR

This loop is needed to iterate for some kind of values. 

Var 1
```bash
for ((i=1; i<=10; i++)); do echo "a"; done
for ((i=10; i>0; i--)); do echo "a"; done
```
Var2
```bash
for i in {START..STOP..STEP}; do echo $i; done
# Example
for i in {1..5}; do echo $i; done
```

Print the same character N times: 
```bash
b=10; 
for i in $(seq 1 $b); do echo -n 'a'; done; echo '' 
```

Examples:
```bash
for var in "first" "second" "third"; do echo "The $var item"; done

# iterate over an array
MY_FIRST_LIST=(a b c)
for item in ${MY_FIRST_LIST[@]}; do echo -n $item | wc -c; done
```

## CASE statements

Case statements are better than if/elif/else statements when we check for multiple values.

```bash
case EXPRESSION in 
  PATTERN) STATEMENTS ;;
  PATTERN) STATEMENTS ;;
  PATTERN) STATEMENTS ;;
  *) STATEMENTS ;;
esac
```

```bash
# Check the first positional argument (in lowercase) for multiple belonging
# note the "|" OR statement
case ${1,,} in 
  boss | manager | CEO)
    echo "Hello, boss!"
    ;;
  help)
    echo "let me help you: just enter your username"
    ;;
  *)
    echo "Option not recognised. Please write your username"
esac
  
```

# Operators

Check expressions: `help test`

| Operator | Description |
| :--- | :--- |
| `-gt` | Greater than **(arithmetic operators)** |
| `-ge` | Greater or equal to |
| `-eq` | Equal to |
| `-ne` | Not equal to |
| `-le` | Less or equal to |
| `-lt` | Less than |
| `==` | Check if two strings are the same **(string operators)** |
| `!=` | Check if two strings are NOT the same |
| `=~` | Check if contains a pattern. `[[ hello =~ el ]]; echo $?` - returns 0 / true | 
| `-z` | True if length of the string is zero; `[[ -z $VAR ]]` |
| `-n` | True if length of the string is non-zero |
| `-d` | Check the existence of a directory **(file operators)** |
| `-e` | Check the existence of a file |
| `&&` | AND **(Comparison operators)** |
| `||` | OR |

```bash
# Version 1 (use $ sign to denote variables):
help [[ expression ]]
[[ CONDITION ]];
# check in the terminal
[[ hello == hello ]]; echo $?

# Version 2 (don't use $ sign to denote variables):
(( CONDITION ));
```

(( NUMBER <= 15 ))

[[ $NUMBER -le 15 ]]

```bash
# check if the file exists
[[ -a filename.ext ]]
```

`&&` - AND
`||` - OR

`((...))` - will perform a calculation or operation and output nothing. 

Use output of an expression: `echo $(( I * 2 + 4 ))`

# Function definition

`help function`

```bash
# Defining a function
# Method 1
function functName {
  echo "Hello world!"
}
# Method 2
functName() {
 echo "Hello world!"
}
# Calling this function
functName

# Functions can also use positional arguments
functName() {
  echo "Hello, $1 $2"
}
functName "John" "Wayne"
```

Here's how to return the output of the function:
```bash
my_function () {
  local func_result="some result"
  echo "$func_result"
  # can also use `return`
}

func_result="$(my_function)"
```



# Encoding

```bash
# check file encoding
file -bi file.txt
# change file encoding
iconv -f utf-16le -t UTF-8 file.txt -o file_proc.txt
```

# Main commands

Get all commands: `help`

`<command> --help`

`man <command>`

## Running jobs
- Run a job in the background ```sleep 50 &```
- Check jobs in the background ```jobs```
- Terminate background job ID=2 ```kill %2```

<hr />

## Processing data and pipelines

### Pipes

```bash
# Display unique lines in a file
cat filename | sort | uniq
```

### AWK

AWK is a powerful text-processing tool in Bash scripting that allows for pattern scanning and processing data.

- Operators: 
  - AND ```$$```
  - OR ```||```
- Print columns 1 and 2 ```awk '{print $1,$2}' file.txt```
- Print rows when column 3 == "expr" (no whitespaces present) ```awk '$3 == "expr"'``` or ```awk '{if ($3 == "expr") print $0;}'```
- Print column 1 if its length is 1 ```awk 'length($1) == 1 {print $1}' filename.txt```
- Print column 1 (delim = ,) ```awk -F, '{print $1}' file.txt```
- Print column 3 (delim = \t) ```awk -F"\t" '{print $3}' file.txt``` 
- Print line if the value of column 5 is <= 100 ```awk '$5<=100 {print}' file.txt```
- Concatenate multiple columns ```awk -F"\t" '{print "## " $1 " -- " $4 "_END"}' file.txt```
- In a file containing spaces, with primary delim = \t, print rows where column4 == 99 
  - ```awk 'BEGIN{FS="\t"} $4 == "99"' file.txt``` 
  - or, if two conditions ```awk 'BEGIN{FS="\t"} $4 == "99" $$ $5 == "99"' file.txt``` or ```awk -F"\t" '{if ($4 == "99" && $5 == "99") print $0;}' newfile.txt```
- Rearrange the order of columns in a file ```awk 'BEGIN {FS=OFS="\t"} {print $3, $1, $5}' newfile.txt >newfile_proc.txt```
- Print column 1, replacing all colons by semicolons ```awk 'BEGIN{FS=OFS="\t"} {gsub(/\:/, ";", $1)} 1' file.txt``` or ```awk -F "\t" '{gsub(/\:/,";",$1);print $1"\t"$2"\t"$3}' file.txt```


### CAT

Concatenates and displays the content of files.

- Concatenate several files into one ```cat file1 file2 > file3```
- Concatenate all .tsv files in the current dir into one ```cat *.tsv >> output.tsv```

### CUT

Removes sections from lines of files.

- Print column 7  ```cut -f 7 input.txt``` 
- Print columns 1, 2  ```cut -f 1,2 input.txt``` or ```cut -f 1-2 input.txt``` 
- Print column 3 and up  ```cut -f 3- input.txt```

### SED

Performs find-and-replace operations, substitutions, deletions, and more on text files or input streams. 

A stream editor for bash. Can be used either with a file (`sed <command> <file>`) or from a printed text (`cat <file> | sed <command>`)

Main commands:

```bash
######################################################################
#####   PRINT   ######################################################
######################################################################
### Print a specified line
sed -n 2p file.txt #or
sed -n '2p' file.txt
### Print several lines, e.g. line 1 and line 3 only
sed -n '1p;3p' file.txt
### Print from line 1 to line 3
sed -n '2,3p' file.txt
### Print lines starting from 1 with step of 2 lines
sed -n '1~2p' file.txt

######################################################################
#####   DELETE   #####################################################
######################################################################
# If you want to delete inplace, add a flag `-i`
### Delete line 7
sed '7d' file.txt
### Delete lines 7 to 9 inclusive
sed '7,9d' file.txt

######################################################################
#####   SUBSTITUTE   #################################################
######################################################################
# Pattern substitution command. Supports regex. 
# First argument: s - substitute
# Last argument: g - global (all occurrences)
# Slash is the default separating symbol, but any other symbol can be used. E.g., sed 's|1|5|g', sed 's%1%5%g', etc.
### Replace pattern 1 with pattern 2 (all occurrences)
sed 's/pattern 1/pattern 2/g' file.txt
### Remove all spaces in a string
sed 's/ //g' file.txt
### Replace delim '\t' with ';'
sed 's/\t/;/g' file.txt
### Replace multiple patterns
sed 's/pattern 1/replace 1/; s/pattern 2/replace 2/'
### Remove first 5 characters from each line
sed 's/^.\{5\}//g'

### Replace 1st occurrence only
sed -z 's/pattern 1/pattern 2/1' file.txt
### Replace 5th occurrence only
sed -z 's/pattern 1/pattern 2/5' file.txt

### Replace pattern ("equal" sign, then a sequence of any length of letters, numbers, or dots) with nothing
cat file1.txt | sed -r 's/=[0-9.a-zA-Z]+//g' > file2.txt
```



`SED` can be used with regex:
```bash
echo "$(echo '   M e ' | sed 's/^ *//g' )." # Remove all leading spaces
echo "$(echo '   M e   ' | sed 's/ *$//g' )." # Remove all trailing spaces
echo "$(echo '   M e   ' | sed -r 's/^ *| *$//g' )." # Do both 
```
Replace SED flags:
- `-g`: regex flag = replace all instances of a pattern
- `-i`: ignore the case of a pattern
- `-r`: use extended regexp, such as "+"


### SORT

Sorts lines in text files.

- Randomly shuffle 10 non-repeating sample items ```shuf -n 10 input.txt``` or ```sort --random-sort input.txt```
- Sort by col3, then by col4 ```sort -k3 -k4 file.txt```
- Flags for ```sort```:
  - -u: sort and print unique lines
  - -V: sort alphanumerically - numbers, then letters
  - -r: reverse sort
  - -n: numerical sort (10, then 100)
  - -t: choose a delimiter

Read data starting from the second row (removing header row) and sorting by the third column in the file:
```bash
tail -n +2 filename.csv | sort -t, -k3,3n > sorted_filename.csv
```

### UNIQ

Removes duplicate lines from a sorted file.

- Remove replciates from sorted data, leaving only unique values ```uniq```
- Flags:
  - -c: with counts
  - -u: only unique lines
  - -d: only duplicates

### HEAD, TAIL

View contents of a file:

Option 1: With `HEAD`: `head [option] [file]`

**Options**:
```bash
# Print out first 10 lines
-n 3
# Exclude the last 3 lines
-n -15
# Print the first 10 characters
-c 10
```

Option 2: With `TAIL`

General syntax: `tail [option] [file]`

**Options**:
```bash
# Print out the last 3 lines
-n 3
# Print lines after a specific line
-n +17
# Print the last 10 characters
-c 10
```

Option 3: `more <filename>`

General syntax: `head [option] [file]`


## Compression

Main types of archives: `.gz`, `.tar.gz`, `.zip`, `.7z`

| Compression algorithm model | Description | Pack | Unpack |
| - | - | - | - |
| `.gz` | **Archive**. Archives only individual files, never a directory. Uses less memory / is fast for compression / decompression, but compresses less memory-wise. *Note: .gz and .gzip can both be used, but .gz is a much more conventional extension to use.* | `gzip example.fasta`, `gzip -k filename.txt` | `gunzip example.fasta.gz` |
| `.tar` | **Container**. Utility `tar` containerises a folder. Usually, that container is then archived with `gzip` to get an archive `.tar.gz` | `tar -czvf example.tar.gz folder_name`, `tar -czvf example.tar.gz file1.txt file2.txt file3.txt` | `tar -xzvf example.tar.gz` |
| `.tar.gz` | | | Extract a .tar.gz file with verbose ```tar -xvf archive.tar.gz``` |
| `.zip` | **Archive**. Algorithm that is highly portable across OS's.  | Zip all files in the current directory: `zip archivename.zip *` <br> Zip all files in a specified directory: `zip example.zip folder_name/*` <br> Zip a directory: `zip -r output.zip inputDir` <br> Zip multiple files: `zip zipped.zip file1.txt file2.txt file3.txt` | `unzip example.zip` |
| `.7z` | Compresses more space-wise, but uses more memory / runtime to compress / decompress. Install with `sudo apt-get install p7zip-full` | `7z a output.7z directory-or-file-to-archive` | |
| `.tgz` | tar gzip | | `tar xzf housing.tgz` |


## CP
- Copy multiple files to a dir ```cp {file1,file2,file3}.txt dir```

Copy a directory to the parent directory: ```cp -r dirname ..```

- Flags:
  - -v: with verbose

## CURL

```bash
# GET request
curl -X 'GET' https://api-project1-efbh.onrender.com/random_quote
```

Flags:
- `-X`: Allows you to specify the request type. In this case it is a POST request.
- `-d`: Stands for data and allows you to attach data to the request.
- `-H`: Stands for Headers and it allows you to pass additional information through the request. In this case it is used to the tell the server that the data is sent in a JSON format.
- `-s`, `--silent`: do not show progress meter or progress bar

## ECHO_PRINTF

```bash
echo Hello World
echo "Hello, world!"

# Print multiple lines
echo "asdf
asdf"

# Use a variable
echo "Home current user is: $HOME"

# Use an output of a function
a="file.txt"
echo "The file $a has $(wc -l < $a) lines"
```

Flags for ECHO:   
| Flag | Action |
| :--- | :--- |
| `-e` | Interpret newlines, e.g. `echo -e "\ntext\n"` |
| `-n` | Do not output the trailing newline. |
| `for i in {1..75}; do echo -n "-"; done` | Print header line in Linux |


PRINTF: echo but without newline. 

## FIND

`find` command is used to search directories for files. 

`find` - view the file tree from the current directory. 

| Flag | Function |
| --- | --- |
| `-name` | Search for the specific file / directory, e.g. `find -name index.html` |

Some examples of use:
```bash
### Remove all zero-byte files from the filesystem
!find /tmp/data/ -size 0 -exec rm {} +
### removes any file that does not have a .jpg extension
!find /tmp/data/ -type f ! -name "*.jpg" -exec rm {} +
```

## GREP

Flags:

| Flag | Meaning |
| - | - |
| `-i`      | ignore case |
| `-c`      | print line count |
| `-v`      | lines that don't contain ... |
| `-n`      | specified line number in which the query was found |
| `-nC`     |  1: prints 1 line before and after the matching line |
| `-r`      | recursive search (e.g. in a directory), case-sensitive |
| `-E`      | **allows to use extended regexp** |
| `-o`      | matches more than once per each line |
| `--color` | color matches within lines |

Command: `grep "<pattern>" <file>`

Examples: 
```bash

# Print lines with 'h' at the start of the line 
grep "^h" file.txt

# Print lines containing one of the specified substring
grep -iE "string1|string2" 
# Print lines containing one letter within A-Z 
grep -w "[A-Z]" input.txt
# Print lines containing one letter within A-Z at start of line 
grep "^[A-Z]" input.txt
# Print lines containing string with a letter at the end 
grep -E "string[a-z]" file.txt
# Search words that start with dog or woof
grep 'dog[a-z]* | woof[a-z]*'

# Search for a string in each file in a directory
grep -r 'string1' directory1
# Search for a string in the current directory
grep -r 'string1' .
# same but case-insensitive and check 2 lines before and 2 lines after the match; also don't show binary file matches
grep -ri -B 2 -A 2 "unittest" .

# Save to another file all lines from the original file that do not match the pattern
cat conda-env1.yml | grep -vE "pywin32|vs2015_runtime|- vc=" > conda-env2.yml
```

## RANDOM

Internal BASH function (or a BASH environment variable), returns a pseudorandom integer in the range 0 - 32767.

`echo $(( RANDOM % 4 ))` # Generate a random integer from 0 to 3 inclusive. 
`echo $(( RANDOM % 4 + 1 ))` # Genearte a random integer from 1 to 3 inclusive

`N=$(( RANDOM % 4 ))` 

## RENAME
- Flags: 
  - -n: check which actions will be taken without taking them (mock)
  - -v: verbose
- Rename a file ```rename 's/oldname/newname/' file```
- Change extension in all .txt files ```rename 's/.txt$/.csv/' *.txt``` or same but deliberately escaping special symbols ```rename -n 's/\.txt$/\.csv/' *.txt
- Replace all spaces with underscores in all .txt files (with a global modifier) ```rename 's/ /_/g' *.txt```
- In .txt files, change name ```rename 's/my_file/file/' *.txt```

## SCREEN
- Create a parallel session ```screen```
- Exit a screen ```ctrl + A```, then ```D```
- Show screens ```screen -ls```
- Go to screen ```screen -r```
- Name a screen ```screen -S name```
- Kill ```screen -X -S [session # you want to kill] kill```




## SHUF
- Get N random lines `shuf -n N input >output`

## TMUX

Tmux is a terminal multiplexer 
Programa para dejar terminal abierto. 

Tmux handles the processes as sessions. These sessions will continue running even if your connection to the terminal closes. 
```bash
### Create new session 
tmux new -s <session_name>
### Check sessions
tmux ls
tmux list-sessions
### Then you can close terminal, to return to the terminal 
tmux attach -t <session_name>
### leave / detach from session (minimise terminal) 
tmux detach
# `ctrl + b`, then `d`
### Rename a session
tmux rename-session [-t current-name] [new-name]
### Close the session (delete session) 
tmux kill-session -t <name>

```

## TR
- Trim delete newlines ```tr -d '\n\r'```
- Trim carriage returns "\r" `tr -d '\r'`

## TREE

https://www.cyberciti.biz/faq/linux-show-directory-structure-command-line/

The syntax is as follows: `tree [options]`

```bash
### List directories only
tree -d
```

```txt
  ------- Listing options -------
  -a            All files are listed.
  -d            List directories only.
  -l            Follow symbolic links like directories.
  -f            Print the full path prefix for each file.
  -x            Stay on current filesystem only.
  -L level      Descend only level directories deep.
  -R            Rerun tree when max dir level reached.
  -P pattern    List only those files that match the pattern given.
  -I pattern    Do not list files that match the given pattern.
  --ignore-case Ignore case when pattern matching.
  --matchdirs   Include directory names in -P pattern matching.
  --noreport    Turn off file/directory count at end of tree listing.
  --charset X   Use charset X for terminal/HTML and indentation line output.
  --filelimit # Do not descend dirs with more than # files in them.
  --timefmt <f> Print and format time according to the format <f>.
  -o filename   Output to file instead of stdout.
  -------- File options ---------
  -q            Print non-printable characters as '?'.
  -N            Print non-printable characters as is.
  -Q            Quote filenames with double quotes.
  -p            Print the protections for each file.
  -u            Displays file owner or UID number.
  -g            Displays file group owner or GID number.
  -s            Print the size in bytes of each file.
  -h            Print the size in a more human readable way.
  --si          Like -h, but use in SI units (powers of 1000).
  -D            Print the date of last modification or (-c) status change.
  -F            Appends '/', '=', '*', '@', '|' or '>' as per ls -F.
  --inodes      Print inode number of each file.
  --device      Print device ID number to which each file belongs.
  ------- Sorting options -------
  -v            Sort files alphanumerically by version.
  -t            Sort files by last modification time.
  -c            Sort files by last status change time.
  -U            Leave files unsorted.
  -r            Reverse the order of the sort.
  --dirsfirst   List directories before files (-U disables).
  --sort X      Select sort: name,version,size,mtime,ctime.
  ------- Graphics options ------
  -i            Don't print indentation lines.
  -A            Print ANSI lines graphic indentation lines.
  -S            Print with CP437 (console) graphics indentation lines.
  -n            Turn colorization off always (-C overrides).
  -C            Turn colorization on always.
  ------- XML/HTML/JSON options -------
  -X            Prints out an XML representation of the tree.
  -J            Prints out an JSON representation of the tree.
  -H baseHREF   Prints out HTML format with baseHREF as top directory.
  -T string     Replace the default HTML title and H1 header with string.
  --nolinks     Turn off hyperlinks in HTML output.
  ---- Miscellaneous options ----
  --version     Print version and exit.
  --help        Print usage and this help message and exit.
  --            Options processing terminator.
```

## WC
- Flags:
  - -l: number of lines
  - -w: number of words
  - -c: number of bytes
  - -m: number of characters
  - -L: prints only length of the longest line
  - -X: print number of lines, words, byte count

```bash
### How many lines does a file have?
wc -l file.txt
wc -l < file.txt # returns only the number
```

## WGET

Downloads files. 

```wget <link>```

Flags:
- Save the file in a certain name: `-O filename.txt`


## XARGS
- Use output of file.txt as args in function 'rm' ```cat file.txt | xargs rm```
- ```find . -size +1M | xargs ls -lh```

## CRON

Allows scheduling tasks (cron jobs) to run automatically at specific times / days. 

```bash
# View your current cron jobs
crontab -l
# Edit your cron jobs
crontab -e
# Run crontab for a different user
crontab -u root -l  # or
sudo crontab -u root -l
```

A cron job is defined by a line in the crontab file, which consists of six fields. Here's an example of a crontab file:
```txt
# .---------------- minute (0-59)
# | .-------------- hour (0-23)
# | | .------------ day of month (1-31)
# | | | .---------- month (1-12) OR jan, feb, mar, apr
# | | | | .-------- day of week (0-6, where 0=Sunday, 1=Monday, etc.) OR sun, mon, tue, wed, thu, fri, sat
# | | | | |
# * * * * * command to be executed

# Run this command every minute of every day
* * * * * echo 'Hello' >> /tmp/test.txt
* * * * * date >> /path/to/test.txt

# Run every 30 min of every hour, e.g. 11:30, 12:30, 13:30, etc.
30 * * * * echo 'Hello' >> /tmp/test.txt

# Run every day at 5:30
30 5 * * * command

# Run on the first of every month at 5:30
30 5 1 * * command

# Run on the first month (January) first day of the month (1st) at 5:30
30 5 1 1 * command

# Every monday at midnight
0 0 * * 1 command

# At 11:03 every day of the month, every month, every day of the week, run this command
# 03 11 * * * echo "this is a test" > /full/path/to/file.txt

# A cronjob that runs every hour
# @daily, @weekly, @monthly
@hourly /usr/bin/echo "this is a test" >> /full/path/test.txt
```


Each field can be an asterisk (which means any value), a single value, a range of values, or a list of values or ranges separated by commas.

Here’s an example of a cron job that runs a script every day at 2:30 PM:
`30 14 * * * /home/user/data_script.sh`

This line specifies that the `data_script.sh` script, located in `/home/user/`, should run at minute 30 of hour 14 (2:30 PM) every day.

By default, the output from a cron job is mailed to the owner of the crontab file. However, you can redirect the output to a file:
`30 14 * * * /home/user/data_script.sh > /home/user/data_log.txt`

In this example, the output of `data_script.sh` is redirected to `data_log.txt`.

Example: 

You have a Python script called data_update.py that updates your data every week. The script is located in the /home/data_scientist/ directory. How would you schedule a cron job to run this script every Monday at 1:30 AM?

Answer: run `crontab -e`, then `30 1 * * 1 /usr/bin/python3 /home/data_scientist/data_update.py`



# Workload managers
- PBS
  - Push bash script to queue ```qsub script.sh```
  - Check queue ```qstat```
- Slurm
  - Push bash script to queue ```sbatch script.sh```
  - Check queue ```squeue```

# Bioinformatics commands
- Take VCF file and output the most commonly-encountered REF nucleotide ```sed '/##/d' input.vcf | awk '{print $1, $4}' | grep "^15" | awk '{print$2}' | grep -w "[A-Z]" | sort | uniq -c | sort -r | head -1```
- Convert Fastq to Fasta ```cat input.fastq | paste - - - - | sed 's/^@/>/g' | cut -f1-2 | tr '\t' '\n'``` or ```sed -n '1~4s/^@/>/p;2~4p' input.fastq > output.fasta```
- Download multiple .fasta files from the uniprot website by their ID given in a text file ```for i in $(cat fasta_list.txt | tr -d '\r'); do wget "https://www.uniprot.org/uniprot/$i.fasta"; done```
  - Here, fasta list looks like this: P94485 \n Q7CPU9 \n Q802Y8
  - Note: the script removes the cryptic newline '\r' from the end of each line

# BASH scripting

Show location of bash: `which bash`

Each bash script should start with a shebang: `#!<path_to_interpreter>`. Shebang tells how to execute the following script, with what shell
- Normally / most oftenly, it looks like this: `#!/bin/bash`. It means that the current script should be executed using Bash shell; however, by including this shebang, you make sure that the script is run using the correct shell, regardless of the system's default shell;

Example of an elementary Bash script - `script.sh`:
```bash
#!/bin/bash
# This is a comment
echo "Hello, world!"
```

Bash script can be run by two commands:
- Using the `bash` command: `bash script.sh`
- Script can be made directly executable by `chmod +x script.sh`, then can be run like: `./script.sh`

Print all arguments passed to the scriplt `$*`

- Concatenate a string: ```var1="I really enjoy"; var1+="programming"``` or ```var1="I really"; var2=" prog"; var3="${var1} enjoy ${var2}"```
- Debug script: 
  - Debug ```set -x```
  - Prohibits overwriting existing regular files ``` set -C```
- Slicing a string ```echo "string1" | cut -c1-3``` 


## Error handling

**Make the bash script stop executing subsequent line if there is an error**:
- Either add in the bash script `set -e`
- Or run the script like this: `bash -e my_script.sh`

Additionally, you can start your script like this:

```bash
#!/bin/bash
set -e

on_exit() {
  echo "error!!!"
}
trap on_exit ERR

# the body of the program here
```
