<div align="center">

# ⚡ ReactJS Project Aliases — macOS

### Scaffold des projets **React 19 + Vite + TypeScript** pré-configurés directement depuis **Zsh**

Des fonctions courtes et mémorisables qui remplacent les longues séquences de configuration par une seule commande.

[![Zsh](https://img.shields.io/badge/Zsh-5.8%2B-4EAA25?style=for-the-badge&logo=zsh&logoColor=white)](https://www.zsh.org/)
[![macOS](https://img.shields.io/badge/macOS-ready-000000?style=for-the-badge&logo=apple&logoColor=white)](https://www.apple.com/macos/)
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

```zsh
new_react myapp            # menu interactif : 16 bibliothèques UI/UX au choix
new_react_vite myapp       # template Vite + React + TypeScript de base
new_react_vite_mantine myapp   # scaffold direct avec une bibliothèque précise
install_prettier           # configure Prettier dans le projet courant
```

Les raccourcis sont organisés en modules thématiques chargés automatiquement depuis un **point d'entrée unique** : une seule ligne suffit dans votre `~/.zshrc`. La syntaxe est identique à celle de la [version Linux](../README.md#-installation-linux) — **macOS expose les mêmes noms de fonctions** (`new_react`, `new_react_vite_*`).

> 💡 Les scripts sont écrits en **zsh** (aucune dépendance bash ni outil GNU) : uniquement des outils BSD de macOS et des fonctions zsh natives.

---

## 🧰 Prérequis

| Exigence | Détail |
|---|---|
| **Système** | macOS 10.15 (Catalina) ou ultérieur |
| **Shell** | Zsh 5.8+ (shell par défaut depuis macOS Catalina) |
| **Git** | Outils de développement Xcode installés (`xcode-select --install`) |
| **Node.js** | Node.js 18+ avec `npm` disponible dans le `PATH` (utilisé pour scaffolder et installer les dépendances) |

---

## 📦 Installation

### 1. Copier les fichiers dans votre répertoire de configuration

```zsh
mkdir -p ~/.config/alias
cp -r macos ~/.config/alias/react-aliases-project/
```

### 2. Ouvrir votre fichier de configuration shell

```zsh
nano ~/.zshrc
```

### 3. Importer les alias

Ajoutez cette ligne à la fin du fichier :

```zsh
. ~/.config/alias/react-aliases-project/macos/index.zsh
```

`index.zsh` est le point d'entrée. Il source chaque module situé dans son propre répertoire, si bien que les raccourcis fonctionnent quel que soit l'endroit où le projet a été copié.

### 4. Recharger votre configuration

```zsh
source ~/.zshrc
```

### 5. Créer votre premier projet

```zsh
new_react myapp
cd myapp && npm run dev     # → http://localhost:5173
```

---

## 🚀 Utilisation

Les raccourcis se comportent comme des commandes shell natives :

```zsh
new_react myapp            # scaffolde un projet (menu interactif 1-17)
new_react_vite myapp       # template Vite + React + TS de base
new_react_vite_material_ui myapp   # Material UI
new_react_vite_daisy_ui myapp      # DaisyUI
install_prettier           # configure Prettier (optionnel)
whence -f new_react        # affiche la définition
```

### 📦 Créer un projet

```zsh
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
| 10 | Vite + PrimeReact       | Enterprise-ready UI component library         |
| 11 | Vite + Fluent UI        | Microsoft design system components            |
| 12 | Vite + Semantic UI React | Themeable CSS component framework            |
| 13 | Vite + Grommet          | Accessible enterprise component library       |
| 14 | Vite + Arco Design      | ByteDance enterprise UI components            |
| 15 | Vite + Radix UI         | Headless accessible UI primitives             |
| 16 | Vite + Headless UI      | Unstyled accessible components                |
| 17 | Vite + React Spectrum   | Adobe's accessible UI components              |

À la fin de la configuration, le script demande si vous voulez **Prettier** et **Git**, puis lance `npm run dev` (serveur sur **http://localhost:5173**).

### 🎨 Créer un projet avec une bibliothèque précise

```zsh
new_react_vite_material_ui myapp
new_react_vite_shadecn_ui myapp
new_react_vite_hero_ui myapp
new_react_vite_chakra_ui myapp
new_react_vite_bootstrap myapp
new_react_vite_mantine myapp
new_react_vite_antd myapp
new_react_vite_daisy_ui myapp
new_react_vite_primereact myapp
new_react_vite_fluent myapp
new_react_vite_semantic myapp
new_react_vite_grommet myapp
new_react_vite_arco myapp
new_react_vite_radix myapp
new_react_vite_headless myapp
new_react_vite_spectrum myapp
```

### 🖥️ Créer un projet Vite de base

```zsh
new_react_vite myapp
```

Crée un projet **Vite + React + TypeScript** (template `react-ts` de `create-vite`) sans bibliothèque supplémentaire.

### 📝 Configurer Prettier

```zsh
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
| PrimeReact | Boutons `Button` (groupe d'icônes) |
| Fluent UI | `Select` Fluent + `FluentProvider` |
| Semantic UI React | `Select` Semantic UI |
| Grommet | `Select` Grommet + `themeMode` |
| Arco Design | `Radio.Group` type="button" |
| Radix UI | `DropdownMenu` |
| Headless UI | `Menu` |
| React Spectrum | `Picker` + `colorScheme` |

---

## 📖 Aide intégrée

| Commande | Description |
|---|---|
| `type <fonction>` | Affiche la définition de n'importe quel raccourci |
| `whence -f <fonction>` | Affiche la définition complète (zsh) |

```zsh
type new_react
whence -f new_react_vite_mantine
```

---

## 🧹 Désinstallation

1. Supprimez la ligne d'import de `~/.zshrc`.
2. Supprimez le répertoire :

```zsh
rm -rf ~/.config/alias/react-aliases-project
```

---

## 🛟 Dépannage

| Symptôme | Solution |
|---|---|
| Les raccourcis sont indisponibles | Vérifiez le chemin d'import dans `~/.zshrc`, puis rechargez avec `source ~/.zshrc`. |
| `command not found: node` | Installez Node.js 18+ (via `brew install node`) et vérifiez le `PATH`. |
| Le serveur de dev ne démarre pas | Vérifiez que `npm install` a été exécuté (avec `--no-immediate`, create-vite n'installe pas automatiquement). |
| Alias `@` non résolu | Relancez `npm install` (alias défini dans `vite.config.ts` + `tsconfig.app.json`). |
| Module introuvable | Un fichier de module est absent — réinstallez le dossier `macos/` en entier. |

---

## 🤝 Contribution

Voir le [README du dépôt](../README.md#-contribution) pour les consignes de contribution, ou ouvrez une *issue*.
