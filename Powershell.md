
# Powershell

# General

`systeminfo` - get info about the computer's software and hardware.

By default, Powershell has running scripts disabled. To enable running scripts, open Powershell as Administrator and run the following command:
```powershell
Set-ExecutionPolicy RemoteSigned
```

Basic commands: 
```powershell
# Open a directory in File Explorer based on path
Invoke-Item -Path "C:\Users\your-username-here\AppData\Local\Programs\Python\Launcher\"

# Determine the origin of a command in Powershell, i.e. where is it located
Get-Command python
```

## Users

```powershell
### Print all users
Get-LocalUser
### Get all info for a specific user
Get-LocalUser -Name "Data Science" | select *
```

## Environment variables

**Environment variables (Powershell)**

```powershell
# List all environment variables
Get-ChildItem Env:
# Print a specific environment variable
echo $Env:EMAIL_USER # or $Env:EMAIL_USER

# Print all PATH variables
$Env:Path # or `$env:Path`
$Env:Path -split ';'

# Set an env var:
[Environment]::SetEnvironmentVariable("variable_name","variable_value","User")
### Then, reopen the terminal
```

**Environment variables (GUI)**

You can set environment variable in GUI by following the following steps:
- Win+R
- `sysdm.cpl`
- "Advanced" tab
- "Environment Variables"
- "New"
- Define a variable


# Text editing

```powershell
pip freeze | Select-String -Pattern "pandas|numpy|matplotlib|seaborn|tensorflow" > requirements.txt
```
