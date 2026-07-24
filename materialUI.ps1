$react_vite_mui_project_config_content = @'
import { defineConfig } from 'vite';
import path from 'path';
import react from '@vitejs/plugin-react';
import tailwindcss from '@tailwindcss/vite';

// https://vite.dev/config/
export default defineConfig({
    server: {
        port: 5173,
        host: "::"
    },
    plugins: [
        react(),
        tailwindcss()
    ],
    resolve: {
        tsconfigPaths: true,
        alias: {
            '@': path.resolve(__dirname, 'src'),
        },
    },
});
'@

$react_vite_mui_project_tsconfig_app_content = @'
{
    "compilerOptions": {
        "tsBuildInfoFile": "./node_modules/.tmp/tsconfig.app.tsbuildinfo",
        "target": "es2023",
        "lib": ["ES2023", "DOM", "DOM.Iterable"],
        "module": "esnext",
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
        "noUnusedLocals": true,
        "noUnusedParameters": true,
        "erasableSyntaxOnly": true,
        "noFallthroughCasesInSwitch": true,

        /* Alias @ = src */
        "baseUrl": ".",
        "paths": {
            "@/*": ["src/*"]
        },
        "ignoreDeprecations": "6.0"
    },
    "include": ["src"]
}
'@

$react_vite_mui_project_main_content = @'
import '@/styles/index.css';
import '@fontsource/roboto/300.css';
import '@fontsource/roboto/400.css';
import '@fontsource/roboto/500.css';
import '@fontsource/roboto/700.css';

import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';
import { RouterProvider } from 'react-router-dom';
import { StyledEngineProvider } from '@mui/material/styles';
import GlobalStyles from '@mui/material/GlobalStyles';
import router from '@/routes';

import { ThemeProviderWrapper } from '@/theme/ThemeContext';

createRoot(document.getElementById('root')!).render(
    <StrictMode>
        <ThemeProviderWrapper>
            <StyledEngineProvider enableCssLayer>
                <GlobalStyles styles="@layer theme, base, mui, components, utilities;" />
                <RouterProvider router={router} />
            </StyledEngineProvider>
        </ThemeProviderWrapper>
    </StrictMode>
);
'@

$react_vite_mui_project_theme_content = @'
import { createContext, type ReactNode, useContext, useEffect, useState, useMemo } from 'react';
import { ThemeProvider, createTheme, CssBaseline } from '@mui/material';

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

    useEffect(() => {
        const root = document.documentElement;
        let isDark: boolean;
        if (mode === 'system') {
            isDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
        } else {
            isDark = mode === 'dark';
        }

        if (isDark) root.classList.add('dark');
        else root.classList.remove('dark');

        localStorage.setItem('theme', mode);
    }, [mode]);

    const muiTheme = useMemo(() => {
        let muiMode: 'light' | 'dark';
        if (mode === 'system') {
            muiMode = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
        } else {
            muiMode = mode;
        }

        return createTheme({
            palette: { mode: muiMode, primary: { main: '#06b6d4' } },
        });
    }, [mode]);

    return (
        <ThemeContext.Provider value={{ mode, setMode }}>
            <ThemeProvider theme={muiTheme}>
                <CssBaseline />
                {children}
            </ThemeProvider>
        </ThemeContext.Provider>
    );
}
'@

$react_vite_mui_project_style_content = @'
@layer theme, base, mui, components, utilities;
@import 'tailwindcss';
@custom-variant dark (&:where(.dark, .dark *));
'@

$react_vite_mui_project_route_content = @'
import { createBrowserRouter, Navigate } from 'react-router-dom';
import DefaultLayout from '@/layouts/default';
import Home from '@/pages/Home';
import NotFound from '@/pages/NotFound';

const router = createBrowserRouter([
    {
        path: '/',
        element: <DefaultLayout />,
        children: [
            { index: true, element: <Navigate to="/home" />, },
            { path: '/home', element: <Home /> },
        ],
    },

    { path: '*', element: <NotFound /> },
]);

export default router;
'@

