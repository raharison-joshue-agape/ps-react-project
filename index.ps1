. "$HOME\.config\alias\react-aliases-project\materialUI.ps1"
. "$HOME\.config\alias\react-aliases-project\shadecnUI.ps1"
. "$HOME\.config\alias\react-aliases-project\heroUI.ps1"
. "$HOME\.config\alias\react-aliases-project\chakraUI.ps1"
. "$HOME\.config\alias\react-aliases-project\reactBootstrap.ps1"


$prettierrc_content = @'
{
    "semi": true,
    "singleQuote": true,
    "trailingComma": "all",
    "printWidth": 100,
    "tabWidth": 4,
    "vueIndentScriptAndStyle": true,
    "endOfLine": "lf"
}
'@

$prettierignore_content = @'
node_modules/
dist/
build/
.vite/
'@

function Install-Prettier {
    Write-Host "Installation de Prettier..."
    npm install -D prettier | Out-Null
    npm pkg set scripts.format="prettier --write ." | Out-Null

    Set-Content ".prettierrc" -Value $prettierrc_content -Encoding UTF8
    Set-Content ".prettierignore" -Value $prettierignore_content -Encoding UTF8

    Write-Host "Prettier a été installé et configuré avec succès !"
    Write-Host "Exécutez `npm run format` pour formater votre projet."
}

function New-ReactVite {
    param([string]$PROJECT_NAME)
    npx create-vite@latest $PROJECT_NAME --template react-ts
}

function New-React {
    param([string]$PROJECT_NAME)

    Write-Host "Which UI do you want to create?"
    Write-Host "1) Vite project"
    Write-Host "2) Vite + Material UI"
    Write-Host "3) Vite + Shadecn UI"
    Write-Host "4) Vite + Hero UI"
    Write-Host "5) Vite + Chakra UI"
    Write-Host "6) Vite + React Bootstrap"

    $PROJECT_CHOICE = Read-Host "Enter choice (1-*)"

    switch ($PROJECT_CHOICE) {
        "1" {
            if (-not $PROJECT_NAME) { $PROJECT_NAME = Read-Host "Project name" }
            New-ReactVite $PROJECT_NAME
        }
        "2" {
            if (-not $PROJECT_NAME) { $PROJECT_NAME = Read-Host "Project name" }
            New-ReactViteMaterialUi $PROJECT_NAME
        }
        "3" {
            if (-not $PROJECT_NAME) { $PROJECT_NAME = Read-Host "Project name" }
            New-ReactViteShadecnUi $PROJECT_NAME
        }
        "4" {
            if (-not $PROJECT_NAME) { $PROJECT_NAME = Read-Host "Project name" }
            New-ReactViteHeroUi $PROJECT_NAME
        }
        "5" {
            if (-not $PROJECT_NAME) { $PROJECT_NAME = Read-Host "Project name" }
            New-ReactViteChakraUi $PROJECT_NAME
        }
        "6" {
            if (-not $PROJECT_NAME) { $PROJECT_NAME = Read-Host "Project name" }
            New-ReactViteBootstrap $PROJECT_NAME
        }
        default {
            if (-not $PROJECT_NAME) { $PROJECT_NAME = Read-Host "Project name" }
            New-ReactVite $PROJECT_NAME
        }
    }
}