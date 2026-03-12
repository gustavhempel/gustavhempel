[CmdletBinding()]
param(
    [string]$RepoRoot = $(Resolve-Path (Join-Path $PSScriptRoot ".."))
)

$ErrorActionPreference = "Stop"

function Convert-ToGitPath {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    return ($Path -replace "\\", "/")
}

$repoGitConfig = Join-Path $RepoRoot "config\\gitconfig"
$repoGitIgnore = Join-Path $RepoRoot "config\\gitignore_global"

if (-not (Test-Path $repoGitConfig)) {
    throw "Missing file: $repoGitConfig"
}

if (-not (Test-Path $repoGitIgnore)) {
    throw "Missing file: $repoGitIgnore"
}

$gitConfigPath = Convert-ToGitPath -Path (Resolve-Path $repoGitConfig)
$gitIgnorePath = Convert-ToGitPath -Path (Resolve-Path $repoGitIgnore)

$existingIncludes = @(git config --global --get-all include.path 2>$null)
if (-not ($existingIncludes -contains $gitConfigPath)) {
    git config --global --add include.path "$gitConfigPath"
    Write-Host "Added include.path: $gitConfigPath"
} else {
    Write-Host "include.path already present: $gitConfigPath"
}

git config --global core.excludesfile "$gitIgnorePath"
Write-Host "Set core.excludesfile: $gitIgnorePath"

Write-Host ""
Write-Host "Git setup complete."
Write-Host "Verify with: git config --global --list --show-origin"
