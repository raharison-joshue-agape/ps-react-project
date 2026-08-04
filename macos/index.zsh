#!/usr/bin/env zsh
# index.zsh — Point d'entrée macOS (zsh) : charge tous les modules React scaffolding.
# Usage : . "$HOME/.config/alias/react-aliases-project/macos/index.zsh"

_react_aliases_root="${0:A:h}"

. "$_react_aliases_root/materialUI.zsh"
. "$_react_aliases_root/shadecnUI.zsh"
. "$_react_aliases_root/heroUI.zsh"
. "$_react_aliases_root/chakraUI.zsh"
. "$_react_aliases_root/reactBootstrap.zsh"
. "$_react_aliases_root/antd.zsh"
. "$_react_aliases_root/mantine.zsh"
. "$_react_aliases_root/daisyui.zsh"
. "$_react_aliases_root/primereact.zsh"

install_prettier() {
    echo "Installation de Prettier..."
    npm install -D prettier
    npm pkg set scripts.format="prettier --write ."

    cat > .prettierrc <<'EOF'
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
EOF

    cat > .prettierignore <<'EOF'
node_modules/
dist/
build/
coverage/
.vite/
EOF

    echo "Prettier a été installé et configuré avec succès !"
    echo 'Exécutez `npm run format` pour formater votre projet.'
}

new_react_vite() {
    local PROJECT_NAME="$1"
    npx create-vite@latest "$PROJECT_NAME" --template react-ts --no-immediate
}

new_react() {
    local PROJECT_NAME="${1:-}"

    echo ""
    echo "  🚀 ReactJS Project Scaffolder"
    echo "  ============================="
    echo ""
    echo "  1. Vite + React (base)"
    echo "     Plain React + TypeScript template"
    echo "  2. Vite + Material UI"
    echo "     Google Material Design components"
    echo "  3. Vite + Shadcn UI"
    echo "     Tailwind + Radix accessible components"
    echo "  4. Vite + Hero UI"
    echo "     Tailwind + React Aria components"
    echo "  5. Vite + Chakra UI"
    echo "     Headless-friendly component library"
    echo "  6. Vite + React Bootstrap"
    echo "     Bootstrap components for React"
    echo "  7. Vite + Mantine"
    echo "     Modern hooks-first component library"
    echo "  8. Vite + Ant Design"
    echo "     Enterprise UI design system"
    echo "  9. Vite + DaisyUI"
    echo "     Pure CSS Tailwind components"
    echo "  10. Vite + PrimeReact"
    echo "     Enterprise-ready UI component library"
    echo ""

    local PROJECT_CHOICE
    read -r "PROJECT_CHOICE?Enter choice (1-10): "

    if [ -z "$PROJECT_NAME" ]; then
        read -r "PROJECT_NAME?Project name: "
    fi

    case "$PROJECT_CHOICE" in
        1) new_react_vite "$PROJECT_NAME" ;;
        2) new_react_vite_material_ui "$PROJECT_NAME" ;;
        3) new_react_vite_shadecn_ui "$PROJECT_NAME" ;;
        4) new_react_vite_hero_ui "$PROJECT_NAME" ;;
        5) new_react_vite_chakra_ui "$PROJECT_NAME" ;;
        6) new_react_vite_bootstrap "$PROJECT_NAME" ;;
        7) new_react_vite_mantine "$PROJECT_NAME" ;;
        8) new_react_vite_antd "$PROJECT_NAME" ;;
        9) new_react_vite_daisy_ui "$PROJECT_NAME" ;;
        10) new_react_vite_primereact "$PROJECT_NAME" ;;
        *)
            echo "Choix invalide. Création d'un projet Vite de base."
            new_react_vite "$PROJECT_NAME"
            ;;
    esac
}
