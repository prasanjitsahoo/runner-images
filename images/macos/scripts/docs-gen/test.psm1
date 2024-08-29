# Example input path
$inputPath = "/Applications/Xcode_16_beta_5.app"

# Extract the base name of the app from the Path property
$baseName = [System.IO.Path]::GetFileNameWithoutExtension($inputPath)

# Remove the "_beta" suffix from the base name
$newBaseName = $baseName -replace '_beta', ''

# Construct the new path
$symlinks = "/Applications/${newBaseName}.app"

# Output the original path and the symlink path
Write-Output "Original Path: $inputPath"
Write-Output "Symlink Path: $symlinkPath"

# Check if the symlink already exists
if (Test-Path $symlinkPath) {
    Write-Output "Symlink already exists: $symlinkPath"
} else {
    # Create the symlink
    New-Item -ItemType SymbolicLink -Path $symlinkPath -Target $inputPath
    Write-Output "Symlink created: $symlinkPath -> $inputPath"
}



# Process and sort the Xcode version information
$xcodeList = $xcodeInfo.Values | ForEach-Object { $_.VersionInfo } | Sort-Object $sortRules

return $xcodeList | ForEach-Object {
    # Determine the postfixes for default and beta versions
    $defaultPostfix = if ($_.IsDefault) { " (default)" } else { "" }
    $betaPostfix = if ($_.IsStable) { "" } else { " (beta)" }

    # Example input path from the current Xcode VersionInfo
    $inputPath = $_.Path

    # Extract the base name of the app from the Path property
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($inputPath)

    # Remove the "_beta" suffix from the base name
    $newBaseName = $baseName -replace '_beta', ''

    # Construct the new path
    $symlinkPath = "/Applications/${newBaseName}.app"

    # Output the original path and the symlink path
    Write-Output "Original Path: $inputPath"
    Write-Output "Symlink Path: $symlinkPath"

    # Check if the symlink already exists
    if (Test-Path $symlinkPath) {
        Write-Output "Symlink already exists: $symlinkPath"
    } else {
        # Create the symlink
        New-Item -ItemType SymbolicLink -Path $symlinkPath -Target $inputPath
        Write-Output "Symlink created: $symlinkPath -> $inputPath"
    }

    # Create and return a custom object with the desired properties
    [PSCustomObject]@{
        Version = $_.Version.ToString() + $betaPostfix + $defaultPostfix
        Build = $_.Build
        Path = $_.Path
        SymlinkPath = $symlinkPath
    }
}




$xcodeList = $xcodeInfo.Values | ForEach-Object { $_.VersionInfo } | Sort-Object $sortRules
return $xcodeList | ForEach-Object {
    $defaultPostfix = If ($_.IsDefault) { " (default)" } else { "" }
    $betaPostfix = If ($_.IsStable) { "" } else { " (beta)" }
    
   # Extract the base name of the app from the Path property
   $baseName = [System.IO.Path]::GetFileNameWithoutExtension($_.Path)
   # Remove the "_beta" suffix from the base name
   $newBaseName = $baseName -replace '_beta', ''
   # Extract version numbers
   if ($newBaseName -match 'Xcode_(\d+)_?(\d*)') {
    $majorVersion = $matches[1]
    $minorVersion = if ($matches[2]) { $matches[2] } else { "0" }
    $version = "$majorVersion.$minorVersion"
   } else {
    $version = "Unknown"
}

# Construct the new symlink path with ".0" for missing minor version
$symlinkPath = "/Applications/Xcode_${majorVersion}.0.app"

   # Create and return a custom object with the desired properties
   [PSCustomObject]@{
       Version = $_.Version.ToString() + $betaPostfix + $defaultPostfix
       Build = $_.Build
       Path = $_.Path
       SymlinkPath = $symlinkPath
   }
}


# Sample path for demonstration
$appPath = "/Applications/Xcode_16_beta_5.app"

# Extract the base name and remove "_beta" suffix
$baseName = [System.IO.Path]::GetFileNameWithoutExtension($appPath)
$newBaseName = $baseName -replace '_beta', ''

