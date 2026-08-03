$react_vite_mantine_project_config_content = @'
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

$react_vite_mantine_project_tsconfig_app_content = @'
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

$react_vite_mantine_project_main_content = @'
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

$react_vite_mantine_project_theme_content = @'
import { createContext, type ReactNode, useContext, useEffect, useState } from 'react';
import { MantineProvider, createTheme, type MantineColorScheme } from '@mantine/core';

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

const theme = createTheme({
    primaryColor: 'cyan',
    defaultRadius: 'md',
});

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

    const scheme: MantineColorScheme = mode === 'system' ? (systemDark ? 'dark' : 'light') : mode;

    useEffect(() => {
        localStorage.setItem('theme', mode);
        document.documentElement.classList.toggle('dark', scheme === 'dark');
    }, [mode, scheme]);

    return (
        <ThemeContext.Provider value={{ mode, setMode }}>
            <MantineProvider theme={theme} forceColorScheme={scheme}>
                {children}
            </MantineProvider>
        </ThemeContext.Provider>
    );
}
'@

$react_vite_mantine_project_style_content = @'
@import '@mantine/core/styles.css';

/* Global css styles */
html {
    scroll-behavior: smooth;
}
'@

$react_vite_mantine_project_route_content = @'
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

$react_vite_mantine_project_home_page_content = @'
import { Badge, Button, Container, Group, Stack, Text, ThemeIcon, Title } from '@mantine/core';
import { IconBook, IconHome2, IconRocket } from '@tabler/icons-react';
import ToggleMode from '@/components/ToggleMode';

export default function Home() {
    return (
        <Container size="md" px="xl">
            <Stack align="center" gap="lg" mih="100vh" justify="center" style={{ textAlign: 'center' }}>
                <Badge size="lg" variant="dot" color="cyan">
                    React 19 • Mantine
                </Badge>

                <ThemeIcon
                    size={80}
                    radius={20}
                    variant="gradient"
                    gradient={{ from: 'cyan', to: 'purple' }}
                >
                    <IconHome2 size={40} />
                </ThemeIcon>

                <Title order={1} ta="center">
                    Bienvenue sur votre projet React
                </Title>

                <Text ta="center" c="dimmed" size="lg" maw={640} mx="auto">
                    Ce projet est pré-configuré avec{' '}
                    <Text span fw={700} c="cyan.6">
                        Mantine
                    </Text>
                    ,{' '}
                    <Text span fw={700} c="purple.6">
                        Tabler Icons
                    </Text>{' '}
                    et{' '}
                    <Text span fw={700} c="pink.6">
                        React Router
                    </Text>{' '}
                    pour un développement rapide et élégant.
                </Text>

                <Group justify="center" gap="md">
                    <Button
                        size="lg"
                        variant="gradient"
                        gradient={{ from: 'cyan', to: 'purple' }}
                        leftSection={<IconRocket size={20} />}
                    >
                        Démarrer
                    </Button>

                    <Button size="lg" variant="light" color="purple" leftSection={<IconBook size={20} />}>
                        Documentation
                    </Button>
                </Group>
            </Stack>

            <ToggleMode className="fixed top-5 right-5 z-50" />
        </Container>
    );
}
'@

$react_vite_mantine_project_not_found_page_content = @'
import { Badge, Button, Container, Group, Stack, Text, ThemeIcon, Title } from '@mantine/core';
import { IconArrowLeft, IconBan, IconHome2 } from '@tabler/icons-react';
import { Link, useNavigate } from 'react-router-dom';
import ToggleMode from '@/components/ToggleMode';

