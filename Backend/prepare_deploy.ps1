# Create deployment directory
$deployDir = "temp_deploy"
if (Test-Path $deployDir) {
    Remove-Item -Path $deployDir -Recurse -Force
}
New-Item -Path $deployDir -ItemType Directory

# Copy essential files and directories
Copy-Item -Path "manage.py" -Destination $deployDir
Copy-Item -Path "Procfile" -Destination $deployDir
Copy-Item -Path "requirements.txt" -Destination $deployDir
Copy-Item -Path "runtime.txt" -Destination $deployDir
Copy-Item -Path ".slugignore" -Destination $deployDir
Copy-Item -Path "VisAutoML" -Destination $deployDir -Recurse
Copy-Item -Path "machine_learning" -Destination $deployDir -Recurse -Exclude "*.joblib", "*.csv", "*.png", "*.jpg", "*.jpeg", "*.gif", "static/*"

# Create minimal static directory structure
New-Item -Path "$deployDir/machine_learning/static" -ItemType Directory -Force

# Create a new git repository
Set-Location $deployDir
git init
git add .
git commit -m "Initial Heroku deployment"

# Add Heroku remote
heroku git:remote -a vis-automl

# Push to Heroku
git push heroku master -f

# Return to original directory
Set-Location .. 