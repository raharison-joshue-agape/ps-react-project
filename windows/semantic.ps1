$react_vite_semantic_project_config_content = @'
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
'@
$react_vite_semantic_project_tsconfig_app_content = @'
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
'@
$react_vite_semantic_project_main_content = @'
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
'@
$react_vite_semantic_project_theme_content = @'
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
'@
$react_vite_semantic_project_style_content = @'
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
'@
$react_vite_semantic_project_route_content = @'
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
'@
$react_vite_semantic_project_home_page_content = @'
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
'@
$react_vite_semantic_project_not_found_page_content = @'
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
'@
$react_vite_semantic_project_default_layout_content = @'
import { Outlet } from 'react-router-dom';

export default function DefaultLayout() {
    return <Outlet />;
}
'@
$react_vite_semantic_project_toggle_mode_content = @'
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
'@

<#
.SYNOPSIS
    Crée un projet Vite + React 19 + Semantic UI React + TypeScript pré-configuré.

.DESCRIPTION
    Installe Semantic UI React et Semantic UI CSS, puis génère le layout, les pages Home/404 et le sélecteur de thème (Clair / Sombre / Système via la classe .dark et des overrides CSS).

.PARAMETER PROJECT_NAME
    Nom du répertoire du projet à créer.

.EXAMPLE
    New-ReactViteSemantic myapp
#>
function New-ReactViteSemantic {
    param([string]$PROJECT_NAME)

    if (-not $PROJECT_NAME) { $PROJECT_NAME = Read-Host "Project name" }

    Write-Host "Creating project: $PROJECT_NAME (Vite + React 19 + Semantic UI React + TypeScript)"
    npx create-vite@latest "$PROJECT_NAME" --template react-ts --no-immediate

    Set-Location "$PROJECT_NAME"

    Clear-Host
    Write-Host "Installing dependencies..."
    npm install semantic-ui-react semantic-ui-css react-router-dom --legacy-peer-deps

    $PRETTIE = Read-Host "Would you like to install Prettier? (Y/N)"
    if ($PRETTIE.Trim() -match '^[Yy]') {
        Install-Prettier
    }

    Remove-Item "src/App.css" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item "src/index.css" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item "src/App.tsx" -Recurse -Force -ErrorAction SilentlyContinue

    $dirs = @(
        "src/components",
        "src/layouts",
        "src/pages",
        "src/routes",
        "src/styles",
        "src/theme"
    )
    foreach ($d in $dirs) { if (-not (Test-Path $d)) { New-Item -ItemType Directory -Path $d -Force | Out-Null } }

    Set-Content "vite.config.ts" -Value $react_vite_semantic_project_config_content -Encoding UTF8
    Set-Content "tsconfig.app.json" -Value $react_vite_semantic_project_tsconfig_app_content -Encoding UTF8
    Set-Content "src/main.tsx" -Value $react_vite_semantic_project_main_content -Encoding UTF8
    Set-Content "src/theme/ThemeContext.tsx" -Value $react_vite_semantic_project_theme_content -Encoding UTF8
    Set-Content "src/styles/index.css" -Value $react_vite_semantic_project_style_content -Encoding UTF8
    Set-Content "src/routes/index.tsx" -Value $react_vite_semantic_project_route_content -Encoding UTF8
    Set-Content "src/pages/Home.tsx" -Value $react_vite_semantic_project_home_page_content -Encoding UTF8
    Set-Content "src/pages/NotFound.tsx" -Value $react_vite_semantic_project_not_found_page_content -Encoding UTF8
    Set-Content "src/layouts/default.tsx" -Value $react_vite_semantic_project_default_layout_content -Encoding UTF8
    Set-Content "src/components/ToggleMode.tsx" -Value $react_vite_semantic_project_toggle_mode_content -Encoding UTF8

    if ($PRETTIE.Trim() -match '^[Yy]') {
        npm run format
    }

    $GIT = Read-Host "Would you like to initialize Git? (Y/N)"
    if ($GIT.Trim() -match '^[Yy]') {
        git init
        git add -A
        git commit -m "Initial commit"
    }

    Write-Host "Project setup completed successfully."
    npm run dev
}