# Remove large files and directories
Write-Host "Removing large files and directories..."

# Remove large binary files
Get-ChildItem -Path . -Include *.joblib,*.pkl,*.h5,*.hdf5,*.model,*.bin,*.csv,*.zip,*.tar.gz,*.gz,*.rar,*.7z,*.pdf,*.png,*.jpg,*.jpeg,*.gif,*.mp4,*.webp,*.webm,*.mov,*.avi,*.mp3,*.wav,*.ogg,*.flac,*.tiff,*.tif,*.bmp,*.ico,*.svg,*.psd,*.ai,*.eps,*.indd,*.raw,*.cr2,*.nef,*.orf,*.sr2,*.yaml -Recurse -Force | Remove-Item -Force

# Remove specific large directories
$largeDirectories = @(
    "machine_learning/static",
    "database",
    "models",
    "img"
)

foreach ($dir in $largeDirectories) {
    if (Test-Path $dir) {
        Write-Host "Removing $dir..."
        Remove-Item -Path $dir -Recurse -Force
    }
}

# Create empty directories for static files
New-Item -Path "machine_learning/static" -ItemType Directory -Force

# Remove database file
if (Test-Path "db.sqlite3") {
    Remove-Item -Path "db.sqlite3" -Force
}

Write-Host "Repository cleaned for deployment!" 