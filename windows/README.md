<div align="center">

# ⚡ ReactJS Project Aliases — Windows

### Scaffold des projets **React 19** complets directement depuis **PowerShell**

Des fonctions courtes et mémorisables qui remplacent les longues séquences de configuration par une seule commande.

[![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-5391FE?style=for-the-badge&logo=powershell&logoColor=white)](https://learn.microsoft.com/powershell/)
[![Windows](https://img.shields.io/badge/Windows-ready-0078D6?style=for-the-badge&logo=windows&logoColor=white)](https://www.microsoft.com/windows)
[![Node.js](https://img.shields.io/badge/Node.js-18%2B-339933?style=for-the-badge&logo=nodedotjs&logoColor=white)](https://nodejs.org/)
[![React](https://img.shields.io/badge/React-19-61DAFB?style=for-the-badge&logo=react&logoColor=black)](https://react.dev/)
[![Vite](https://img.shields.io/badge/Vite-6-646CFF?style=for-the-badge&logo=vite&logoColor=white)](https://vite.dev/)
[![TypeScript](https://img.shields.io/badge/TypeScript-5-3178C6?style=for-the-badge&logo=typescript&logoColor=white)](https://www.typescriptlang.org/)

</div>

---

## 📑 Table des matières

- [✨ Aperçu](#-aperçu)
- [🧰 Prérequis](#-prérequis)
- [📦 Installation](#-installation)
- [🚀 Utilisation](#-utilisation)
- [📖 Aide intégrée](#-aide-intégrée)
- [🧹 Désinstallation](#-désinstallation)
- [🛟 Dépannage](#-dépannage)
- [🤝 Contribution](#-contribution)

---

## ✨ Aperçu

Au lieu de taper de longues commandes de configuration répétitives, vous utilisez des fonctions courtes qui scaffoldent un projet React complet, pré-configuré et prêt à coder en quelques secondes :

```powershell
New-React myapp          # scaffold un projet React + Vite + TypeScript au choix
New-ReactVite myapp      # scaffold uniquement le template de base
Install-Prettier         # configure Prettier sur le projet courant
```

Les raccourcis sont organisés en modules thématiques chargés automatiquement depuis un **point d'entrée unique** : une seule ligne suffit dans votre profil PowerShell. Chaque template embarque le routeur, le sélecteur de thème (Clair / Sombre / Système), l'alias `@` pointant vers `src/`, une page d'accueil et une page 404 stylées, ainsi qu'une configuration Vite/TypeScript optimisée.

---

## 🧰 Prérequis

| Exigence | Détail |
|---|---|
| **Système** | Windows 10 ou 11 |
| **Shell** | Windows PowerShell 5.1+ ou PowerShell 7 |
| **Node.js** | Version 18.18+ ou 20+ (LTS recommandée) |
| **npm** | Inclus avec Node.js, disponible dans le `PATH` |
| **Git** | [Git for Windows](https://git-scm.com/download/win) installé et disponible dans le `PATH` |

---

## 📦 Installation

### 1. Copier le module dans votre répertoire de configuration

```powershell
New-Item -ItemType Directory -Path "$HOME\.config\alias" -Force
Copy-Item -Path "react-aliases-project" -Destination "$HOME\.config\alias\react-aliases-project\" -Recurse
```

> 💡 Le module se trouve dans le sous-dossier `windows\` (`windows\index.ps1`, `windows\materialUI.ps1`, …).

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
notepad $PROFILE
```

ou avec Visual Studio Code :

```powershell
code $PROFILE
```

### 4. Importer les raccourcis

Ajoutez la ligne suivante à votre profil :

```powershell
. "$HOME\.config\alias\react-aliases-project\windows\index.ps1"
```

`index.ps1` est le point d'entrée. Il source (`dot-source`) chaque module situé dans le même répertoire, si bien que les raccourcis fonctionnent quel que soit l'endroit où le projet a été copié.

### 5. Recharger votre profil

```powershell
. $PROFILE
```

---

## 🚀 Utilisation

Les raccourcis se comportent comme des commandes PowerShell natives :

```powershell
New-React myapp        # scaffold un nouveau projet React avec la bibliothèque UI de votre choix
New-ReactVite myapp    # scaffold un projet Vite + React + TS de base
Install-Prettier       # configure Prettier sur le projet courant
Get-Help New-React     # afficher les paramètres et exemples
```

### 📦 Créer un projet

```powershell
New-React myapp
```

Un menu interactif vous propose la bibliothèque UI/UX à embarquer. Le nom du projet est optionnel : laissez vide pour le saisir interactivement.

| # | Template               | Description                                   |
|---|------------------------|-----------------------------------------------|
| 1 | Vite + React (base)    | Template React + TypeScript simple            |
| 2 | Vite + Material UI     | Google Material Design components             |
| 3 | Vite + Shadcn UI       | Tailwind + Radix accessible components        |
| 4 | Vite + Hero UI         | Tailwind + React Aria components              |
| 5 | Vite + Chakra UI       | Composants accessibles et headless-friendly   |
| 6 | Vite + React Bootstrap | Bootstrap components pour React               |
| 7 | Vite + Mantine         | Bibliothèque moderne orientée hooks           |
| 8 | Vite + Ant Design      | Design system d'entreprise                    |
| 9 | Vite + DaisyUI         | Composants CSS purs basés sur Tailwind        |

Chaque template génère l'arborescence complète (`src/components`, `src/layouts`, `src/pages`, `src/routes`, `src/styles`, `src/theme`), installe les dépendances, configure l'alias `@` (`vite.config.ts` + `tsconfig.app.json`) et démarre le serveur de dev sur le port `5173` (navigateur ouvert automatiquement).

> 💡 Les bibliothèques basées sur Tailwind (Shadcn, Hero UI, DaisyUI, Material UI) embarquent un sélecteur de thème **Clair / Sombre / Système** avec icônes ; en mode *Système*, le thème suit automatiquement les préférences de l'OS.

---

## 📖 Aide intégrée

| Commande | Description |
|---|---|
| `Get-Help <fonction>` | Documentation commentée de n'importe quel raccourci (paramètres, exemples) |

```powershell
Get-Help New-React
Get-Help New-ReactViteMaterialUi
Get-Help New-ReactViteShadecnUi
```

---

## 🧹 Désinstallation

1. Supprimez la ligne d'import de `$PROFILE`.
2. Supprimez le répertoire :

```powershell
Remove-Item -Path "$HOME\.config\alias\react-aliases-project" -Recurse -Force
```

---

## 🛟 Dépannage

| Symptôme | Solution |
|---|---|
| Les raccourcis sont indisponibles | Vérifiez le chemin d'import dans `$PROFILE`, puis rechargez avec `. $PROFILE`. |
| `npm is not recognized` | Installez [Node.js LTS](https://nodejs.org/) et assurez-vous qu'il est disponible dans le `PATH`. |
| Port `5173` déjà utilisé | Modifiez `server.port` dans le `vite.config.ts` du projet créé. |
| `npx shadcn` échoue | Vérifiez votre connexion réseau et que Node.js est à jour. |

---

## 🤝 Contribution

Voir le [README du dépôt](https://github.com/raharison-joshue-agape/ps-react-project#readme) pour les consignes de contribution, ou [ouvrir une issue](https://github.com/raharison-joshue-agape/ps-react-project/issues).
