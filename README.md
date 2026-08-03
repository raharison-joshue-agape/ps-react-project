<div align="center">

# 🚀 ReactJS Project Aliases

[![PowerShell](https://img.shields.io/badge/PowerShell-7+-blue?logo=powershell&logoColor=white)](https://learn.microsoft.com/powershell)
[![Bash](https://img.shields.io/badge/Bash-Linux-4EAA25?logo=gnubash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Node.js](https://img.shields.io/badge/Node.js-18+-339933?logo=nodedotjs&logoColor=white)](https://nodejs.org)
[![React](https://img.shields.io/badge/React-19-61DAFB?logo=react&logoColor=white)](https://react.dev)
[![Vite](https://img.shields.io/badge/Vite-6+-646CFF?logo=vite&logoColor=white)](https://vite.dev)
[![TypeScript](https://img.shields.io/badge/TypeScript-5-3178C6?logo=typescript&logoColor=white)](https://www.typescriptlang.org)

Raccourcis pour scaffolder des projets **React 19 + Vite + TypeScript** avec une bibliothèque UI/UX au choix, en **PowerShell (Windows)** ou en **bash (Linux)**.

</div>

---

## 📑 Table des matières

- [✨ Aperçu](#-aperçu)
- [📁 Structure du projet](#-structure-du-projet)
- [🧰 Prérequis](#-prérequis)
- [📦 Installation](#-installation)
- [🚀 Utilisation](#-utilisation)
- [🖥️ Commandes disponibles](#️-commandes-disponibles)
- [🎨 Ce que chaque template inclut](#-ce-que-chaque-template-inclut)
- [📖 Aide intégrée](#-aide-intégrée)
- [🧹 Désinstallation](#-désinstallation)
- [🛟 Dépannage](#-dépannage)
- [🤝 Contribution](#-contribution)

## ✨ Aperçu

Un ensemble de raccourcis qui scaffolde un projet **Vite + React 19 + TypeScript** et le pré-configure :

- **alias `@`** pointant vers `src/` dans `vite.config.ts` et `tsconfig.app.json` ;
- **React Router** avec un layout, une page `/home` et une page 404 stylée ;
- **sélecteur de thème** (Clair / Sombre / Système) qui suit le thème de l'OS en mode *System* ;
- **Prettier** (optionnel) avec une configuration cohérente ;
- **Git** initialisé avec un premier commit (optionnel) ;
- serveur de dev sur le port **5173**, ouverture automatique du navigateur.

Le tout est proposé pour **9 bibliothèques UI/UX** via un menu interactif.

## 📁 Structure du projet

```
react-aliases-project/
├── README.md          ← ce fichier
├── windows/           ← scripts PowerShell (.ps1)
└── linux/             ← scripts bash (.sh)
```

Chaque sous-dossier est autonome : un fichier par bibliothèque, sourcé par `index.ps1` / `index.sh`.

## 🧰 Prérequis

- **Node.js 18+** et **npm**
- **Windows** : PowerShell 7+ (ou Windows PowerShell 5.1)
- **Linux** : `bash` (plus `curl` pour `npx shadcn@latest init`)

## 📦 Installation

### 🪟 Windows (PowerShell)

1. Copier le module dans votre répertoire de configuration :

   ```powershell
   New-Item -ItemType Directory -Path "$HOME\.config\alias" -Force
   Copy-Item -Path "react-aliases-project" -Destination "$HOME\.config\alias\react-aliases-project\" -Recurse
   ```

2. Ajouter la ligne d'import dans votre profil PowerShell :

   ```powershell
   code $PROFILE   # ouvrir le profil
   ```

   ```powershell
   . "$HOME\.config\alias\react-aliases-project\windows\index.ps1"
   ```

3. Recharger le profil :

   ```powershell
   . $PROFILE
   ```

### 🐧 Linux (bash)

1. Copier le module :

   ```bash
   mkdir -p "$HOME/.config/alias"
   cp -r react-aliases-project "$HOME/.config/alias/"
   ```

2. Ajouter la ligne d'import dans votre `.bashrc` :

   ```bash
   echo '. "$HOME/.config/alias/react-aliases-project/linux/index.sh"' >> ~/.bashrc
   ```

3. Recharger le shell :

   ```bash
   source ~/.bashrc
   ```

## 🚀 Utilisation

| Action | Windows (PowerShell) | Linux (bash) |
|--------|----------------------|--------------|
| Créer un projet (menu interactif) | `New-React mon_app` | `new_react mon_app` |
| Créer un projet Vite de base | `New-ReactVite mon_app` | `new_react_vite mon_app` |

Le menu interactif propose les bibliothèques suivantes :

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

## 🖥️ Commandes disponibles

| Windows (PowerShell)      | Linux (bash)                    | Template             |
|---------------------------|---------------------------------|----------------------|
| `New-ReactVite`           | `new_react_vite`                | Vite + React (base)  |
| `New-ReactViteMaterialUi` | `new_react_vite_material_ui`    | Material UI          |
| `New-ReactViteShadecnUi`  | `new_react_vite_shadecn_ui`     | Shadcn UI            |
| `New-ReactViteHeroUi`     | `new_react_vite_hero_ui`        | Hero UI              |
| `New-ReactViteChakraUi`   | `new_react_vite_chakra_ui`      | Chakra UI            |
| `New-ReactViteBootstrap`  | `new_react_vite_bootstrap`      | React Bootstrap      |
| `New-ReactViteMantine`    | `new_react_vite_mantine`        | Mantine              |
| `New-ReactViteAntd`       | `new_react_vite_antd`           | Ant Design           |
| `New-ReactViteDaisyUi`    | `new_react_vite_daisy_ui`       | DaisyUI              |
| `Install-Prettier`        | `install_prettier`              | Prettier             |

Chaque commande scaffolde le projet, installe les dépendances, puis demande si vous voulez **Prettier** et **Git**, et lance enfin `npm run dev`.

## 🎨 Ce que chaque template inclut

- **React 19 + TypeScript** généré avec `create-vite` (`react-ts`)
- **alias `@`** → `src/` dans `vite.config.ts` et `tsconfig.app.json` (`paths: { "@/*": ["./src/*"] }`)
- **React Router** avec layout par défaut, page `/home` et page **404** personnalisée
- **ToggleMode** (Light / Dark / System) avec icônes, adapté à chaque bibliothèque :
  - MUI : `Select` ; Shadcn : `DropdownMenu` ; Hero UI : `Select` ; Chakra : `Select` + `next-themes`
  - Bootstrap : `ButtonGroup` d'icônes ; Antd : `Segmented` ; Mantine : `SegmentedControl` ; DaisyUI : boutons `join`
- **Prettier** optionnel (`.prettierrc` + `.prettierignore`, script `npm run format`)
- **Git** initialisé en option (premier commit `Initial commit`)
- Serveur de dev : port `5173`, `host: '0.0.0.0'`, ouverture auto du navigateur

## 📖 Aide intégrée

**Windows** — les fonctions disposent d'une aide commentée accessible via `Get-Help` :

```powershell
Get-Help New-React
Get-Help New-ReactViteMantine
Get-Help New-ReactViteMaterialUi -Detailed
```

**Linux** — chaque fonction est documentée en tête de son fichier `.sh` ; affichez sa définition avec :

```bash
type new_react
type new_react_vite_daisy_ui
```

## 🧹 Désinstallation

**Windows** : supprimer la ligne `. "$HOME\...\windows\index.ps1"` de `$PROFILE`, puis :

```powershell
Remove-Item "$HOME\.config\alias\react-aliases-project" -Recurse -Force
```

**Linux** : supprimer la ligne `source`/`.` du `~/.bashrc`, puis :

```bash
rm -rf "$HOME/.config/alias/react-aliases-project"
```

## 🛟 Dépannage

| Problème | Solution |
|----------|----------|
| `New-React` introuvable sur Windows | Vérifier la ligne d'import dans `$PROFILE`, puis `. $PROFILE` |
| Exécution de scripts bloquée (PowerShell) | `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned` |
| `new_react` introuvable sous Linux | Vérifier la ligne dans `~/.bashrc`, puis `source ~/.bashrc` |
| Échec de `npx shadcn@latest init` | Vérifier Node ≥ 18 et la présence de `curl` |
| Alias `@` non résolu | Relancer `npm install` (alias défini dans `vite.config.ts` + `tsconfig.app.json`) |
| Projet ne démarre pas | Vérifier Node ≥ 18, puis `npm install && npm run dev` |

## 🤝 Contribution

Toute contribution est la bienvenue ! Ouvrez une *issue* ou une *pull request* pour ajouter une bibliothèque UI/UX, corriger un bug ou améliorer les templates. Merci de suivre la structure existante (un fichier par bibliothèque, sourcé par `index.ps1` / `index.sh`).