export default function NotFound() {
    const navigate = useNavigate();

    return (
        <Container size="md" px="xl">
            <Stack align="center" gap="lg" mih="100vh" justify="center" style={{ textAlign: 'center' }}>
                <Badge size="lg" variant="dot" color="pink">
                    Erreur 404
                </Badge>

                <ThemeIcon
                    size={80}
                    radius={20}
                    variant="gradient"
                    gradient={{ from: 'pink', to: 'purple' }}
                >
                    <IconBan size={40} />
                </ThemeIcon>

                <Title order={1} ta="center">
                    Page introuvable
                </Title>

                <Text ta="center" c="dimmed" size="lg" maw={640} mx="auto">
                    Oups... la page que vous cherchez semble avoir disparu 🫥 <br />
                    Vérifiez l'URL ou revenez à une page connue.
                </Text>

                <Group justify="center" gap="md">
                    <Button
                        size="lg"
                        variant="gradient"
                        gradient={{ from: 'pink', to: 'purple' }}
                        leftSection={<IconArrowLeft size={20} />}
                        onClick={() => navigate(-1)}
                    >
                        Retour
                    </Button>

                    <Link to="/">
                        <Button size="lg" variant="light" color="purple" leftSection={<IconHome2 size={20} />}>
                            Accueil
                        </Button>
                    </Link>
                </Group>

                <Text mt="lg" size="sm" c="dimmed">
                    Code erreur : 404 — Ressource introuvable
                </Text>
            </Stack>

            <ToggleMode className="fixed top-5 right-5 z-50" />
        </Container>
    );
}
'@

$react_vite_mantine_project_default_layout_content = @'
import { Outlet } from 'react-router-dom';

export default function DefaultLayout() {
    return <Outlet />;
}
'@

$react_vite_mantine_project_toogle_mode_content = @'
import { SegmentedControl } from '@mantine/core';
import { IconDeviceDesktop, IconMoon, IconSun } from '@tabler/icons-react';
import { UseThemeMode } from '@/theme/ThemeContext';

const OPTIONS = [
    { value: 'system', label: 'System', Icon: IconDeviceDesktop },
    { value: 'light', label: 'Light', Icon: IconSun },
    { value: 'dark', label: 'Dark', Icon: IconMoon },
] as const;

export default function ToggleMode({ className }: { className?: string }) {
    const { mode, setMode } = UseThemeMode();

    return (
        <div className={className}>
            <SegmentedControl
                size="sm"
                value={mode}
                onChange={(value) => setMode(value as 'light' | 'dark' | 'system')}
                data={OPTIONS.map(({ value, label, Icon }) => ({
                    value,
                    label: (
                        <span style={{ display: 'inline-flex', alignItems: 'center', gap: 8 }}>
                            <Icon size={16} />
                            <span>{label}</span>
                        </span>
                    ),
                }))}
            />
        </div>
    );
}
'@

<#
.SYNOPSIS
    Crée un projet Vite + React 19 + Mantine + TypeScript pré-configuré.

.DESCRIPTION
    Installe Mantine (core + hooks) et Tabler Icons, puis génère le layout,
    les pages Home/404 et le sélecteur de thème (Clair / Sombre / Système).

.PARAMETER PROJECT_NAME
    Nom du répertoire du projet à créer.

.EXAMPLE
    New-ReactViteMantine myapp
#>
function New-ReactViteMantine {
    param([string]$PROJECT_NAME)

    if (-not $PROJECT_NAME) { $PROJECT_NAME = Read-Host "Project name" }

    Write-Host "Creating project: $PROJECT_NAME (Vite + React 19 + Mantine + TypeScript)"
    npx create-vite@latest "$PROJECT_NAME" --template react-ts

    Set-Location "$PROJECT_NAME"

    Clear-Host
    Write-Host "Installing dependencies..."
    npm install @mantine/core @mantine/hooks @tabler/icons-react react-router-dom

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

    Set-Content "vite.config.ts" -Value $react_vite_mantine_project_config_content -Encoding UTF8
    Set-Content "tsconfig.app.json" -Value $react_vite_mantine_project_tsconfig_app_content -Encoding UTF8
    Set-Content "src/styles/index.css" -Value $react_vite_mantine_project_style_content -Encoding UTF8
    Set-Content "src/main.tsx" -Value $react_vite_mantine_project_main_content -Encoding UTF8
    Set-Content "src/theme/ThemeContext.tsx" -Value $react_vite_mantine_project_theme_content -Encoding UTF8
    Set-Content "src/routes/index.tsx" -Value $react_vite_mantine_project_route_content -Encoding UTF8
    Set-Content "src/pages/Home.tsx" -Value $react_vite_mantine_project_home_page_content -Encoding UTF8
    Set-Content "src/pages/NotFound.tsx" -Value $react_vite_mantine_project_not_found_page_content -Encoding UTF8
    Set-Content "src/layouts/default.tsx" -Value $react_vite_mantine_project_default_layout_content -Encoding UTF8
    Set-Content "src/components/ToggleMode.tsx" -Value $react_vite_mantine_project_toogle_mode_content -Encoding UTF8

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