# Extract version numbers
if ($newBaseName -match 'Xcode_(\d+)_?(\d*)') {
    $majorVersion = $matches[1]
    $minorVersion = if ($matches[2]) { $matches[2] } else { "0" }
    $version = "$majorVersion.$minorVersion"
} else {
    $version = "Unknown"
}

# Construct the new symlink path with ".0" for missing minor version
$symlinkPath = "/Applications/Xcode_${majorVersion}.0.app"

# Determine postfixes
$defaultPostfix = if ($true) { " (default)" } else { "" }  # Example, adjust logic as needed
$betaPostfix = if ($baseName -like "*_beta*") { " (beta)" } else { "" }

# Output the results
[PSCustomObject]@{
    Version = "$version$betaPostfix"
    Build = "ExampleBuildNumber"  # Replace with actual logic to extract build number
    Path = $appPath
    SymlinkPath = $symlinkPath
}





# Process and sort the Xcode version information
$xcodeList = $xcodeInfo.Values | ForEach-Object { $_.VersionInfo } | Sort-Object $sortRules

return $xcodeList | ForEach-Object {
    # Determine the postfixes for default and beta versions
    $defaultPostfix = if ($_.IsDefault) { " (default)" } else { "" }
    $betaPostfix = if ($_.IsStable) { "" } else { " (beta)" }

    # Example input path from the current Xcode VersionInfo
    $inputPath = $_.Path

    # Extract the base name of the app from the Path property
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($inputPath)

    # Determine the new base name based on suffixes
    $newBaseName = if ($baseName -match '_beta_\d+$') {
        # Handle paths like 'Xcode_16_beta_5.app'
        $baseName -replace '_beta_\d+$', ''
        
    } elseif ($baseName -match '_beta$') {
        # Handle paths like 'Xcode_16_beta.app'
        $baseName -replace '_beta$', ''
    } else {
        # Handle cases where no '_beta' suffix needs to be removed
        $baseName
    }

    # Construct the symlink path
    $symlinkPath = "/Applications/${newBaseName}.app"

    # Output the original path and the symlink path
    Write-Output "Original Path: $inputPath"
    Write-Output "Symlink Path: $symlinkPath"

    # Check if the symlink already exists
    if (Test-Path $symlinkPath) {
        Write-Output "Symlink already exists: $symlinkPath"
    } else {
        # Create the symlink
        New-Item -ItemType SymbolicLink -Path $symlinkPath -Target $inputPath
        Write-Output "Symlink created: $symlinkPath -> $inputPath"
    }

    # Create and return a custom object with the desired properties
    [PSCustomObject]@{
        Version = $_.Version.ToString() + $betaPostfix + $defaultPostfix
        Build = $_.Build
        Path = $_.Path
        SymlinkPath = $symlinkPath
    }
}



# Declare the global variable for symlinkPath
$Global:symlinkPath = ""

# Process and sort the Xcode version information
$xcodeList = $xcodeInfo.Values | ForEach-Object { $_.VersionInfo } | Sort-Object $sortRules

return $xcodeList | ForEach-Object {
    # Determine the postfixes for default and beta versions
    $defaultPostfix = if ($_.IsDefault) { " (default)" } else { "" }
    $betaPostfix = if ($_.IsStable) { "" } else { " (beta)" }

    # Example input path from the current Xcode VersionInfo
    $inputPath = $_.Path

    # Extract the base name of the app from the Path property
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($inputPath)

    # Determine the new base name based on suffixes
    $newBaseName = if ($baseName -match '_beta_\d+$') {
        # Handle paths like 'Xcode_16_beta_5.app'
        $baseName -replace '_beta_\d+$', ''
        $Global:symlinkPath = "/Applications/${newBaseName}.0.app"
    } elseif ($baseName -match '_beta$') {
        # Handle paths like 'Xcode_16_beta.app'
        $baseName -replace '_beta$', ''
        $Global:symlinkPath = "/Applications/${newBaseName}.app"
    } else {
        # Handle cases where no '_beta' suffix needs to be removed
        $baseName
    }

   # Output the original path and the symlink path
    Write-Output "Original Path: $inputPath"
    Write-Output "Symlink Path: $Global:symlinkPath"

    # Check if the symlink already exists
    if (Test-Path $Global:symlinkPath) {
        Write-Output "Symlink already exists: $Global:symlinkPath"
    } else {
        # Create the symlink
        New-Item -ItemType SymbolicLink -Path $Global:symlinkPath -Target $inputPath
        Write-Output "Symlink created: $Global:symlinkPath -> $inputPath"
    }

    # Create and return a custom object with the desired properties
    [PSCustomObject]@{
        Version = $_.Version.ToString() + $betaPostfix + $defaultPostfix
        Build = $_.Build
        Path = $_.Path
        SymlinkPath = $Global:symlinkPath
    }
}




 # Construct the global symlink path
    #$Global:symlinkPath = "/Applications/${newBaseName}.app"