$react_vite_mui_project_home_page_content = @'
import { Button } from '@mui/material';
import ToggleMode from '@/components/ToggleMode';
import { Home } from '@mui/icons-material';

export default function HomePage() {
    return (
        <main className="min-h-screen flex flex-col items-center justify-center px-6 text-center bg-linear-to-br from-cyan-50 via-purple-50 to-pink-50 dark:from-gray-900 dark:via-gray-800 dark:to-gray-900 transition-colors">
            <Home className="text-cyan-600 dark:text-cyan-400 text-7xl mb-6 animate-bounce" />

            <h1 className="text-3xl sm:text-4xl md:text-5xl font-extrabold text-gray-900 dark:text-white mb-8 drop-shadow-lg">
                Bienvenue sur votre projet React
            </h1>

            <p className="text-lg sm:text-xl md:text-2xl text-gray-600 dark:text-gray-300 max-w-2xl mb-10 leading-relaxed">
                Ce projet est pré-configuré avec{' '}
                <span className="font-semibold text-cyan-600 dark:text-cyan-400"> Material UI</span>
                ,
                <span className="font-semibold text-purple-600 dark:text-purple-300">
                    {' '}
                    TailwindCSS
                </span>{' '}
                et
                <span className="font-semibold text-pink-600 dark:text-pink-300">
                    {' '}
                    Material Icons{' '}
                </span>
                pour un développement rapide et élégant.
            </p>

            <div className="flex flex-col sm:flex-row gap-6 justify-center">
                <Button
                    variant="contained"
                    size="large"
                    className="bg-linear-to-r from-cyan-500 to-purple-500 hover:from-purple-500 hover:to-cyan-500 text-white shadow-lg transition-all transform hover:-translate-y-1"
                    startIcon={<Home />}
                >
                    Démarrer
                </Button>

                <Button
                    variant="outlined"
                    size="large"
                    className="text-purple-600 dark:text-purple-300 border border-purple-600 dark:border-purple-300 hover:bg-purple-50 dark:hover:bg-purple-700 dark:hover:text-white shadow-md transition-all transform hover:-translate-y-1"
                >
                    Documentation
                </Button>
            </div>

            <ToggleMode className="fixed top-4 right-5" />
        </main>
    );
}
'@

$react_vite_mui_project_not_found_page_content = @'
import { Button } from '@mui/material';
import { Block, Home } from '@mui/icons-material';
import ArrowBackIcon from '@mui/icons-material/ArrowBack';
import { Link, useNavigate } from 'react-router-dom';

export default function NotFound() {
    const navigate = useNavigate();

    return (
        <main className="min-h-screen flex flex-col items-center justify-center px-6 text-center bg-linear-to-br from-cyan-50 via-purple-50 to-pink-50 dark:from-gray-900 dark:via-gray-800 dark:to-gray-900 transition-colors">
            <Block className="text-pink-600 dark:text-pink-400 text-7xl mb-6 animate-pulse" />

            <span className="text-sm font-semibold px-4 py-1 rounded-full bg-pink-100 text-pink-600 dark:bg-pink-900 dark:text-pink-300 mb-4 shadow">
                Erreur 404
            </span>

            <h1 className="text-3xl sm:text-4xl md:text-5xl font-extrabold text-gray-900 dark:text-white mb-6 drop-shadow-lg">
                Page introuvable
            </h1>

            <p className="text-lg sm:text-xl text-gray-600 dark:text-gray-300 max-w-2xl mb-10 leading-relaxed">
                Oups... la page que vous cherchez semble avoir disparu 🫥 <br />
                Vérifiez l’URL ou revenez à une page connue.
            </p>

            <div className="flex flex-col sm:flex-row gap-6 justify-center">
                <Button
                    variant="contained"
                    size="large"
                    startIcon={<ArrowBackIcon />}
                    onClick={() => navigate(-1)}
                    className="bg-linear-to-r from-cyan-500 to-purple-500 hover:from-purple-500 hover:to-cyan-500 text-white shadow-lg transition-all transform hover:-translate-y-1"
                >
                    Retour
                </Button>

                <Link to="/">
                    <Button
                        variant="outlined"
                        size="large"
                        startIcon={<Home />}
                        className="text-purple-600 dark:text-purple-300 border border-purple-600 dark:border-purple-300 hover:bg-purple-50 dark:hover:bg-purple-700 dark:hover:text-white shadow-md transition-all transform hover:-translate-y-1"
                    >
                        Accueil
                    </Button>
                </Link>
            </div>

            <p className="mt-10 text-sm text-gray-400 dark:text-gray-500">
                Code erreur : 404 — Ressource introuvable
            </p>
        </main>
    );
}
'@

