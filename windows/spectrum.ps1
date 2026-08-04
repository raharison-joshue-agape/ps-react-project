$react_vite_spectrum_project_config_content = @'
import { defineConfig } from 'vite';
import { fileURLToPath, URL } from 'node:url';
import react from '@vitejs/plugin-react';
import tailwindcss from '@tailwindcss/vite';

// https://vite.dev/config/
export default defineConfig({
    server: {
        port: 5173,
        host: '0.0.0.0',
        open: true,
    },
    plugins: [react(), tailwindcss()],
    resolve: {
        alias: {
            '@': fileURLToPath(new URL('./src', import.meta.url)),
        },
    },
});
'@
$react_vite_spectrum_project_tsconfig_app_content = @'
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
$react_vite_spectrum_project_main_content = @'
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
$react_vite_spectrum_project_theme_content = @'
import { createContext, type ReactNode, useContext, useEffect, useState } from 'react';
import { Provider, defaultTheme } from '@adobe/react-spectrum';

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
            <Provider theme={defaultTheme} colorScheme={resolved}>
                {children}
            </Provider>
        </ThemeContext.Provider>
    );
}
'@
$react_vite_spectrum_project_style_content = @'
html {
    scroll-behavior: smooth;
}

.hero-icon svg {
    width: 40px;
    height: 40px;
}
'@
$react_vite_spectrum_project_route_content = @'
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
$react_vite_spectrum_project_home_page_content = @'
import { Badge, Button, Heading, Text } from '@adobe/react-spectrum';
import Book from '@spectrum-icons/workflow/Book';
import HomeIcon from '@spectrum-icons/workflow/Home';
import Launch from '@spectrum-icons/workflow/Launch';
import ToggleMode from '@/components/ToggleMode';

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
            <Badge variant="info">React 19 • React Spectrum</Badge>

            <span
                className="hero-icon"
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
                <HomeIcon />
            </span>

            <Heading level={1} marginTop="size-200">
                Bienvenue sur votre projet React
            </Heading>

            <Text UNSAFE_style={{ maxWidth: 640, fontSize: 18, lineHeight: 1.7 }}>
                Ce projet est pré-configuré avec <strong>React Spectrum</strong>,{' '}
                <strong>Adobe Workflow Icons</strong> et <strong>React Router</strong> pour un
                développement rapide et élégant.
            </Text>

            <div style={{ display: 'flex', gap: 12, flexWrap: 'wrap', justifyContent: 'center' }}>
                <Button variant="accent" onPress={() => undefined}>
                    <Launch />
                    Démarrer
                </Button>
                <Button variant="secondary" onPress={() => undefined}>
                    <Book />
                    Documentation
                </Button>
            </div>

            <ToggleMode className="fixed top-5 right-5 z-50" />
        </div>
    );
}
'@
$react_vite_spectrum_project_not_found_page_content = @'
import { Badge, Button, Heading, Text } from '@adobe/react-spectrum';
import Alert from '@spectrum-icons/workflow/Alert';
import ArrowLeft from '@spectrum-icons/workflow/ArrowLeft';
import HomeIcon from '@spectrum-icons/workflow/Home';
import { Link, useNavigate } from 'react-router-dom';
import ToggleMode from '@/components/ToggleMode';

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
            <Badge variant="negative">Erreur 404</Badge>

            <span
                className="hero-icon"
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
                <Alert />
            </span>

            <Heading level={1} marginTop="size-200">
                Page introuvable
            </Heading>

            <Text UNSAFE_style={{ maxWidth: 640, fontSize: 18, lineHeight: 1.7 }}>
                Oups... la page que vous cherchez semble avoir disparu 🫥 <br />
                Vérifiez l'URL ou revenez à une page connue.
            </Text>

            <div style={{ display: 'flex', gap: 12, flexWrap: 'wrap', justifyContent: 'center' }}>
                <Button variant="accent" onPress={() => navigate(-1)}>
                    <ArrowLeft />
                    Retour
                </Button>
                <Link to="/">
                    <Button variant="secondary" onPress={() => undefined}>
                        <HomeIcon />
                        Accueil
                    </Button>
                </Link>
            </div>

            <Text UNSAFE_style={{ marginTop: 8, fontSize: 14 }}>
                Code erreur : 404 — Ressource introuvable
            </Text>

            <ToggleMode className="fixed top-5 right-5 z-50" />
        </div>
    );
}
'@
$react_vite_spectrum_project_default_layout_content = @'
import { Outlet } from 'react-router-dom';

export default function DefaultLayout() {
    return <Outlet />;
}
'@
$react_vite_spectrum_project_toggle_mode_content = @'
import { Item, Picker } from '@adobe/react-spectrum';
import { UseThemeMode, type ThemeMode } from '@/theme/ThemeContext';

const OPTIONS: ThemeMode[] = ['light', 'dark', 'system'];

export default function ToggleMode({ className }: { className?: string }) {
    const { mode, setMode } = UseThemeMode();

    return (
        <div className={className}>
            <Picker
                label="Thème"
                width="size-2000"
                selectedKey={mode}
                onSelectionChange={(key) => setMode(key as ThemeMode)}
            >
                {OPTIONS.map((option) => (
                    <Item key={option}>{option}</Item>
                ))}
            </Picker>
        </div>
    );
}
'@

<#
.SYNOPSIS
    Crée un projet Vite + React 19 + React Spectrum + TypeScript pré-configuré.

.DESCRIPTION
    Installe React Spectrum (Adobe) et les icônes Workflow, puis génère le layout, les pages Home/404 et le sélecteur de thème (Clair / Sombre / Système via le provider Spectrum et colorScheme).

.PARAMETER PROJECT_NAME
    Nom du répertoire du projet à créer.

.EXAMPLE
    New-ReactViteSpectrum myapp
#>
function New-ReactViteSpectrum {
    param([string]$PROJECT_NAME)

    if (-not $PROJECT_NAME) { $PROJECT_NAME = Read-Host "Project name" }

    Write-Host "Creating project: $PROJECT_NAME (Vite + React 19 + React Spectrum + TypeScript)"
    npx create-vite@latest "$PROJECT_NAME" --template react-ts --no-immediate

    Set-Location "$PROJECT_NAME"

    Clear-Host
    Write-Host "Installing dependencies..."
    npm install @adobe/react-spectrum @spectrum-icons/workflow react-router-dom

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

    Set-Content "vite.config.ts" -Value $react_vite_spectrum_project_config_content -Encoding UTF8
    Set-Content "tsconfig.app.json" -Value $react_vite_spectrum_project_tsconfig_app_content -Encoding UTF8
    Set-Content "src/main.tsx" -Value $react_vite_spectrum_project_main_content -Encoding UTF8
    Set-Content "src/theme/ThemeContext.tsx" -Value $react_vite_spectrum_project_theme_content -Encoding UTF8
    Set-Content "src/styles/index.css" -Value $react_vite_spectrum_project_style_content -Encoding UTF8
    Set-Content "src/routes/index.tsx" -Value $react_vite_spectrum_project_route_content -Encoding UTF8
    Set-Content "src/pages/Home.tsx" -Value $react_vite_spectrum_project_home_page_content -Encoding UTF8
    Set-Content "src/pages/NotFound.tsx" -Value $react_vite_spectrum_project_not_found_page_content -Encoding UTF8
    Set-Content "src/layouts/default.tsx" -Value $react_vite_spectrum_project_default_layout_content -Encoding UTF8
    Set-Content "src/components/ToggleMode.tsx" -Value $react_vite_spectrum_project_toggle_mode_content -Encoding UTF8

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