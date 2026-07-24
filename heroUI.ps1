$react_vite_heroui_project_config_content = @'
import { defineConfig } from 'vite';
import path from 'path';
import react from '@vitejs/plugin-react';
import tailwindcss from '@tailwindcss/vite';

// https://vite.dev/config/
export default defineConfig({
    server: {
        port: 5173,
        host: '::',
    },
    plugins: [react(), tailwindcss()],
    resolve: {
        tsconfigPaths: true,
        alias: {
            '@': path.resolve(__dirname, 'src'),
        },
    },
});
'@

$react_vite_heroui_project_tsconfig_app_content = @'
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

$react_vite_heroui_project_main_content = @'
import '@/styles/index.css';

import router from '@/routes';
import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';
import { RouterProvider } from 'react-router-dom';
import { ThemeProvider } from './theme/ThemeProvider';

createRoot(document.getElementById('root')!).render(
    <StrictMode>
        <ThemeProvider defaultTheme="system" storageKey="vite-ui-theme">
            <RouterProvider router={router} />
        </ThemeProvider>
    </StrictMode>,
);
'@

$react_vite_heroui_project_theme_content = @'
import { createContext, useContext, useEffect, useState } from 'react';

type Theme = 'dark' | 'light' | 'system';

type ThemeProviderProps = {
    children: React.ReactNode;
    defaultTheme?: Theme;
    storageKey?: string;
};

type ThemeProviderState = {
    theme: Theme;
    setTheme: (theme: Theme) => void;
};

const initialState: ThemeProviderState = {
    theme: 'system',
    setTheme: () => null,
};

const ThemeProviderContext = createContext<ThemeProviderState>(initialState);

export function ThemeProvider({
    children,
    defaultTheme = 'system',
    storageKey = 'vite-ui-theme',
    ...props
}: ThemeProviderProps) {
    const [theme, setTheme] = useState<Theme>(
        () => (localStorage.getItem(storageKey) as Theme) || defaultTheme,
    );

    useEffect(() => {
        const root = window.document.documentElement;

        root.classList.remove('light', 'dark');

        if (theme === 'system') {
            const systemTheme = window.matchMedia('(prefers-color-scheme: dark)').matches
                ? 'dark'
                : 'light';

            root.classList.add(systemTheme);
            return;
        }

        root.classList.add(theme);
    }, [theme]);

    const value = {
        theme,
        setTheme: (theme: Theme) => {
            localStorage.setItem(storageKey, theme);
            setTheme(theme);
        },
    };

    return (
        <ThemeProviderContext.Provider {...props} value={value}>
            {children}
        </ThemeProviderContext.Provider>
    );
}

export const UseTheme = () => {
    const context = useContext(ThemeProviderContext);

    if (context === undefined) throw new Error('useTheme must be used within a ThemeProvider');

    return context;
};
'@

$react_vite_heroui_project_style_content = @'
@layer theme, base, components, utilities;
@import 'tailwindcss';
@import '@heroui/styles';

@custom-variant dark (&:is(.dark *));
'@

$react_vite_heroui_project_route_content = @'
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

$react_vite_heroui_project_home_page_content = @'
import ToggleMode from '@/components/ToggleMode';
import { Button } from '@heroui/react';
import { HomeIcon } from 'lucide-react';