$react_vite_mui_project_default_layout_content = @'
import { Outlet } from 'react-router-dom';

export default function DefaultLayout() {
    return <Outlet />;
}
'@

$react_vite_mui_project_toggle_mode_content = @'
import { UseThemeMode } from '@/theme/ThemeContext';
import { FormControl, MenuItem, Select, type SelectChangeEvent } from '@mui/material';
import SunnyIcon from '@mui/icons-material/Sunny';
import BedtimeIcon from '@mui/icons-material/Bedtime';
import LaptopWindowsIcon from '@mui/icons-material/LaptopWindows';

export default function ToggleMode({ className }: { className?: string }) {
    const { mode, setMode } = UseThemeMode();

    const handleChange = (event: SelectChangeEvent) => {
        setMode(event.target.value as 'light' | 'dark' | 'system');
    };

    return (
        <FormControl variant="outlined" size="small" className={ className }>
            <Select
                labelId="theme-select-label"
                value={mode}
                onChange={handleChange}
                className="bg-white dark:bg-gray-800 text-black dark:text-white"
                sx={{ minWidth: 130 }}
            >
                <MenuItem value="light">
                    <SunnyIcon className="mr-1" /> Light
                </MenuItem>
                <MenuItem value="dark">
                    <BedtimeIcon className="mr-1" /> Dark
                </MenuItem>
                <MenuItem value="system">
                    <LaptopWindowsIcon className="mr-1" /> System
                </MenuItem>
            </Select>
        </FormControl>
    );
}
'@

function New-ReactViteMaterialUi {
    param([string]$PROJECT_NAME)

    if (-not $PROJECT_NAME) { $PROJECT_NAME = Read-Host "Project name" }

    Write-Host "Creating project: $PROJECT_NAME (Vite + React 18 + MUI + TypeScript)"
    Write-Output n | npx create-vite@latest "$PROJECT_NAME" --template react-ts

    Set-Location "$PROJECT_NAME"

    Clear-Host
    Write-Host "Installing dependencies..."
    npm install @mui/material @emotion/react @emotion/styled @fontsource/roboto @mui/icons-material react-router-dom tailwindcss @tailwindcss/vite

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

    Set-Content "vite.config.ts" -Value $react_vite_mui_project_config_content -Encoding UTF8
    Set-Content "tsconfig.app.json" -Value $react_vite_mui_project_tsconfig_app_content -Encoding UTF8
    Set-Content "src/main.tsx" -Value $react_vite_mui_project_main_content -Encoding UTF8
    Set-Content "src/theme/ThemeContext.tsx" -Value $react_vite_mui_project_theme_content -Encoding UTF8
    Set-Content "src/styles/index.css" -Value $react_vite_mui_project_style_content -Encoding UTF8
    Set-Content "src/routes/index.tsx" -Value $react_vite_mui_project_route_content -Encoding UTF8
    Set-Content "src/pages/Home.tsx" -Value $react_vite_mui_project_home_page_content -Encoding UTF8
    Set-Content "src/pages/NotFound.tsx" -Value $react_vite_mui_project_not_found_page_content -Encoding UTF8
    Set-Content "src/layouts/default.tsx" -Value $react_vite_mui_project_default_layout_content -Encoding UTF8
    Set-Content "src/components/ToggleMode.tsx" -Value $react_vite_mui_project_toggle_mode_content -Encoding UTF8

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