. "$PSScriptRoot\materialUI.ps1"
. "$PSScriptRoot\shadecnUI.ps1"
. "$PSScriptRoot\heroUI.ps1"
. "$PSScriptRoot\chakraUI.ps1"
. "$PSScriptRoot\reactBootstrap.ps1"
. "$PSScriptRoot\antd.ps1"
. "$PSScriptRoot\mantine.ps1"
. "$PSScriptRoot\daisyui.ps1"

$prettierrc_content = @'
{
    "semi": true,
    "singleQuote": true,
    "trailingComma": "all",
    "printWidth": 100,
    "tabWidth": 4,
    "arrowParens": "always",
    "jsxSingleQuote": false,
    "endOfLine": "lf"
}
'@

$prettierignore_content = @'
node_modules/
dist/
build/
coverage/
.vite/
'@

<#
.SYNOPSIS
    Installe et configure Prettier dans le projet courant.

.DESCRIPTION
    Installe Prettier en dépendance de développement, ajoute le script npm "format",
    puis crée les fichiers .prettierrc et .prettierignore.

.EXAMPLE
    Install-Prettier
#>
function Install-Prettier {
    Write-Host "Installation de Prettier..." -ForegroundColor Cyan
    npm install -D prettier | Out-Null
    npm pkg set scripts.format="prettier --write ." | Out-Null

    Set-Content ".prettierrc" -Value $prettierrc_content -Encoding UTF8
    Set-Content ".prettierignore" -Value $prettierignore_content -Encoding UTF8

    Write-Host "Prettier a été installé et configuré avec succès !" -ForegroundColor Green
    Write-Host "Exécutez `npm run format` pour formater votre projet."
}

<#
.SYNOPSIS
    Crée un projet Vite + React + TypeScript (template de base).

.PARAMETER PROJECT_NAME
    Nom du répertoire du projet à créer.

.EXAMPLE
    New-ReactVite myapp
#>
function New-ReactVite {
    param([string]$PROJECT_NAME)
    npx create-vite@latest $PROJECT_NAME --template react-ts
}

<#
.SYNOPSIS
    Scaffold un projet React + Vite + TypeScript avec une bibliothèque UI/UX au choix.

.DESCRIPTION
    Affiche un menu interactif proposant 9 bibliothèques UI/UX (Material UI, Shadcn UI,
    Hero UI, Chakra UI, React Bootstrap, Mantine, Ant Design, DaisyUI...), crée le projet,
    installe les dépendances, configure l'alias "@" vers src/ et le sélecteur de thème.

.PARAMETER PROJECT_NAME
    Nom du projet. Optionnel : s'il est vide, il est demandé interactivement.

.EXAMPLE
    New-React myapp
#>
function New-React {
    param([string]$PROJECT_NAME)

    Write-Host ""
    Write-Host "  🚀 ReactJS Project Scaffolder" -ForegroundColor Cyan
    Write-Host "  =============================" -ForegroundColor DarkGray
    Write-Host ""

    $CHOICES = @(
        @{ Id = 1; Name = "Vite + React (base)"; Desc = "Plain React + TypeScript template" }
        @{ Id = 2; Name = "Vite + Material UI"; Desc = "Google Material Design components" }
        @{ Id = 3; Name = "Vite + Shadcn UI"; Desc = "Tailwind + Radix accessible components" }
        @{ Id = 4; Name = "Vite + Hero UI"; Desc = "Tailwind + React Aria components" }
        @{ Id = 5; Name = "Vite + Chakra UI"; Desc = "Headless-friendly component library" }
        @{ Id = 6; Name = "Vite + React Bootstrap"; Desc = "Bootstrap components for React" }
        @{ Id = 7; Name = "Vite + Mantine"; Desc = "Modern hooks-first component library" }
        @{ Id = 8; Name = "Vite + Ant Design"; Desc = "Enterprise UI design system" }
        @{ Id = 9; Name = "Vite + DaisyUI"; Desc = "Pure CSS Tailwind components" }
    )

    foreach ($c in $CHOICES) {
        Write-Host ("  {0}. {1}" -f $c.Id, $c.Name) -ForegroundColor Green
        Write-Host ("     {0}" -f $c.Desc) -ForegroundColor DarkGray
    }

    Write-Host ""
    $PROJECT_CHOICE = Read-Host "Enter choice (1-$($CHOICES.Count))"

    if (-not $PROJECT_NAME) { $PROJECT_NAME = Read-Host "Project name" }

    switch ($PROJECT_CHOICE) {
        "1" { New-ReactVite $PROJECT_NAME }
        "2" { New-ReactViteMaterialUi $PROJECT_NAME }
        "3" { New-ReactViteShadecnUi $PROJECT_NAME }
        "4" { New-ReactViteHeroUi $PROJECT_NAME }
        "5" { New-ReactViteChakraUi $PROJECT_NAME }
        "6" { New-ReactViteBootstrap $PROJECT_NAME }
        "7" { New-ReactViteMantine $PROJECT_NAME }
        "8" { New-ReactViteAntd $PROJECT_NAME }
        "9" { New-ReactViteDaisyUi $PROJECT_NAME }
        default {
            Write-Host "Choix invalide. Création d'un projet Vite de base." -ForegroundColor Yellow
            New-ReactVite $PROJECT_NAME
        }
    }
}
