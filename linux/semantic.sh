#!/usr/bin/env bash
# semantic.sh — Crée un projet Vite + React 19 + Semantic UI React + TypeScript pré-configuré.

new_react_vite_semantic() {
    local PROJECT_NAME="${1:-}"

    if [ -z "$PROJECT_NAME" ]; then
        read -r -p "Project name: " PROJECT_NAME
    fi

    echo "Creating project: $PROJECT_NAME (Vite + React 19 + Semantic UI React + TypeScript)"
    npx create-vite@latest "$PROJECT_NAME" --template react-ts --no-immediate

    cd "$PROJECT_NAME" || return 1

    clear
    echo "Installing dependencies..."
    npm install semantic-ui-react semantic-ui-css react-router-dom --legacy-peer-deps

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
    // Semantic UI CSS uses legacy selectors that lightningcss cannot minify
    build: {
        cssMinify: false,
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
import { ThemeProviderWrapper } from '@/theme/ThemeContext';
import router from '@/routes';

createRoot(document.getElementById('root')!).render(
    <StrictMode>
        <ThemeProviderWrapper>
            <RouterProvider router={router} />
        </ThemeProviderWrapper>
    </StrictMode>,
);
EOF
    cat > src/theme/ThemeContext.tsx <<'EOF'
import { createContext, type ReactNode, useContext, useEffect, useState } from 'react';

export type ThemeMode = 'light' | 'dark' | 'system';

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

export function ThemeProviderWrapper({ children }: { children: ReactNode }) {
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

    const resolved: 'light' | 'dark' = mode === 'system' ? (systemDark ? 'dark' : 'light') : mode;

    useEffect(() => {
        localStorage.setItem('theme', mode);
        document.documentElement.classList.toggle('dark', resolved === 'dark');
    }, [mode, resolved]);

    return <ThemeContext.Provider value={{ mode, setMode }}>{children}</ThemeContext.Provider>;
}
EOF
    cat > src/styles/index.css <<'EOF'
@import 'semantic-ui-css/semantic.min.css';

html {
    scroll-behavior: smooth;
}

html.dark {
    color-scheme: dark;
}

body {
    background-color: #fafafa;
}

html.dark body {
    background-color: #0b0f19;
}

html.dark .ui.header {
    color: #f1f5f9;
}

html.dark .ui.container p {
    color: #cbd5e1;
}

html.dark .ui.selection.dropdown,
html.dark .ui.selection.dropdown .menu {
    background: #1e293b;
    color: #e2e8f0;
}

html.dark .ui.selection.dropdown .menu > .item {
    color: #e2e8f0;
}

html.dark .ui.selection.dropdown .menu > .item:hover {
    background: rgba(255, 255, 255, 0.06);
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
import { Button, Container, Header, Icon, Label } from 'semantic-ui-react';
import ToggleMode from '@/components/ToggleMode';

export default function Home() {
    return (
        <Container
            textAlign="center"
            style={{
                display: 'flex',
                flexDirection: 'column',
                alignItems: 'center',
                justifyContent: 'center',
                minHeight: '100vh',
                padding: '64px 24px',
                gap: 24,
            }}
        >
            <Label color="teal" size="large" circular>
                React 19 • Semantic UI
            </Label>

            <span
                style={{
                    width: 80,
                    height: 80,
                    borderRadius: 20,
                    display: 'inline-flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    background: 'linear-gradient(135deg, #06b6d4, #8b5cf6)',
                    color: '#fff',
                    boxShadow: '0 12px 32px rgba(6, 182, 212, 0.25)',
                }}
            >
                <Icon name="home" size="big" />
            </span>

            <Header as="h1" style={{ fontSize: '2.5rem' }}>
                Bienvenue sur votre projet React
            </Header>

            <p style={{ maxWidth: 640, fontSize: 18, lineHeight: 1.7 }}>
                Ce projet est pré-configuré avec <strong>Semantic UI</strong>,{' '}
                <strong>Semantic UI CSS</strong> et <strong>React Router</strong> pour un
                développement rapide et élégant.
            </p>

            <div style={{ display: 'flex', gap: 12, flexWrap: 'wrap', justifyContent: 'center' }}>
                <Button color="teal" size="large">
                    <Icon name="rocket" /> Démarrer
                </Button>
                <Button basic color="violet" size="large">
                    <Icon name="book" /> Documentation
                </Button>
            </div>

            <ToggleMode className="fixed top-5 right-5 z-50" />
        </Container>
    );
}
EOF
    cat > src/pages/NotFound.tsx <<'EOF'
import { Button, Container, Header, Icon, Label } from 'semantic-ui-react';
import { Link, useNavigate } from 'react-router-dom';
import ToggleMode from '@/components/ToggleMode';

export default function NotFound() {
    const navigate = useNavigate();

    return (
        <Container
            textAlign="center"
            style={{
                display: 'flex',
                flexDirection: 'column',
                alignItems: 'center',
                justifyContent: 'center',
                minHeight: '100vh',
                padding: '64px 24px',
                gap: 24,
            }}
        >
            <Label color="pink" size="large" circular>
                Erreur 404
            </Label>

            <span
                style={{
                    width: 80,
                    height: 80,
                    borderRadius: 20,
                    display: 'inline-flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    background: 'linear-gradient(135deg, #ec4899, #8b5cf6)',
                    color: '#fff',
                    boxShadow: '0 12px 32px rgba(236, 72, 153, 0.25)',
                }}
            >
                <Icon name="ban" size="big" />
            </span>

            <Header as="h1" style={{ fontSize: '2.5rem' }}>
                Page introuvable
            </Header>

            <p style={{ maxWidth: 640, fontSize: 18, lineHeight: 1.7 }}>
                Oups... la page que vous cherchez semble avoir disparu 🫥 <br />
                Vérifiez l'URL ou revenez à une page connue.
            </p>

            <div style={{ display: 'flex', gap: 12, flexWrap: 'wrap', justifyContent: 'center' }}>
                <Button color="pink" size="large" onClick={() => navigate(-1)}>
                    <Icon name="arrow left" /> Retour
                </Button>
                <Link to="/">
                    <Button basic color="violet" size="large">
                        <Icon name="home" /> Accueil
                    </Button>
                </Link>
            </div>

            <p style={{ marginTop: 8, fontSize: 14 }}>
                Code erreur : 404 — Ressource introuvable
            </p>

            <ToggleMode className="fixed top-5 right-5 z-50" />
        </Container>
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
import { Dropdown } from 'semantic-ui-react';
import { UseThemeMode, type ThemeMode } from '@/theme/ThemeContext';

const OPTIONS = [
    { key: 'light', value: 'light', text: 'Light', icon: 'sun' },
    { key: 'dark', value: 'dark', text: 'Dark', icon: 'moon' },
    { key: 'system', value: 'system', text: 'System', icon: 'desktop' },
];

export default function ToggleMode({ className }: { className?: string }) {
    const { mode, setMode } = UseThemeMode();

    return (
        <div className={className}>
            <Dropdown
                selection
                value={mode}
                options={OPTIONS}
                onChange={(_e, data) => setMode(data.value as ThemeMode)}
                style={{ minWidth: 150 }}
            />
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