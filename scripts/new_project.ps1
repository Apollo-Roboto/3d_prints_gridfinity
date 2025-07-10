param (
    [string]$name
)

function ConvertTo-LowerCase() {
    param (
        [string]$text
    )

    $cleaned = ($text.ToLower() -replace '[^a-z0-9_]', '_') -replace '_+', '_' -replace '(^_|_$)', ''

    return $cleaned
}


$snake_case_name = ConvertTo-LowerCase "$name"

# Copy the template folder
Copy-Item -Recurse .\templates\ ".\$snake_case_name\"

# Rename the work files
Move-Item ".\$snake_case_name\gridfinity_templates.blend" ".\$snake_case_name\gridfinity_$snake_case_name.blend"
Move-Item ".\$snake_case_name\gridfinity_templates.FCStd" ".\$snake_case_name\gridfinity_$snake_case_name.FCStd"

# Rewrite the first line of the readme file
$readme_content = Get-Content ".\$snake_case_name\readme.md" | Select-Object -Skip 1
.{
    "# $name"
    $readme_content
} |
Set-Content ".\$snake_case_name\readme.md"
