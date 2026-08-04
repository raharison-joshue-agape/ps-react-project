#!/usr/bin/env bash
# index.sh — Point d'entrée Linux (bash) : charge tous les modules React scaffolding.
# Usage : . "$HOME/.config/alias/react-aliases-project/linux/index.sh"

_react_aliases_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

. "$_react_aliases_root/materialUI.sh"
. "$_react_aliases_root/shadecnUI.sh"
. "$_react_aliases_root/heroUI.sh"
. "$_react_aliases_root/chakraUI.sh"
. "$_react_aliases_root/reactBootstrap.sh"
. "$_react_aliases_root/antd.sh"
. "$_react_aliases_root/mantine.sh"
. "$_react_aliases_root/daisyui.sh"
. "$_react_aliases_root/primereact.sh"
. "$_react_aliases_root/fluent.sh"
. "$_react_aliases_root/semantic.sh"
. "$_react_aliases_root/grommet.sh"
. "$_react_aliases_root/arco.sh"
. "$_react_aliases_root/radix.sh"
. "$_react_aliases_root/headless.sh"
. "$_react_aliases_root/spectrum.sh"

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
    echo "  11. Vite + Fluent UI"
    echo "     Microsoft design system components"
    echo "  12. Vite + Semantic UI React"
    echo "     Themeable CSS component framework"
    echo "  13. Vite + Grommet"
    echo "     Accessible enterprise component library"
    echo "  14. Vite + Arco Design"
    echo "     ByteDance enterprise UI components"
    echo "  15. Vite + Radix UI"
    echo "     Headless accessible UI primitives"
    echo "  16. Vite + Headless UI"
    echo "     Unstyled accessible components"
    echo "  17. Vite + React Spectrum"
    echo "     Adobe's accessible UI components"
    echo ""

    local PROJECT_CHOICE
    read -r -p "Enter choice (1-17): " PROJECT_CHOICE

    if [ -z "$PROJECT_NAME" ]; then
        read -r -p "Project name: " PROJECT_NAME
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
        11) new_react_vite_fluent "$PROJECT_NAME" ;;
        12) new_react_vite_semantic "$PROJECT_NAME" ;;
        13) new_react_vite_grommet "$PROJECT_NAME" ;;
        14) new_react_vite_arco "$PROJECT_NAME" ;;
        15) new_react_vite_radix "$PROJECT_NAME" ;;
        16) new_react_vite_headless "$PROJECT_NAME" ;;
        17) new_react_vite_spectrum "$PROJECT_NAME" ;;
        *)
            echo "Choix invalide. Création d'un projet Vite de base."
            new_react_vite "$PROJECT_NAME"
            ;;
    esac
}
