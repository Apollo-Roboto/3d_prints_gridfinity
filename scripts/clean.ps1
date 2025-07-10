function Remove($path) {
    if (Test-Path $path) {
        Write-Host "Removing $path";
        Remove-Item $path;
    }
}

Remove ".ruff_cache";

$pycache_folders = get-ChildItem -Filter __pycache__ -Recurse -Directory
foreach($folder in $pycache_folders) {
    Remove $folder;
}

$project_folders = Get-ChildItem -Directory | Where-Object {$_.Name -match '^[a-z0-9_]+$'};
foreach($folder in $project_folders) {

    Push-Location $folder;

    $files = Get-ChildItem -File | Where-Object {$_.Name -match '^gridfinity_.+\.(blend[0-9]+|[0-9-]+\.FCBak)$'};

    foreach($file in $files) {
        Remove $file;
    }
    Pop-Location;
}