# Declare the global variable for symlinkPath
$Global:symlinkPath = ""

# Process and sort the Xcode version information
$xcodeList = $xcodeInfo.Values | ForEach-Object { $_.VersionInfo } | Sort-Object $sortRules

return $xcodeList | ForEach-Object {
    # Determine the postfixes for default and beta versions
    $defaultPostfix = if ($_.IsDefault) { " (default)" } else { "" }
    $betaPostfix = if ($_.IsStable) { "" } else { " (beta)" }

    # Example input path from the current Xcode VersionInfo
    $inputPath = $_.Path

    # Extract the base name of the app from the Path property
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($inputPath)

    # Determine the new base name based on suffixes
    $newBaseName = if ($baseName -match '_beta_\d+$') {
        # Handle paths like 'Xcode_16_beta_5.app'
        $baseName -replace '_beta_\d+$', ''
        $Global:symlinkPath = "/Applications/${newBaseName}.0.app"
    } elseif ($baseName -match '_beta$') {
        # Handle paths like 'Xcode_16_beta.app'
        $baseName -replace '_beta$', ''
        $Global:symlinkPath = "/Applications/${newBaseName}.app"
    } else {
        # Handle cases where no '_beta' suffix needs to be removed
        $baseName
        $Global:symlinkPath = "/Applications/${baseName}.app" # Ensure this path is set for non-beta cases
    }

    # Output the original path and the symlink path
    Write-Output "Original Path: $inputPath"
    Write-Output "Symlink Path: $Global:symlinkPath"

    # Check if the symlink already exists
    if (Test-Path $Global:symlinkPath) {
        Write-Output "Symlink already exists: $Global:symlinkPath"
    } else {
        # Create the symlink
        New-Item -ItemType SymbolicLink -Path $Global:symlinkPath -Target $inputPath
        Write-Output "Symlink created: $Global:symlinkPath -> $inputPath"
    }

    # Create and return a custom object with the desired properties
    [PSCustomObject]@{
        Version = $_.Version.ToString() + $betaPostfix + $defaultPostfix
        Build = $_.Build
        Path = $_.Path
        SymlinkPath = $Global:symlinkPath
    }
}




# Declare the global variable for symlinkPath
$Global:symlinkPath = ""

# Process and sort the Xcode version information
$xcodeList = $xcodeInfo.Values | ForEach-Object { $_.VersionInfo } | Sort-Object $sortRules

