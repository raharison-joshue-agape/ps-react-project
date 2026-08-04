#!/usr/bin/env bash
# arco.sh — Crée un projet Vite + React 19 + Arco Design + TypeScript pré-configuré.

new_react_vite_arco() {
    local PROJECT_NAME="${1:-}"

    if [ -z "$PROJECT_NAME" ]; then
        read -r -p "Project name: " PROJECT_NAME
    fi

    echo "Creating project: $PROJECT_NAME (Vite + React 19 + Arco Design + TypeScript)"
    npx create-vite@latest "$PROJECT_NAME" --template react-ts --no-immediate

    cd "$PROJECT_NAME" || return 1

    clear
    echo "Installing dependencies..."
    npm install @arco-design/web-react react-router-dom

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
        document.body.setAttribute('arco-theme', resolved);
    }, [mode, resolved]);

    return <ThemeContext.Provider value={{ mode, setMode }}>{children}</ThemeContext.Provider>;
}
EOF
    cat > src/styles/index.css <<'EOF'
@import '@arco-design/web-react/dist/css/arco.css';

html {
    scroll-behavior: smooth;
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
import { Button, Tag, Typography } from '@arco-design/web-react';
import { IconBook, IconHome, IconLaunch } from '@arco-design/web-react/icon';
import ToggleMode from '@/components/ToggleMode';

const { Title, Paragraph } = Typography;

export default function Home() {
    return (
        <div
            style={{
                minHeight: '100vh',
                display: 'flex',
                flexDirection: 'column',
                alignItems: 'center',
                justifyContent: 'center',
                gap: 24,
                padding: '64px 24px',
                textAlign: 'center',
                background:
                    'linear-gradient(135deg, rgba(6, 182, 212, 0.08), rgba(139, 92, 246, 0.08))',
            }}
        >
            <Tag color="cyan" size="large">
                React 19 • Arco Design
            </Tag>

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
                <IconHome style={{ fontSize: 40 }} />
            </span>

            <Title heading={1} style={{ margin: 0 }}>
                Bienvenue sur votre projet React
            </Title>

            <Paragraph style={{ maxWidth: 640, fontSize: 18, lineHeight: 1.7 }}>
                Ce projet est pré-configuré avec <strong>Arco Design</strong>,{' '}
                <strong>Arco Icons</strong> et <strong>React Router</strong> pour un développement
                rapide et élégant.
            </Paragraph>

            <div style={{ display: 'flex', gap: 12, flexWrap: 'wrap', justifyContent: 'center' }}>
                <Button type="primary" size="large" icon={<IconLaunch />}>
                    Démarrer
                </Button>
                <Button type="secondary" size="large" icon={<IconBook />}>
                    Documentation
                </Button>
            </div>

            <ToggleMode className="fixed top-5 right-5 z-50" />
        </div>
    );
}
EOF
    cat > src/pages/NotFound.tsx <<'EOF'
import { Button, Tag, Typography } from '@arco-design/web-react';
import { IconArrowLeft, IconExclamationCircle, IconHome } from '@arco-design/web-react/icon';
import { Link, useNavigate } from 'react-router-dom';
import ToggleMode from '@/components/ToggleMode';

const { Title, Paragraph } = Typography;

export default function NotFound() {
    const navigate = useNavigate();

    return (
        <div
            style={{
                minHeight: '100vh',
                display: 'flex',
                flexDirection: 'column',
                alignItems: 'center',
                justifyContent: 'center',
                gap: 24,
                padding: '64px 24px',
                textAlign: 'center',
                background:
                    'linear-gradient(135deg, rgba(244, 114, 182, 0.08), rgba(139, 92, 246, 0.08))',
            }}
        >
            <Tag color="magenta" size="large">
                Erreur 404
            </Tag>

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
                <IconExclamationCircle style={{ fontSize: 40 }} />
            </span>

            <Title heading={1} style={{ margin: 0 }}>
                Page introuvable
            </Title>

            <Paragraph style={{ maxWidth: 640, fontSize: 18, lineHeight: 1.7 }}>
                Oups... la page que vous cherchez semble avoir disparu 🫥 <br />
                Vérifiez l'URL ou revenez à une page connue.
            </Paragraph>

            <div style={{ display: 'flex', gap: 12, flexWrap: 'wrap', justifyContent: 'center' }}>
                <Button type="primary" size="large" icon={<IconArrowLeft />} onClick={() => navigate(-1)}>
                    Retour
                </Button>
                <Link to="/">
                    <Button type="secondary" size="large" icon={<IconHome />}>
                        Accueil
                    </Button>
                </Link>
            </div>

            <Paragraph style={{ marginTop: 8, fontSize: 14 }}>
                Code erreur : 404 — Ressource introuvable
            </Paragraph>

            <ToggleMode className="fixed top-5 right-5 z-50" />
        </div>
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
import { Radio } from '@arco-design/web-react';
import { UseThemeMode, type ThemeMode } from '@/theme/ThemeContext';

const RadioGroup = Radio.Group;

export default function ToggleMode({ className }: { className?: string }) {
    const { mode, setMode } = UseThemeMode();

    return (
        <div className={className}>
            <RadioGroup
                type="button"
                value={mode}
                onChange={(value) => setMode(value as ThemeMode)}
                options={['light', 'dark', 'system']}
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