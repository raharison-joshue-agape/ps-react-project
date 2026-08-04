<div align="center">

# 🚀 ReactJS Project Aliases

### Des raccourcis CLI pour scaffold des projets **React 19 + Vite + TypeScript** pré-configurés en quelques secondes

Un ensemble de fonctions pour **Bash (Linux)**, **Zsh (macOS)** et **PowerShell (Windows)** qui génèrent une base de code React moderne, structurée et prête à l'emploi — sans perdre de temps à tout reconfigurer à chaque projet.

---

[![Node.js](https://img.shields.io/badge/Node.js-18%2B-339933?style=for-the-badge&logo=nodedotjs&logoColor=white)](https://nodejs.org/)
[![React](https://img.shields.io/badge/React-19-61DAFB?style=for-the-badge&logo=react&logoColor=white)](https://react.dev/)
[![Vite](https://img.shields.io/badge/Vite-ready-646CFF?style=for-the-badge&logo=vite&logoColor=white)](https://vite.dev/)
[![TypeScript](https://img.shields.io/badge/TypeScript-5-3178C6?style=for-the-badge&logo=typescript&logoColor=white)](https://www.typescriptlang.org/)

[![Bash](https://img.shields.io/badge/Bash-4.0%2B-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Zsh](https://img.shields.io/badge/Zsh-5.8%2B-4EAA25?style=for-the-badge&logo=zsh&logoColor=white)](https://www.zsh.org/)
[![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-5391FE?style=for-the-badge&logo=powershell&logoColor=white)](https://learn.microsoft.com/powershell/)
[![Linux](https://img.shields.io/badge/Linux-ready-FCC624?style=for-the-badge&logo=linux&logoColor=black)](https://www.linux.org/)
[![macOS](https://img.shields.io/badge/macOS-ready-000000?style=for-the-badge&logo=apple&logoColor=white)](https://www.apple.com/macos/)
[![Windows](https://img.shields.io/badge/Windows-ready-0078D6?style=for-the-badge&logo=windows&logoColor=white)](https://www.microsoft.com/windows)

</div>

---

## 📑 Table des matières

- [✨ Fonctionnalités](#-fonctionnalités)
- [⚡ Démarrage rapide](#-démarrage-rapide)
- [🧰 Prérequis](#-prérequis)
- [🐧 Installation Linux](#-installation-linux)
- [🍎 Installation macOS](#-installation-macos)
- [🪟 Installation Windows](#-installation-windows)
- [🔧 Référence des commandes](#-référence-des-commandes)
- [🧩 Architecture et modules](#-architecture-et-modules)
- [📂 Structure du projet](#-structure-du-projet)
- [📖 Aide intégrée](#-aide-intégrée)
- [🧹 Désinstallation](#-désinstallation)
- [🛟 Dépannage](#-dépannage)
- [🤝 Contribution](#-contribution)
- [📄 Licence](#-licence)

---

## ✨ Fonctionnalités

| | |
|---|---|
| ⚡ **Scaffolding en une commande** | Génère un projet React 19 + Vite + TypeScript pré-configuré (alias `@`, router, thème) depuis une seule commande |
| 🎨 **9 bibliothèques UI/UX** | Material UI, Shadcn UI, Hero UI, Chakra UI, React Bootstrap, Mantine, Ant Design, DaisyUI + template de base |
| ⏩ **Création non-bloquante** | Flag `--no-immediate` : `create-vite` ne lance pas le serveur de dev avant la configuration |
| 🔗 **Alias `@` pré-configuré** | `@` → `src/` dans `vite.config.ts` et `tsconfig.app.json` (`paths: { "@/*": ["./src/*"] }`) |
| 🧭 **React Router** | Layout par défaut, page `/home` et page **404** stylée |
| 🌗 **Sélecteur de thème** | Clair / Sombre / Système, adapté à chaque bibliothèque (`ToggleMode`) |
| 📝 **Prettier optionnel** | `.prettierrc` + `.prettierignore`, script `npm run format` |
| 🌱 **Git optionnel** | `git init` + premier commit `Initial commit` |
| 🧩 **Architecture modulaire** | Modules thématiques (une bibliothèque par fichier) chargés depuis un point d'entrée unique |
| 🧠 **Multi-plateforme** | Mêmes commandes, mêmes options, mêmes templates : `new_react_vite_<lib>` ⇄ `New-ReactVite<Lib>` |
| 🍎 **macOS / Zsh** | Scripts `.zsh` écrits pour zsh (shell par défaut) + outils BSD |
| ✅ **Feedback clair** | Messages de progression et de succès à chaque étape de l'installation |

---

## ⚡ Démarrage rapide

> ⏱️ Installation en moins d'une minute : copier le dossier, ajouter une ligne, recharger.

```bash
# Linux — ajouter à ~/.bashrc
. ~/.config/alias/react-aliases-project/linux/index.sh
```

```bash
# macOS — ajouter à ~/.zshrc
. ~/.config/alias/react-aliases-project/macos/index.zsh
```

```powershell
# Windows — ajouter au $PROFILE
. "$HOME\.config\alias\react-aliases-project\windows\index.ps1"
```

```bash
# Puis, créer son premier projet :
new_react myapp
cd myapp && npm run dev   # → http://localhost:5173
```

---

## 🧰 Prérequis

| Exigence | Détail |
|---|---|
| **Node.js** | 18+ avec `npm` disponibles dans le `PATH` |
| **Git** | Installé et accessible (pour l'initialisation optionnelle du projet) |
| **Linux** | bash 4.0+ |
| **macOS** | zsh 5.8+ (shell par défaut depuis macOS Catalina) |
| **Windows** | Windows 10/11, Windows PowerShell 5.1+ ou PowerShell 7 |
| **Internet** | Accès au registre npm (`npx create-vite@latest`) |

---

## 🐧 Installation Linux

### 1. Copier les fichiers dans votre répertoire de configuration

```bash
mkdir -p ~/.config/alias
cp -r linux ~/.config/alias/react-aliases-project/
```

### 2. Ouvrir votre fichier de configuration shell

```bash
nano ~/.bashrc        # Bash
nano ~/.zshrc         # Zsh
```

### 3. Importer les aliases

Ajoutez cette ligne à la fin du fichier :

```bash
. ~/.config/alias/react-aliases-project/linux/index.sh
```

### 4. Recharger votre configuration

```bash
source ~/.bashrc      # ou : source ~/.zshrc
```

### 5. Créer votre premier projet

```bash
new_react myapp
cd myapp && npm run dev
```

---

## 🍎 Installation macOS

### 1. Copier les fichiers dans votre répertoire de configuration

```bash
mkdir -p ~/.config/alias
cp -r macos ~/.config/alias/react-aliases-project/
```

### 2. Ouvrir votre fichier de configuration shell

```bash
nano ~/.zshrc          # Zsh (shell par défaut de macOS)
```

### 3. Importer les aliases

Ajoutez cette ligne à la fin du fichier :

```bash
. ~/.config/alias/react-aliases-project/macos/index.zsh
```

### 4. Recharger votre configuration

```bash
source ~/.zshrc
```

### 5. Créer votre premier projet

```bash
new_react myapp
cd myapp && npm run dev
```

> 💡 Les scripts sont écrits en **zsh** (aucune dépendance bash ni outil GNU), uniquement des outils BSD de macOS.

---

## 🪟 Installation Windows

### 1. Copier les fichiers dans votre répertoire de configuration

```powershell
New-Item -ItemType Directory -Path "$HOME\.config\alias" -Force
Copy-Item -Path "windows" -Destination "$HOME\.config\alias\react-aliases-project\" -Recurse
```

### 2. Vérifier que votre profil PowerShell existe

```powershell
Test-Path $PROFILE
```

- `True` → votre profil existe, passez à l'étape 4.
- `False` → créez-le :

```powershell
New-Item -Path $PROFILE -ItemType File -Force
```

### 3. Ouvrir votre profil

```powershell
notepad $PROFILE      # ou : code $PROFILE
```

### 4. Importer les aliases

Ajoutez cette ligne à votre profil :

```powershell
. "$HOME\.config\alias\react-aliases-project\windows\index.ps1"
```

### 5. Recharger votre profil

```powershell
. $PROFILE
```

### 6. Créer votre premier projet

```powershell
New-React myapp
cd myapp
npm run dev
```

---

## 🔧 Référence des commandes

Les fonctions se comportent comme des commandes natives et acceptent les mêmes arguments sur les trois plateformes.

### 🚀 Créer un projet (menu interactif)

```bash
# Linux / macOS (Bash / Zsh)
new_react myapp
```

```powershell
# Windows (PowerShell)
New-React myapp
```

Affiche un menu interactif :

| #  | Template                | Description                                   |
|----|-------------------------|-----------------------------------------------|
| 1  | Vite + React (base)     | Plain React + TypeScript template             |
| 2  | Vite + Material UI      | Google Material Design components             |
| 3  | Vite + Shadcn UI        | Tailwind + Radix accessible components        |
| 4  | Vite + Hero UI          | Tailwind + React Aria components              |
| 5  | Vite + Chakra UI        | Headless-friendly component library           |
| 6  | Vite + React Bootstrap  | Bootstrap components for React                |
| 7  | Vite + Mantine          | Modern hooks-first component library          |
| 8  | Vite + Ant Design       | Enterprise UI design system                   |
| 9  | Vite + DaisyUI          | Pure CSS Tailwind components                  |

> 💡 Le nom du projet est optionnel : laissez vide pour le saisir interactivement.

### 🎨 Créer un projet avec une bibliothèque précise

```bash
# Linux / macOS
new_react_vite_material_ui myapp
new_react_vite_mantine myapp
```

```powershell
# Windows
New-ReactViteMaterialUi myapp
New-ReactViteMantine myapp
```

| Linux / macOS | Windows | Template |
|---|---|---|
| `new_react_vite` | `New-ReactVite` | Vite + React (base) |
| `new_react_vite_material_ui` | `New-ReactViteMaterialUi` | Material UI |
| `new_react_vite_shadecn_ui` | `New-ReactViteShadecnUi` | Shadcn UI |
| `new_react_vite_hero_ui` | `New-ReactViteHeroUi` | Hero UI |
| `new_react_vite_chakra_ui` | `New-ReactViteChakraUi` | Chakra UI |
| `new_react_vite_bootstrap` | `New-ReactViteBootstrap` | React Bootstrap |
| `new_react_vite_mantine` | `New-ReactViteMantine` | Mantine |
| `new_react_vite_antd` | `New-ReactViteAntd` | Ant Design |
| `new_react_vite_daisy_ui` | `New-ReactViteDaisyUi` | DaisyUI |

Chaque commande scaffolde le projet (`create-vite` avec `--no-immediate`), installe les dépendances de la bibliothèque, configure l'alias `@`, React Router et le sélecteur de thème, demande si vous voulez **Prettier** et **Git**, puis lance `npm run dev`.

### 📝 Configurer Prettier

```bash
# Linux / macOS
install_prettier
```

```powershell
# Windows
Install-Prettier
```

Installe Prettier en dépendance de développement, ajoute le script `npm run format`, et génère `.prettierrc` + `.prettierignore`.

### 🧱 Ce que chaque template inclut

| Élément | Détail |
|---|---|
| **React 19 + TypeScript** | Généré avec `create-vite` (`react-ts`) |
| **Alias `@`** | → `src/` dans `vite.config.ts` et `tsconfig.app.json` (`paths: { "@/*": ["./src/*"] }`) |
| **React Router** | Layout par défaut, page `/home` et page **404** stylée |
| **ToggleMode** | Sélecteur Clair / Sombre / Système, adapté à chaque bibliothèque |
| **Prettier** *(optionnel)* | `.prettierrc` + `.prettierignore`, script `npm run format` |
| **Git** *(optionnel)* | `git init` + premier commit `Initial commit` |
| **Serveur de dev** | Port `5173`, `host: '0.0.0.0'`, ouverture auto du navigateur |

Le composant **ToggleMode** est adapté à chaque bibliothèque :

| Bibliothèque | Sélecteur de thème |
|---|---|
| Material UI | `Select` MUI |
| Shadcn UI | `DropdownMenu` |
| Hero UI | `Select` |
| Chakra UI | `Select` + `next-themes` |
| React Bootstrap | `ButtonGroup` d'icônes |
| Ant Design | `Segmented` |
| Mantine | `SegmentedControl` |
| DaisyUI | Boutons `join` |

### 📂 Structure générée

```
myapp/
├── src/
│   ├── components/ToggleMode.tsx   # Sélecteur de thème
│   ├── layouts/default.tsx         # Layout React Router
│   ├── pages/Home.tsx              # Page d'accueil
│   ├── pages/NotFound.tsx          # Page 404
│   ├── routes/index.tsx            # Configuration du routeur
│   ├── styles/index.css            # Tailwind (selon bibliothèque)
│   ├── theme/ThemeContext.tsx      # Contexte Clair / Sombre / Système
│   └── main.tsx                    # Point d'entrée React
├── vite.config.ts                  # Alias @, port 5173, host 0.0.0.0
├── tsconfig.app.json               # paths: { "@/*": ["./src/*"] }
├── package.json
├── .gitignore
└── .prettierrc / .prettierignore   # (si Prettier)
```

---

## 🧩 Architecture et modules

L'implémentation suit une **architecture modulaire en couches**, chaque couche ayant une responsabilité unique :

```
 Terminal / Shell de l'utilisateur
      │      (~/.bashrc | ~/.zshrc | $PROFILE)
      ▼
┌────────────────────────────┐
│  index.sh / index.zsh / index.ps1  │  Point d'entrée — charge tous les modules
└────────────┬───────────────┘
             ▼
┌────────────────────────────┐
│  Modules bibliothèques UI  │  materialUI.sh/.zsh/.ps1
│                            │  shadecnUI, heroUI, chakraUI,
│                            │  reactBootstrap, antd, mantine, daisyui
└────────────┬───────────────┘
             ▼
┌────────────────────────────┐
│  Helpers partagés          │  install_prettier (config Prettier)
│                            │  new_react_vite / New-ReactVite (create-vite)
└────────────┬───────────────┘
             ▼
        Projet React 19 + Vite + TS
        (npm install + alias/router/thème + dev server)
```

- **`index.sh` / `index.zsh` / `index.ps1`** : source l'ensemble des modules situés dans son propre répertoire, quel que soit l'endroit où le projet a été copié.
- **Modules bibliothèques** : chacun expose les fonctions publiques d'une bibliothèque UI (scaffolding + configuration complète).
- **Helpers partagés** : portent la logique transversale (`new_react_vite`, `install_prettier`).
- Les trois implémentations (`linux/`, `macos/` et `windows/`) sont **fonctionnellement équivalentes** : mêmes commandes, mêmes options, mêmes templates générés.

| Fichier (Linux / macOS / Windows) | Fonctions |
|---|---|
| `index.sh` / `.zsh` / `.ps1` | `new_react`, `new_react_vite`, `install_prettier` / `New-React`, `New-ReactVite`, `Install-Prettier` |
| `materialUI.sh` / `.zsh` / `.ps1` | `new_react_vite_material_ui` / `New-ReactViteMaterialUi` |
| `shadecnUI.sh` / `.zsh` / `.ps1` | `new_react_vite_shadecn_ui` / `New-ReactViteShadecnUi` |
| `heroUI.sh` / `.zsh` / `.ps1` | `new_react_vite_hero_ui` / `New-ReactViteHeroUi` |
| `chakraUI.sh` / `.zsh` / `.ps1` | `new_react_vite_chakra_ui` / `New-ReactViteChakraUi` |
| `reactBootstrap.sh` / `.zsh` / `.ps1` | `new_react_vite_bootstrap` / `New-ReactViteBootstrap` |
| `antd.sh` / `.zsh` / `.ps1` | `new_react_vite_antd` / `New-ReactViteAntd` |
| `mantine.sh` / `.zsh` / `.ps1` | `new_react_vite_mantine` / `New-ReactViteMantine` |
| `daisyui.sh` / `.zsh` / `.ps1` | `new_react_vite_daisy_ui` / `New-ReactViteDaisyUi` |

> 💡 **macOS** expose les **mêmes noms de fonctions que Linux** (scripts `.zsh`) — seule l'installation diffère (`~/.zshrc`).

---

## 📂 Structure du projet

```
react-aliases-project/
├── linux/                    # Implémentation Bash pour Linux
│   ├── index.sh              # Point d'entrée (charge tous les modules)
│   ├── materialUI.sh         # new_react_vite_material_ui
│   ├── shadecnUI.sh          # new_react_vite_shadecn_ui
│   ├── heroUI.sh             # new_react_vite_hero_ui
│   ├── chakraUI.sh           # new_react_vite_chakra_ui
│   ├── reactBootstrap.sh     # new_react_vite_bootstrap
│   ├── antd.sh               # new_react_vite_antd
│   ├── mantine.sh            # new_react_vite_mantine
│   ├── daisyui.sh            # new_react_vite_daisy_ui
│   └── README.md             # Guide d'installation Linux
├── macos/                    # Implémentation Zsh pour macOS
│   ├── index.zsh             # Point d'entrée (charge tous les modules)
│   ├── materialUI.zsh        # new_react_vite_material_ui
│   ├── shadecnUI.zsh         # new_react_vite_shadecn_ui
│   ├── heroUI.zsh            # new_react_vite_hero_ui
│   ├── chakraUI.zsh          # new_react_vite_chakra_ui
│   ├── reactBootstrap.zsh    # new_react_vite_bootstrap
│   ├── antd.zsh              # new_react_vite_antd
│   ├── mantine.zsh           # new_react_vite_mantine
│   ├── daisyui.zsh           # new_react_vite_daisy_ui
│   └── README.md             # Guide d'installation macOS
├── windows/                  # Implémentation PowerShell pour Windows
│   ├── index.ps1             # Point d'entrée (charge tous les modules)
│   ├── materialUI.ps1        # New-ReactViteMaterialUi
│   ├── shadecnUI.ps1         # New-ReactViteShadecnUi
│   ├── heroUI.ps1            # New-ReactViteHeroUi
│   ├── chakraUI.ps1          # New-ReactViteChakraUi
│   ├── reactBootstrap.ps1    # New-ReactViteBootstrap
│   ├── antd.ps1              # New-ReactViteAntd
│   ├── mantine.ps1           # New-ReactViteMantine
│   ├── daisyui.ps1           # New-ReactViteDaisyUi
│   └── README.md             # Guide d'installation Windows
└── README.md                 # Ce fichier
```

---

## 📖 Aide intégrée

Chaque fonction dispose d'une documentation intégrée, découvrable directement dans votre shell :

| Commande (Linux / macOS) | Commande (Windows) | Description |
|---|---|---|
| `type <fonction>` | `Get-Help <fonction>` | Affiche la définition / documentation d'une fonction |
| `declare -f <fonction>` | `Get-Command <fonction>` | Détails d'implémentation |

```bash
# Linux / macOS
type new_react
declare -f new_react_vite_material_ui
```

```zsh
# macOS
whence -f new_react
```

```powershell
# Windows
Get-Help New-React
Get-Command New-ReactViteMantine
```

---

## 🧹 Désinstallation

### Linux

1. Supprimez la ligne d'import de `~/.bashrc`.
2. Supprimez le répertoire :

```bash
rm -rf ~/.config/alias/react-aliases-project
```

### macOS

1. Supprimez la ligne d'import de `~/.zshrc`.
2. Supprimez le répertoire :

```zsh
rm -rf ~/.config/alias/react-aliases-project
```

### Windows

1. Supprimez la ligne d'import de `$PROFILE`.
2. Supprimez le répertoire :

```powershell
Remove-Item -Path "$HOME\.config\alias\react-aliases-project" -Recurse -Force
```

---

## 🛟 Dépannage

| Symptôme | Solution |
|---|---|
| Les fonctions ne fonctionnent pas | Vérifiez le chemin dans la ligne d'import, puis rechargez : `source ~/.bashrc` (Linux) · `source ~/.zshrc` (macOS) · `. $PROFILE` (Windows) |
| `command not found: new_react` / `Get-Help` ne retourne rien | Les fonctions ne sont pas chargées : confirmez la présence de la ligne d'import correspondant à votre plateforme dans votre fichier de configuration |
| `node: command not found` | Installez Node.js 18+ et assurez-vous qu'il est disponible dans le `PATH` — macOS : `brew install node` |
| Le serveur de dev ne démarre pas | Vérifiez que `npm install` a été exécuté (avec `--no-immediate`, `create-vite` n'installe pas automatiquement) |
| Alias `@` non résolu | Relancez `npm install` (alias défini dans `vite.config.ts` + `tsconfig.app.json`) |
| Module introuvable | Un fichier de module est absent — réinstallez le dossier `linux/`, `macos/` ou `windows/` en entier |

---

## 🤝 Contribution

Les contributions sont les bienvenues ! Pour contribuer :

1. **Fork** le dépôt et créez une branche : `git checkout -b feature/ma-fonctionnalite`
2. **Implémentez** votre changement en respectant l'équivalence Linux/macOS/Windows existante
3. **Testez** vos scripts avant de soumettre
4. **Ouvrez une pull request** avec une description claire de vos modifications

---

## 📄 Licence

Ce projet est distribué sous licence open source. Vous pouvez l'utiliser, le modifier et le partager librement.
