# 🚀 ReactJS Project Aliases PowerShell Windows – Documentation

![GitHub repo size](https://img.shields.io/github/repo-size/raharison-joshue-agape/ps-react-project)
![GitHub stars](https://img.shields.io/github/stars/raharison-joshue-agape/ps-react-project?style=social)
![GitHub forks](https://img.shields.io/github/forks/raharison-joshue-agape/ps-react-project?style=social)
![GitHub issues](https://img.shields.io/github/issues/raharison-joshue-agape/ps-react-project)
![License](https://img.shields.io/github/license/raharison-joshue-agape/ps-react-project)
![PowerShell](https://img.shields.io/badge/PowerShell-Ready-blue?logo=powershell)

A practical guide to setting up ReactJS project aliases in PowerShell. This setup helps streamline your workflow and boost productivity in the command line.

## ⚙️ PowerShell Profile Setup

Before using the aliases, you need to configure your PowerShell profile.

### Check if the profile exists

```bash
Test-Path $PROFILE
```

True → the profile already exists
False → proceed to the next step

### Create the profile

```bash
New-Item -Path $PROFILE -ItemType File -Force
```

### Open and edit the profile

- Using VS Code:

```bash
code $PROFILE
```

## 📦 Install Aliases

### Clone the repository

```bash
git clone https://github.com/raharison-joshue-agape/ps-react-project.git react-aliases-project
```

### Copy alias files to config directory

```bash
cp react-aliases-project "$HOME\.config\alias\"
```

💡 Make sure the directory exists, otherwise create it:

```bash
mkdir -p "$HOME\.config\alias\"
```

### Import aliases into PowerShell

Add the following line to your PowerShell profile

```bash
. "$HOME\.config\alias\react-aliases-project\index.ps1"
```

### Apply changes

Reload your profile

```bash
. $PROFILE
```

### ✅ Done

Your aliases are now active 🎉
You can start using them immediately to speed up your workflow.

## ⚙️ CLI Commands

🚀 To Create a New Project
Quickly scaffold a new ReactJS + Vite + TypeScript project using:

```bash
New-React project_name
```

An interactive menu lets you pick your favorite UI / UX library:

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

## 🎨 What every template includes

- **React 19 + TypeScript** scaffolded with `create-vite`
- **`@` alias** pointing to `src/` in both `vite.config.ts` and `tsconfig.app.json`
- **React Router** with a ready-to-use layout, `/home` page and a styled 404 page
- **Theme toggle** (Light / Dark / System) with icons that follows the OS when set to *System*
- **Prettier** (optional) with a consistent formatting config
- **Git initialization** (optional)
- Dev server on port `5173`, opens the browser automatically (`server.open = true`)

## 💡 Tips

- Restart PowerShell if changes don't apply
- Double-check file paths if aliases aren't working
- Customize your aliases in **index.ps1** to match your needs
