#!/usr/bin/env bash
# grommet.sh — Crée un projet Vite + React 19 + Grommet + TypeScript pré-configuré.

new_react_vite_grommet() {
    local PROJECT_NAME="${1:-}"

    if [ -z "$PROJECT_NAME" ]; then
        read -r -p "Project name: " PROJECT_NAME
    fi

    echo "Creating project: $PROJECT_NAME (Vite + React 19 + Grommet + TypeScript)"
    npx create-vite@latest "$PROJECT_NAME" --template react-ts --no-immediate

    cd "$PROJECT_NAME" || return 1

    clear
    echo "Installing dependencies..."
    npm install grommet grommet-icons styled-components react-router-dom

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
import { Grommet, grommet } from 'grommet';

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
    }, [mode]);

    return (
        <ThemeContext.Provider value={{ mode, setMode }}>
            <Grommet theme={grommet} themeMode={resolved}>
                {children}
            </Grommet>
        </ThemeContext.Provider>
    );
}
EOF
    cat > src/styles/index.css <<'EOF'
html {
    scroll-behavior: smooth;
}

#root {
    min-height: 100vh;
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
import { Box, Button, Heading, Paragraph, Tag } from 'grommet';
import { Book, HomeRounded, Launch } from 'grommet-icons';
import ToggleMode from '@/components/ToggleMode';

export default function Home() {
    return (
        <Box
            fill
            pad="large"
            align="center"
            justify="center"
            gap="medium"
            style={{
                background:
                    'linear-gradient(135deg, rgba(6, 182, 212, 0.08), rgba(139, 92, 246, 0.08))',
            }}
        >
            <Tag value="React 19 • Grommet" size="large" />

            <Box
                width="80px"
                height="80px"
                round="20px"
                align="center"
                justify="center"
                style={{
                    backgroundImage: 'linear-gradient(135deg, #06b6d4, #8b5cf6)',
                    boxShadow: '0 12px 32px rgba(6, 182, 212, 0.25)',
                }}
            >
                <HomeRounded color="white" size="40px" />
            </Box>

            <Heading level={1} size="large" margin="none" textAlign="center">
                Bienvenue sur votre projet React
            </Heading>

            <Paragraph size="large" fill textAlign="center" style={{ maxWidth: 640 }}>
                Ce projet est pré-configuré avec <strong>Grommet</strong>,{' '}
                <strong>Grommet Icons</strong> et <strong>React Router</strong> pour un
                développement rapide et élégant.
            </Paragraph>

            <Box direction="row" gap="medium" align="center" wrap>
                <Button
                    primary
                    size="large"
                    label="Démarrer"
                    icon={<Launch />}
                    reverse
                />
                <Button
                    secondary
                    size="large"
                    label="Documentation"
                    icon={<Book />}
                    reverse
                />
            </Box>

            <ToggleMode className="fixed top-5 right-5 z-50" />
        </Box>
    );
}
EOF
    cat > src/pages/NotFound.tsx <<'EOF'
import { Box, Button, Heading, Paragraph, Tag } from 'grommet';
import { Link, useNavigate } from 'react-router-dom';
import { HomeRounded, StatusCritical, Undo } from 'grommet-icons';
import ToggleMode from '@/components/ToggleMode';

export default function NotFound() {
    const navigate = useNavigate();

    return (
        <Box
            fill
            pad="large"
            align="center"
            justify="center"
            gap="medium"
            style={{
                background:
                    'linear-gradient(135deg, rgba(244, 114, 182, 0.08), rgba(139, 92, 246, 0.08))',
            }}
        >
            <Tag value="Erreur 404" size="large" />

            <Box
                width="80px"
                height="80px"
                round="20px"
                align="center"
                justify="center"
                style={{
                    backgroundImage: 'linear-gradient(135deg, #ec4899, #8b5cf6)',
                    boxShadow: '0 12px 32px rgba(236, 72, 153, 0.25)',
                }}
            >
                <StatusCritical color="white" size="40px" />
            </Box>

            <Heading level={1} size="large" margin="none" textAlign="center">
                Page introuvable
            </Heading>

            <Paragraph size="large" fill textAlign="center" style={{ maxWidth: 640 }}>
                Oups... la page que vous cherchez semble avoir disparu 🫥 <br />
                Vérifiez l'URL ou revenez à une page connue.
            </Paragraph>

            <Box direction="row" gap="medium" align="center" wrap>
                <Button
                    primary
                    size="large"
                    label="Retour"
                    icon={<Undo />}
                    reverse
                    onClick={() => navigate(-1)}
                />
                <Link to="/">
                    <Button secondary size="large" label="Accueil" icon={<HomeRounded />} reverse />
                </Link>
            </Box>

            <Paragraph size="small" margin="small" textAlign="center">
                Code erreur : 404 — Ressource introuvable
            </Paragraph>

            <ToggleMode className="fixed top-5 right-5 z-50" />
        </Box>
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
import { Select } from 'grommet';
import { UseThemeMode, type ThemeMode } from '@/theme/ThemeContext';

const OPTIONS: ThemeMode[] = ['light', 'dark', 'system'];

export default function ToggleMode({ className }: { className?: string }) {
    const { mode, setMode } = UseThemeMode();

    return (
        <div className={className}>
            <Select
                options={OPTIONS}
                value={mode}
                onChange={({ option }) => setMode(option as ThemeMode)}
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