export default function Home() {
    return (
        <main className="min-h-screen flex flex-col items-center justify-center px-6 text-center bg-linear-to-br from-cyan-50 via-purple-50 to-pink-50 dark:from-gray-900 dark:via-gray-800 dark:to-gray-900 transition-colors">
            <HomeIcon size={50} className="text-cyan-600 dark:text-cyan-400 mb-6 animate-bounce" />

            <h1 className="text-3xl sm:text-4xl md:text-5xl font-extrabold text-gray-900 dark:text-white mb-8 drop-shadow-lg">
                Bienvenue sur votre projet React
            </h1>

            <p className="text-lg sm:text-xl md:text-2xl text-gray-600 dark:text-gray-300 max-w-2xl mb-10 leading-relaxed">
                Ce projet est pré-configuré avec{' '}
                <span className="font-semibold text-cyan-600 dark:text-cyan-400"> Hero UI</span>,
                <span className="font-semibold text-purple-600 dark:text-purple-300">
                    {' '}
                    TailwindCSS
                </span>{' '}
                et
                <span className="font-semibold text-pink-600 dark:text-pink-300">
                    {' '}
                    Lucide Icons{' '}
                </span>
                pour un développement rapide et élégant.
            </p>

            <div className="flex flex-col sm:flex-row gap-6 justify-center">
                <Button
                    variant="secondary"
                    size="lg"
                    className="bg-linear-to-r from-cyan-500 to-purple-500 hover:from-purple-500 hover:to-cyan-500 text-white shadow-lg transition-all transform hover:-translate-y-1"
                >
                    <HomeIcon /> Démarrer
                </Button>

                <Button
                    variant="outline"
                    size="lg"
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

$react_vite_heroui_project_not_found_page_content = @'
import { Button } from '@heroui/react';
import { ArrowLeft, BanIcon, HomeIcon } from 'lucide-react';
import { Link, useNavigate } from 'react-router-dom';

export default function NotFound() {
    const navigate = useNavigate();

    return (
        <main className="min-h-screen flex flex-col items-center justify-center px-6 text-center bg-linear-to-br from-cyan-50 via-purple-50 to-pink-50 dark:from-gray-900 dark:via-gray-800 dark:to-gray-900 transition-colors">
            <BanIcon
                size={50}
                className="text-pink-600 dark:text-pink-400 text-7xl mb-6 animate-pulse"
            />

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
                    variant="secondary"
                    size="lg"
                    onClick={() => navigate(-1)}
                    className="bg-linear-to-r from-cyan-500 to-purple-500 hover:from-purple-500 hover:to-cyan-500 text-white shadow-lg transition-all transform hover:-translate-y-1 cursor-pointer"
                >
                    <ArrowLeft /> Retour
                </Button>

                <Link to="/">
                    <Button
                        variant="outline"
                        size="lg"
                        className="text-purple-600 dark:text-purple-300 border border-purple-600 dark:border-purple-300 hover:bg-purple-50 dark:hover:bg-purple-700 dark:hover:text-white shadow-md transition-all transform hover:-translate-y-1 cursor-pointer"
                    >
                        <HomeIcon /> Accueil
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

$react_vite_heroui_project_default_layout_content = @'
import { Outlet } from 'react-router-dom';

export default function DefaultLayout() {
    return <Outlet />;
}
'@

$react_vite_heroui_project_toggle_mode_content = @'
import { UseTheme } from '@/theme/ThemeProvider';
import { ListBox, Select } from '@heroui/react';
import { Monitor, Moon, Sun } from 'lucide-react';

export default function ToggleMode({ className }: { className?: string }) {
    const { theme, setTheme } = UseTheme();

    return (
        <Select
            className={className}
            selectedKey={theme}
            onSelectionChange={(key) => setTheme(key as 'dark' | 'light' | 'system')}
        >
            <Select.Trigger>
                <Select.Value />
                <Select.Indicator />
            </Select.Trigger>

            <Select.Popover>
                <ListBox>
                    <ListBox.Item id="system" textValue="System">
                        <div className="flex items-center gap-2">
                            <Monitor size={20} /> System
                        </div>
                        <ListBox.ItemIndicator />
                    </ListBox.Item>

                    <ListBox.Item id="light" textValue="Light">
                        <div className="flex items-center gap-2">
                            <Sun size={20} /> Light
                        </div>
                        <ListBox.ItemIndicator />
                    </ListBox.Item>

                    <ListBox.Item id="dark" textValue="Dark">
                        <div className="flex items-center gap-2">
                            <Moon size={20} /> Dark
                        </div>
                        <ListBox.ItemIndicator />
                    </ListBox.Item>
                </ListBox>
            </Select.Popover>
        </Select>
    );
}
'@

function New-ReactViteHeroUi {
    param([string]$PROJECT_NAME)

    if (-not $PROJECT_NAME) { $PROJECT_NAME = Read-Host "Project name" }

    Write-Host "Creating project: $PROJECT_NAME (Vite + React 18 + Hero UI + TypeScript)"
    Write-Output n | npx create-vite@latest "$PROJECT_NAME" --template react-ts

    Set-Location "$PROJECT_NAME"

    Clear-Host
    Write-Host "Installing dependencies..."
    npm install @heroui/styles @heroui/react react-router-dom tailwindcss @tailwindcss/vite lucide-react@next

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

    Set-Content "vite.config.ts" -Value $react_vite_heroui_project_config_content -Encoding UTF8
    Set-Content "tsconfig.app.json" -Value $react_vite_heroui_project_tsconfig_app_content -Encoding UTF8
    Set-Content "src/styles/index.css" -Value $react_vite_heroui_project_style_content -Encoding UTF8
    Set-Content "src/main.tsx" -Value $react_vite_heroui_project_main_content -Encoding UTF8
    Set-Content "src/theme/ThemeProvider.tsx" -Value $react_vite_heroui_project_theme_content -Encoding UTF8
    Set-Content "src/routes/index.tsx" -Value $react_vite_heroui_project_route_content -Encoding UTF8
    Set-Content "src/pages/Home.tsx" -Value $react_vite_heroui_project_home_page_content -Encoding UTF8
    Set-Content "src/pages/NotFound.tsx" -Value $react_vite_heroui_project_not_found_page_content -Encoding UTF8
    Set-Content "src/layouts/default.tsx" -Value $react_vite_heroui_project_default_layout_content -Encoding UTF8
    Set-Content "src/components/ToggleMode.tsx" -Value $react_vite_heroui_project_toggle_mode_content -Encoding UTF8

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