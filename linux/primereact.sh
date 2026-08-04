#!/usr/bin/env bash
# primereact.sh — Crée un projet Vite + React 19 + PrimeReact + TypeScript pré-configuré.

new_react_vite_primereact() {
    local PROJECT_NAME="${1:-}"

    if [ -z "$PROJECT_NAME" ]; then
        read -r -p "Project name: " PROJECT_NAME
    fi

    echo "Creating project: $PROJECT_NAME (Vite + React 19 + PrimeReact + TypeScript)"
    npx create-vite@latest "$PROJECT_NAME" --template react-ts --no-immediate

    cd "$PROJECT_NAME" || return 1

    clear
    echo "Installing dependencies..."
    npm install primereact primeicons react-router-dom @primeuix/themes

    local PRETTIE
    read -r -p "Would you like to install Prettier? (Y/N): " PRETTIE
    if [[ "$PRETTIE" =~ ^[Yy] ]]; then
        install_prettier
    fi

    rm -f src/App.css src/index.css src/App.tsx

    mkdir -p src/components src/layouts src/pages src/routes src/styles src/theme

    cat > vite.config.ts <<'EOF'
import { defineConfig } from 'vite';
import { fileURLToPath, URL } from 'node:url';
import react from '@vitejs/plugin-react';

// https://vite.dev/config/
export default defineConfig({
    server: {
        port: 5173,
        host: '0.0.0.0',
        open: true,
    },
    plugins: [react()],
    resolve: {
        alias: {
            '@': fileURLToPath(new URL('./src', import.meta.url)),
        },
    },
});
EOF

    cat > tsconfig.app.json <<'EOF'
{
    "compilerOptions": {
        "tsBuildInfoFile": "./node_modules/.tmp/tsconfig.app.tsbuildinfo",
        "target": "ES2022",
        "useDefineForClassFields": true,
        "lib": ["ES2022", "DOM", "DOM.Iterable"],
        "module": "ESNext",
        "types": ["vite/client"],
        "skipLibCheck": true,

        /* Bundler mode */
        "moduleResolution": "bundler",
        "allowImportingTsExtensions": true,
        "verbatimModuleSyntax": true,
        "moduleDetection": "force",
        "noEmit": true,
        "jsx": "react-jsx",

        /* Linting */
        "strict": true,
        "noUnusedLocals": true,
        "noUnusedParameters": true,
        "erasableSyntaxOnly": true,
        "noFallthroughCasesInSwitch": true,
        "noUncheckedSideEffectImports": true,

        /* Alias @ = src */
        "paths": {
            "@/*": ["./src/*"]
        }
    },
    "include": ["src"]
}
EOF

    cat > src/main.tsx <<'EOF'
import '@/styles/index.css';

import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';
import { RouterProvider } from 'react-router-dom';
import { PrimeReactProvider } from '@primereact/core';
import Aura from '@primeuix/themes/aura';
import router from '@/routes';

import { ThemeProviderWrapper } from '@/theme/ThemeContext';

const primereactConfig = {
    theme: {
        preset: Aura,
        options: {
            darkModeSelector: '.app-dark',
        },
    },
};

createRoot(document.getElementById('root')!).render(
    <StrictMode>
        <ThemeProviderWrapper>
            <PrimeReactProvider {...primereactConfig}>
                <RouterProvider router={router} />
            </PrimeReactProvider>
        </ThemeProviderWrapper>
    </StrictMode>,
);
EOF

    cat > src/theme/ThemeContext.tsx <<'EOF'
import { createContext, type ReactNode, useContext, useEffect, useState } from 'react';

type ThemeMode = 'light' | 'dark' | 'system';

interface ThemeContextType {
    mode: ThemeMode;
    setMode: (mode: ThemeMode) => void;
}

const ThemeContext = createContext<ThemeContextType | undefined>(undefined);

export function UseThemeMode() {
    const context = useContext(ThemeContext);
    if (!context) throw new Error('useThemeMode must be used within ThemeProviderWrapper');
    return context;
}

interface Props {
    children: ReactNode;
}

export function ThemeProviderWrapper({ children }: Props) {
    const [mode, setMode] = useState<ThemeMode>(() => {
        return (localStorage.getItem('theme') as ThemeMode) || 'system';
    });
    const [systemDark, setSystemDark] = useState(() =>
        window.matchMedia('(prefers-color-scheme: dark)').matches,
    );

    useEffect(() => {
        const media = window.matchMedia('(prefers-color-scheme: dark)');
        const onChange = () => setSystemDark(media.matches);
        media.addEventListener('change', onChange);
        return () => media.removeEventListener('change', onChange);
    }, []);

    const isDark = mode === 'system' ? systemDark : mode === 'dark';

    useEffect(() => {
        document.documentElement.classList.toggle('app-dark', isDark);
        localStorage.setItem('theme', mode);
    }, [mode, isDark]);

    return (
        <ThemeContext.Provider value={{ mode, setMode }}>{children}</ThemeContext.Provider>
    );
}
EOF

    cat > src/styles/index.css <<'EOF'
@import 'primeicons/primeicons.css';

html {
    scroll-behavior: smooth;
}

.app-shell {
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap: 1.5rem;
    padding: 2.5rem 1.5rem;
    text-align: center;
    background: linear-gradient(135deg, #f8fafc 0%, #ffffff 50%, #eef2ff 100%);
    color: #0f172a;
}

.app-dark .app-shell {
    background: linear-gradient(135deg, #020617 0%, #0f172a 50%, #1e1b4b 100%);
    color: #f1f5f9;
}

.app-hero-icon {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 80px;
    height: 80px;
    border-radius: 24px;
    font-size: 2.25rem;
    color: #ffffff;
    background: linear-gradient(135deg, #06b6d4, #a855f7);
    box-shadow: 0 12px 30px rgba(6, 182, 212, 0.35);
}

.app-title {
    font-size: clamp(1.75rem, 4vw, 2.5rem);
    font-weight: 800;
    letter-spacing: -0.025em;
    margin: 0;
}

.app-text {
    max-width: 40rem;
    margin: 0;
    line-height: 1.7;
    color: #475569;
}

.app-dark .app-text {
    color: #cbd5e1;
}

.app-badge i {
    margin-right: 0.4rem;
}

.app-buttons {
    display: flex;
    gap: 0.75rem;
    flex-wrap: wrap;
    justify-content: center;
}

.app-buttons .p-button i,
.theme-toggle-btn i {
    margin-right: 0.4rem;
}

.app-toggle {
    position: fixed;
    top: 1.25rem;
    right: 1.25rem;
    z-index: 50;
    display: flex;
    gap: 0.25rem;
}
EOF

    cat > src/routes/index.tsx <<'EOF'
import { createBrowserRouter, Navigate } from 'react-router-dom';
import DefaultLayout from '@/layouts/default';
import Home from '@/pages/Home';
import NotFound from '@/pages/NotFound';

const router = createBrowserRouter([
    {
        path: '/',
        element: <DefaultLayout />,
        children: [
            { index: true, element: <Navigate to="/home" /> },
            { path: '/home', element: <Home /> },
        ],
    },

    { path: '*', element: <NotFound /> },
]);

export default router;
EOF

    cat > src/pages/Home.tsx <<'EOF'
import { Button } from 'primereact/button';
import { Tag } from 'primereact/tag';
import ToggleMode from '@/components/ToggleMode';

export default function Home() {
    return (
        <main className="app-shell">
            <Tag severity="info" rounded className="app-badge">
                <i className="pi pi-bolt" />
                React 19 • PrimeReact
            </Tag>

            <div className="app-hero-icon">
                <i className="pi pi-home" />
            </div>

            <h1 className="app-title">Bienvenue sur votre projet React</h1>

            <p className="app-text">
                Ce projet est pré-configuré avec <strong>PrimeReact</strong>,{' '}
                <strong>PrimeIcons</strong> et <strong>React Router</strong> pour un
                développement rapide et élégant.
            </p>

            <div className="app-buttons">
                <Button type="button" size="large">
                    <i className="pi pi-bolt" />
                    Démarrer
                </Button>

                <Button type="button" size="large" severity="secondary" variant="outlined">
                    <i className="pi pi-book" />
                    Documentation
                </Button>
            </div>

            <ToggleMode className="app-toggle" />
        </main>
    );
}
EOF

    cat > src/pages/NotFound.tsx <<'EOF'
import { Button } from 'primereact/button';
import { Tag } from 'primereact/tag';
import { Link, useNavigate } from 'react-router-dom';
import ToggleMode from '@/components/ToggleMode';

export default function NotFound() {
    const navigate = useNavigate();

    return (
        <main className="app-shell">
            <Tag severity="danger" rounded className="app-badge">
                <i className="pi pi-ban" />
                Erreur 404
            </Tag>

            <div className="app-hero-icon">
                <i className="pi pi-exclamation-triangle" />
            </div>

            <h1 className="app-title">Page introuvable</h1>

            <p className="app-text">
                Oups... la page que vous cherchez semble avoir disparu 🫥 <br />
                Vérifiez l'URL ou revenez à une page connue.
            </p>

            <div className="app-buttons">
                <Button type="button" size="large" onClick={() => navigate(-1)}>
                    <i className="pi pi-arrow-left" />
                    Retour
                </Button>

                <Link to="/">
                    <Button type="button" size="large" severity="secondary" variant="outlined">
                        <i className="pi pi-home" />
                        Accueil
                    </Button>
                </Link>
            </div>

            <ToggleMode className="app-toggle" />
        </main>
    );
}
EOF

    cat > src/layouts/default.tsx <<'EOF'
import { Outlet } from 'react-router-dom';

export default function DefaultLayout() {
    return <Outlet />;
}
EOF

    cat > src/components/ToggleMode.tsx <<'EOF'
import { Button } from 'primereact/button';
import { UseThemeMode } from '@/theme/ThemeContext';

const OPTIONS = [
    { value: 'system', label: 'System', icon: 'pi-desktop' },
    { value: 'light', label: 'Light', icon: 'pi-sun' },
    { value: 'dark', label: 'Dark', icon: 'pi-moon' },
] as const;

export default function ToggleMode({ className }: { className?: string }) {
    const { mode, setMode } = UseThemeMode();

    return (
        <div className={className}>
            {OPTIONS.map(({ value, label, icon }) => (
                <Button
                    key={value}
                    type="button"
                    size="small"
                    severity="secondary"
                    variant={mode === value ? undefined : 'outlined'}
                    className="theme-toggle-btn"
                    onClick={() => setMode(value)}
                >
                    <i className={`pi ${icon}`} />
                    {label}
                </Button>
            ))}
        </div>
    );
}
EOF

    if [[ "$PRETTIE" =~ ^[Yy] ]]; then
        npm run format
    fi

    local GIT
    read -r -p "Would you like to initialize Git? (Y/N): " GIT
    if [[ "$GIT" =~ ^[Yy] ]]; then
        git init
        git add -A
        git commit -m "Initial commit"
    fi

    echo "Project setup completed successfully."
    npm run dev
}
