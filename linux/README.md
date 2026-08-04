<div align="center">

# ⚡ ReactJS Project Aliases — Linux

### Scaffold des projets **React 19 + Vite + TypeScript** pré-configurés directement depuis **Bash**

Des fonctions courtes et mémorisables qui remplacent les longues séquences de configuration par une seule commande.

[![Bash](https://img.shields.io/badge/Bash-4.0%2B-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Linux](https://img.shields.io/badge/Linux-ready-FCC624?style=for-the-badge&logo=linux&logoColor=black)](https://www.linux.org/)
[![Node.js](https://img.shields.io/badge/Node.js-18%2B-339933?style=for-the-badge&logo=nodedotjs&logoColor=white)](https://nodejs.org/)
[![React](https://img.shields.io/badge/React-19-61DAFB?style=for-the-badge&logo=react&logoColor=white)](https://react.dev/)
[![Vite](https://img.shields.io/badge/Vite-ready-646CFF?style=for-the-badge&logo=vite&logoColor=white)](https://vite.dev/)
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

Au lieu de taper de longues commandes de configuration répétitives, vous utilisez des fonctions courtes qui scaffoldent un projet **React 19 + Vite + TypeScript** complet et pré-configuré en quelques secondes :

```bash
new_react myapp            # menu interactif : 9 bibliothèques UI/UX au choix
new_react_vite myapp       # template Vite + React + TypeScript de base
new_react_vite_mantine myapp   # scaffold direct avec une bibliothèque précise
install_prettier           # configure Prettier dans le projet courant
```

Les raccourcis sont organisés en modules thématiques chargés automatiquement depuis un **point d'entrée unique** : une seule ligne suffit dans votre `~/.bashrc`. La syntaxe est identique à celle de la [version Windows](../README.md#-installation-windows) (`new_react` ⇄ `New-React`).

---

## 🧰 Prérequis

| Exigence | Détail |
|---|---|
| **Système** | Toute distribution Linux récente |
| **Shell** | Bash 4.0+ (shell par défaut) |
| **Git** | Installé et accessible dans le `PATH` (initialisation Git optionnelle) |
| **Node.js** | Node.js 18+ avec `npm` disponible dans le `PATH` (utilisé pour scaffolder et installer les dépendances) |

---

## 📦 Installation

### 1. Copier les fichiers dans votre répertoire de configuration

```bash
mkdir -p ~/.config/alias
cp -r linux ~/.config/alias/react-aliases-project/
```

### 2. Ouvrir votre fichier de configuration shell

```bash
nano ~/.bashrc
```

### 3. Importer les alias

Ajoutez cette ligne à la fin du fichier :

```bash
. ~/.config/alias/react-aliases-project/linux/index.sh
```

`index.sh` est le point d'entrée. Il source chaque module situé dans son propre répertoire, si bien que les raccourcis fonctionnent quel que soit l'endroit où le projet a été copié.

### 4. Recharger votre configuration

```bash
source ~/.bashrc
```

### 5. Créer votre premier projet

```bash
new_react myapp
cd myapp && npm run dev     # → http://localhost:5173
```

---

## 🚀 Utilisation

Les raccourcis se comportent comme des commandes shell natives :

```bash
new_react myapp            # scaffolde un projet (menu interactif 1-9)
new_react_vite myapp       # template Vite + React + TS de base
new_react_vite_material_ui myapp   # Material UI
new_react_vite_daisy_ui myapp      # DaisyUI
install_prettier           # configure Prettier (optionnel)
type new_react             # affiche la définition
```

### 📦 Créer un projet

```bash
new_react myapp
```

Affiche un menu interactif, crée le projet avec `create-vite` (sans lancer le serveur avant configuration grâce à `--no-immediate`), installe les dépendances de la bibliothèque choisie, puis pré-configure l'alias `@`, React Router et le sélecteur de thème.

> 💡 Le nom du projet est optionnel : laissez vide pour le saisir interactivement.

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

À la fin de la configuration, le script demande si vous voulez **Prettier** et **Git**, puis lance `npm run dev` (serveur sur **http://localhost:5173**).

### 🎨 Créer un projet avec une bibliothèque précise

```bash
new_react_vite_material_ui myapp
new_react_vite_shadecn_ui myapp
new_react_vite_hero_ui myapp
new_react_vite_chakra_ui myapp
new_react_vite_bootstrap myapp
new_react_vite_mantine myapp
new_react_vite_antd myapp
new_react_vite_daisy_ui myapp
```

### 🖥️ Créer un projet Vite de base

```bash
new_react_vite myapp
```

Crée un projet **Vite + React + TypeScript** (template `react-ts` de `create-vite`) sans bibliothèque supplémentaire.

### 📝 Configurer Prettier

```bash
install_prettier
```

Installe Prettier en dépendance de développement, ajoute le script `npm run format`, et génère `.prettierrc` + `.prettierignore` (semi, single quotes, trailing commas, printWidth 100, tabWidth 4, endOfLine `lf`).

### 🧱 Ce que chaque template inclut

| Élément | Détail |
|---|---|
| **React 19 + TypeScript** | Généré avec `create-vite` (`react-ts`) |
| **Alias `@`** | → `src/` dans `vite.config.ts` et `tsconfig.app.json` (`paths: { "@/*": ["./src/*"] }`) |
| **React Router** | Layout par défaut, page `/home` et page **404** personnalisée |
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

---

## 📖 Aide intégrée

| Commande | Description |
|---|---|
| `type <fonction>` | Affiche la définition de n'importe quel raccourci |

```bash
type new_react
type new_react_vite_mantine
declare -f new_react_vite_material_ui
```

---

## 🧹 Désinstallation

1. Supprimez la ligne d'import de `~/.bashrc`.
2. Supprimez le répertoire :

```bash
rm -rf ~/.config/alias/react-aliases-project
```

---

## 🛟 Dépannage

| Symptôme | Solution |
|---|---|
| Les raccourcis sont indisponibles | Vérifiez le chemin d'import dans `~/.bashrc`, puis rechargez avec `source ~/.bashrc`. |
| `command not found: node` | Installez Node.js 18+ et assurez-vous qu'il est disponible dans le `PATH`. |
| Le serveur de dev ne démarre pas | Vérifiez que `npm install` a été exécuté (avec `--no-immediate`, create-vite n'installe pas automatiquement). |
| Alias `@` non résolu | Relancez `npm install` (alias défini dans `vite.config.ts` + `tsconfig.app.json`). |
| Module introuvable | Un fichier de module est absent — réinstallez le dossier `linux/` en entier. |

---

## 🤝 Contribution

Voir le [README du dépôt](../README.md#-contribution) pour les consignes de contribution, ou ouvrez une *issue*.
