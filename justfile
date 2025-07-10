set shell := ["powershell.exe", "-c"]

default:
    @just --list --unsorted

# Create a new project
new NAME:
    ./scripts/new_project.ps1 -Name "{{NAME}}"

# Check the project's conventions
check:
    python -m pathschema .pathschema .

# Remove temporary files
clean:
    ./scripts/clean.ps1