return $xcodeList | ForEach-Object {
    # Determine the postfixes for default and beta versions
    $defaultPostfix = if ($_.IsDefault) { " (default)" } else { "" }
    $betaPostfix = if ($_.IsStable) { "" } else { " (beta)" }

    # Example input path from the current Xcode VersionInfo
    $inputPath = $_.Path

    # Extract the base name of the app from the Path property
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($inputPath)

    # Determine the new base name based on suffixes
    $newBaseName = if ($baseName -match '_beta_\d+$') {
        # Handle paths like 'Xcode_16_beta_5.app'
        $baseName -replace '_beta_\d+$', ''
        $Global:symlinkPath = "/Applications/${newBaseName}.0.app"
    } elseif ($baseName -match '_beta$') {
        # Handle paths like 'Xcode_16_beta.app'
        $baseName -replace '_beta$', ''
        $Global:symlinkPath = "/Applications/${newBaseName}.app"
    } else {
        # Handle cases where no '_beta' suffix needs to be removed
        $newBaseName = $baseName # Corrected here to maintain consistency
        $Global:symlinkPath = "/Applications/${newBaseName}.app"
    }

    # Output the original path and the symlink path
    Write-Output "Original Path: $inputPath"
    Write-Output "Symlink Path: $Global:symlinkPath"

    # Check if the symlink already exists
    if (Test-Path $Global:symlinkPath) {
        Write-Output "Symlink already exists: $Global:symlinkPath"
    } else {
        # Create the symlink
        New-Item -ItemType SymbolicLink -Path $Global:symlinkPath -Target $inputPath
        Write-Output "Symlink created: $Global:symlinkPath -> $inputPath"
    }

    # Create and return a custom object with the desired properties
    [PSCustomObject]@{
        Version = $_.Version.ToString() + $betaPostfix + $defaultPostfix
        Build = $_.Build
        Path = $_.Path
        SymlinkPath = $Global:symlinkPath
    }
}

# Declare the global variable for symlinkPath
$Global:symlinkPath = ""

# Process and sort the Xcode version information
$xcodeList = $xcodeInfo.Values | ForEach-Object { $_.VersionInfo } | Sort-Object $sortRules

# Initialize an empty array to collect objects
$results = @()

$xcodeList | ForEach-Object {
    # Determine the postfixes for default and beta versions
    $defaultPostfix = if ($_.IsDefault) { " (default)" } else { "" }
    $betaPostfix = if ($_.IsStable) { "" } else { " (beta)" }

    # Example input path from the current Xcode VersionInfo
    $inputPath = $_.Path

    # Extract the base name of the app from the Path property
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($inputPath)

    # Determine the new base name based on suffixes
    $newBaseName = if ($baseName -match '_beta_\d+$') {
        # Handle paths like 'Xcode_16_beta_5.app'
        $baseName -replace '_beta_\d+$', ''
        $Global:symlinkPath = "/Applications/${newBaseName}.0.app"
    } elseif ($baseName -match '_beta$') {
        # Handle paths like 'Xcode_16_beta.app'
        $baseName -replace '_beta$', ''
        $Global:symlinkPath = "/Applications/${newBaseName}.app"
    } else {
        # Handle cases where no '_beta' suffix needs to be removed
        $newBaseName = $baseName # Corrected here to maintain consistency
        $Global:symlinkPath = "/Applications/${newBaseName}.app"
    }

    # Output the original path and the symlink path
    Write-Output "Original Path: $inputPath"
    Write-Output "Symlink Path: $Global:symlinkPath"

    # Check if the symlink already exists
    if (Test-Path $Global:symlinkPath) {
        Write-Output "Symlink already exists: $Global:symlinkPath"
    } else {
        # Create the symlink
        New-Item -ItemType SymbolicLink -Path $Global:symlinkPath -Target $inputPath
        Write-Output "Symlink created: $Global:symlinkPath -> $inputPath"
    }

    # Create and return a custom object with the desired properties
    $results += [PSCustomObject]@{
        Version = $_.Version.ToString() + $betaPostfix + $defaultPostfix
        Build = $_.Build
        Path = $_.Path
        SymlinkPath = $Global:symlinkPath
    }
}

# Return the results
return $results





# Initialize an empty array to collect objects
$results = @()

