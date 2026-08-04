$react_vite_grommet_project_config_content = @'
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
'@
$react_vite_grommet_project_tsconfig_app_content = @'
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
$react_vite_grommet_project_main_content = @'
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
$react_vite_grommet_project_theme_content = @'
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
'@
$react_vite_grommet_project_style_content = @'
html {
    scroll-behavior: smooth;
}

#root {
    min-height: 100vh;
}
'@
$react_vite_grommet_project_route_content = @'
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
$react_vite_grommet_project_home_page_content = @'
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
'@
$react_vite_grommet_project_not_found_page_content = @'
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
'@
$react_vite_grommet_project_default_layout_content = @'
import { Outlet } from 'react-router-dom';

export default function DefaultLayout() {
    return <Outlet />;
}
'@
$react_vite_grommet_project_toggle_mode_content = @'
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
'@

<#
.SYNOPSIS
    Crée un projet Vite + React 19 + Grommet + TypeScript pré-configuré.

.DESCRIPTION
    Installe Grommet (HP), Grommet Icons et styled-components, puis génère le layout, les pages Home/404 et le sélecteur de thème (Clair / Sombre / Système via le provider Grommet et themeMode).

.PARAMETER PROJECT_NAME
    Nom du répertoire du projet à créer.

.EXAMPLE
    New-ReactViteGrommet myapp
#>
function New-ReactViteGrommet {
    param([string]$PROJECT_NAME)

    if (-not $PROJECT_NAME) { $PROJECT_NAME = Read-Host "Project name" }

    Write-Host "Creating project: $PROJECT_NAME (Vite + React 19 + Grommet + TypeScript)"
    npx create-vite@latest "$PROJECT_NAME" --template react-ts --no-immediate

    Set-Location "$PROJECT_NAME"

    Clear-Host
    Write-Host "Installing dependencies..."
    npm install grommet grommet-icons styled-components react-router-dom

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

    Set-Content "vite.config.ts" -Value $react_vite_grommet_project_config_content -Encoding UTF8
    Set-Content "tsconfig.app.json" -Value $react_vite_grommet_project_tsconfig_app_content -Encoding UTF8
    Set-Content "src/main.tsx" -Value $react_vite_grommet_project_main_content -Encoding UTF8
    Set-Content "src/theme/ThemeContext.tsx" -Value $react_vite_grommet_project_theme_content -Encoding UTF8
    Set-Content "src/styles/index.css" -Value $react_vite_grommet_project_style_content -Encoding UTF8
    Set-Content "src/routes/index.tsx" -Value $react_vite_grommet_project_route_content -Encoding UTF8
    Set-Content "src/pages/Home.tsx" -Value $react_vite_grommet_project_home_page_content -Encoding UTF8
    Set-Content "src/pages/NotFound.tsx" -Value $react_vite_grommet_project_not_found_page_content -Encoding UTF8
    Set-Content "src/layouts/default.tsx" -Value $react_vite_grommet_project_default_layout_content -Encoding UTF8
    Set-Content "src/components/ToggleMode.tsx" -Value $react_vite_grommet_project_toggle_mode_content -Encoding UTF8

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