$xcodeList | ForEach-Object {
    # Determine the postfixes for default and beta versions
    $defaultPostfix = if ($_.IsDefault) { " (default)" } else { "" }
    $betaPostfix = if ($_.IsStable) { "" } else { " (beta)" }

    # Example input path from the current Xcode VersionInfo
    $inputPath = $_.Path

    # Extract the base name of the app from the Path property
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($inputPath)

    # Local variable to hold the symlink path for this iteration
    $symlinkPath = ""

    # Determine the new base name based on suffixes
    if ($baseName -match '_beta_\d+$') {
        # Handle paths like 'Xcode_16_beta_6.app'
        $newBaseName = $baseName -replace '_beta_\d+$', ''
        $symlinkPath = "/Applications/${newBaseName}.0.app"
    } elseif ($baseName -match '_beta$') {
        # Handle paths like 'Xcode_16_beta.app'
        $newBaseName = $baseName -replace '_beta$', ''
        $symlinkPath = "/Applications/${newBaseName}.app"
    } else {
        # Handle cases where no '_beta' suffix needs to be removed
        $newBaseName = $baseName
        $symlinkPath = "/Applications/${newBaseName}.app"
    }

    # Output the original path and the symlink path
    Write-Output "Original Path: $inputPath"
    Write-Output "Symlink Path: $symlinkPath"

    # Check if the symlink already exists
    if (Test-Path $symlinkPath) {
        Write-Output "Symlink already exists: $symlinkPath"
    } else {
        # Create the symlink
        New-Item -ItemType SymbolicLink -Path $symlinkPath -Target $inputPath
        Write-Output "Symlink created: $symlinkPath -> $inputPath"
    }

    # Create and return a custom object with the desired properties
    $results += [PSCustomObject]@{
        Version     = $_.Version.ToString() + $betaPostfix + $defaultPostfix
        Build       = $_.Build
        Path        = $_.Path
        SymlinkPath = $symlinkPath
    }
}

# Return the results
return $results


expected output should be:
Version      Build       Path                                    SymlinkPath
-------      -----       ----                                    -----------
16.1 (beta)  10A254a     /Applications/Xcode_16.1_beta.app       /Applications/Xcode_16.1.app
16.0         10A230      /Applications/Xcode_16_beta_6.app       /Applications/Xcode_16.0.app

# Initialize an empty array to collect objects
$results = @()

return $xcodeList | ForEach-Object {
    # Determine the postfixes for default and beta versions
    $defaultPostfix = if ($_.IsDefault) { " (default)" } else { "" }
    $betaPostfix = if ($_.IsStable) { "" } else { " (beta)" }

    # Example input path from the current Xcode VersionInfo
    $inputPath = $_.Path

    # Extract the base name of the app from the Path property
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($inputPath)

    # Initialize the new base name with the original base name
    $newBaseName = $baseName

    # Determine the new base name based on suffixes
    if ($baseName -match '_beta_\d+$') {
        # Handle paths like 'Xcode_16_beta_6.app'
        $newBaseName = $baseName -replace '_beta_\d+$', ''
        $symlinkPath = "/Applications/${newBaseName}.0.app"
    } elseif ($baseName -match '_beta$') {
        # Handle paths like 'Xcode_16_beta.app'
        $newBaseName = $baseName -replace '_beta$', ''
        $symlinkPath = "/Applications/${newBaseName}.app"
    } else {
        # Handle cases where no '_beta' suffix needs to be removed
        $symlinkPath = "/Applications/${newBaseName}.app"
    }

    # Ensure that $newBaseName is valid
    if (-not $newBaseName) {
        Write-Error "Invalid base name extracted from path: $inputPath"
        return
    }

    # Output the original path and the symlink path
    Write-Output "Original Path: $inputPath"
    Write-Output "Symlink Path: $symlinkPath"

    # Check if the symlink already exists
    if (Test-Path $symlinkPath) {
        Write-Output "Symlink already exists: $symlinkPath"
    } else {
        # Create the symlink
        New-Item -ItemType SymbolicLink -Path $symlinkPath -Target $inputPath
        Write-Output "Symlink created: $symlinkPath -> $inputPath"
    }

    # Create and return a custom object with the desired properties
    $results += [PSCustomObject]@{
        Version     = $_.Version.ToString() + $betaPostfix + $defaultPostfix
        Build       = $_.Build
        Path        = $_.Path
        SymlinkPath = $symlinkPath
    }
}

# Return the results
return $results

Version	Build	Path	SymlinkPath
16.1 (beta)	10A254a	/Applications/Xcode_16.1_beta.app	/Applications/Xcode_16.1.app
16.0	10A230	/Applications/Xcode_16_beta_6.app	/Applications/Xcode_16.0.app
15.4 (default)	9C40b	/Applications/Xcode_15.4.app	/Applications/Xcode_15.4.app


$xcodeList | ForEach-Object {
    # Determine the postfixes for default and beta versions
    $defaultPostfix = if ($_.IsDefault) { " (default)" } else { "" }
    $betaPostfix = if ($_.IsStable) { "" } else { " (beta)" }

    # Example input path from the current Xcode VersionInfo
    $inputPath = $_.Path

    # Extract the base name of the app from the Path property
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($inputPath)

    # Initialize the new base name with the original base name
    $newBaseName = $baseName

    # Determine the new base name based on suffixes
    if ($baseName -match '_beta_\d+$') {
        # Handle paths like 'Xcode_16_beta_6.app'
        $newBaseName = $baseName -replace '_beta_\d+$', ''
        $symlinkPath = "/Applications/${newBaseName}.0.app"
    } elseif ($baseName -match '_beta$') {
        # Handle paths like 'Xcode_16_beta.app'
        $newBaseName = $baseName -replace '_beta$', ''
        $symlinkPath = "/Applications/${newBaseName}.app"
    } else {
        # Handle cases where no '_beta' suffix needs to be removed
        $symlinkPath = "/Applications/${newBaseName}.app"
    }

    # Output the original path and the symlink path
    Write-Output "Original Path: $inputPath"
    Write-Output "Symlink Path: $symlinkPath"

    # Check if the symlink already exists
    if (Test-Path $symlinkPath) {
        Write-Output "Symlink already exists: $symlinkPath"
    } else {
        # Create the symlink
        New-Item -ItemType SymbolicLink -Path $symlinkPath -Target $inputPath
        Write-Output "Symlink created: $symlinkPath -> $inputPath"
    }

    # Create and return a custom object with the desired properties
    [PSCustomObject]@{
        Version     = $_.Version.ToString() + $betaPostfix + $defaultPostfix
        Build       = $_.Build
        Path        = $_.Path
        SymlinkPath = $symlinkPath
    }
}


# Initialize an empty array to collect objects
$results = @()

# Sort the Xcode versions if $sortRules is defined
$xcodeList = $xcodeInfo.Values | ForEach-Object { $_.VersionInfo } 
if ($sortRules) {
    $xcodeList = $xcodeList | Sort-Object $sortRules
}

# Iterate over the sorted list of Xcode versions
$xcodeList | ForEach-Object {
    # Determine the postfixes for default and beta versions
    $defaultPostfix = if ($_.IsDefault) { " (default)" } else { "" }
    $betaPostfix = if ($_.IsStable) { "" } else { " (beta)" }

    # Example input path from the current Xcode VersionInfo
    $inputPath = $_.Path

    # Extract the base name of the app from the Path property
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($inputPath)

    # Initialize the symlink path
    $symlinkPath = ""

    # Determine the symlink path based on suffixes
    if ($baseName -match '_beta_\d+$') {
        # Handle paths like 'Xcode_16_beta_6.app'
        $newBaseName = $baseName -replace '_beta_\d+$', ''
        $symlinkPath = "/Applications/${newBaseName}.0.app"
    } elseif ($baseName -match '_beta$') {
        # Handle paths like 'Xcode_16_beta.app'
        $newBaseName = $baseName -replace '_beta$', ''
        $symlinkPath = "/Applications/${newBaseName}.app"
    } else {
        # Handle cases where no '_beta' suffix needs to be removed
        $symlinkPath = "/Applications/${baseName}.app"
    }

    # Output the original path and the symlink path
    Write-Output "Original Path: $inputPath"
    Write-Output "Symlink Path: $symlinkPath"

    # Check if the symlink already exists
    if (Test-Path $symlinkPath) {
        Write-Output "Symlink already exists: $symlinkPath"
    } else {
        # Create the symlink
        New-Item -ItemType SymbolicLink -Path $symlinkPath -Target $inputPath
        Write-Output "Symlink created: $symlinkPath -> $inputPath"
    }

    # Create and return a custom object with the desired properties
    $results += [PSCustomObject]@{
        Version     = $_.Version.ToString() + $betaPostfix + $defaultPostfix
        Build       = $_.Build
        Path        = $_.Path
        SymlinkPath = $symlinkPath
    }
}

# Output the results array
$results
