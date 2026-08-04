$react_vite_shadecn_project_config_content = @'
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

$react_vite_shadecn_project_tsconfig_content = @'
{
    "files": [],
    "references": [{ "path": "./tsconfig.app.json" }, { "path": "./tsconfig.node.json" }],
    "compilerOptions": {
        "paths": {
            "@/*": ["./src/*"]
        }
    }
}
'@

$react_vite_shadecn_project_tsconfig_app_content = @'
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

$react_vite_shadecn_project_main_content = @'
import '@/styles/index.css';

import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';
import { RouterProvider } from 'react-router-dom';
import { ThemeProvider } from '@/theme/ThemeProvider';
import router from '@/routes';

createRoot(document.getElementById('root')!).render(
    <StrictMode>
        <ThemeProvider defaultTheme="system" storageKey="vite-ui-theme">
            <RouterProvider router={router} />
        </ThemeProvider>
    </StrictMode>,
);
'@

$react_vite_shadecn_project_theme_content = @'
import { createContext, type ReactNode, useContext, useEffect, useState } from 'react';

type Theme = 'dark' | 'light' | 'system';

type ThemeProviderProps = {
    children: ReactNode;
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

    useEffect(() => {
        if (theme !== 'system') return;

        const media = window.matchMedia('(prefers-color-scheme: dark)');
        const onChange = () => {
            const root = window.document.documentElement;
            root.classList.remove('light', 'dark');
            root.classList.add(media.matches ? 'dark' : 'light');
        };

        media.addEventListener('change', onChange);
        return () => media.removeEventListener('change', onChange);
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

$react_vite_shadecn_project_style_content = @'
@import 'tailwindcss';

@custom-variant dark (&:is(.dark *));
'@

$react_vite_shadecn_project_route_content = @'
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

$react_vite_shadecn_project_home_page_content = @'
import { ToggleMode } from '@/components/ToggleMode';
import { Button } from '@/components/ui/button';
import { BookOpen, HomeIcon, Rocket } from 'lucide-react';

export default function Home() {
    return (
        <main className="relative flex min-h-screen flex-col items-center justify-center overflow-hidden px-6 py-16 text-center bg-linear-to-br from-slate-50 via-white to-indigo-50 transition-colors dark:from-gray-950 dark:via-gray-900 dark:to-indigo-950">
            <div className="pointer-events-none absolute -top-24 -left-24 h-72 w-72 rounded-full bg-cyan-400/20 blur-3xl" />
            <div className="pointer-events-none absolute -bottom-24 -right-24 h-72 w-72 rounded-full bg-purple-500/20 blur-3xl" />

            <span className="mb-6 inline-flex items-center gap-2 rounded-full border border-cyan-200/60 bg-white/60 px-4 py-1.5 text-xs font-semibold tracking-wider text-cyan-700 uppercase shadow-sm backdrop-blur dark:border-cyan-800 dark:bg-gray-800/60 dark:text-cyan-300">
                <span className="relative flex h-2 w-2">
                    <span className="absolute inline-flex h-full w-full animate-ping rounded-full bg-cyan-400 opacity-75" />
                    <span className="relative inline-flex h-2 w-2 rounded-full bg-cyan-500" />
                </span>
                React 19 • Shadcn UI
            </span>

            <span className="mb-8 inline-flex h-20 w-20 items-center justify-center rounded-2xl bg-linear-to-br from-cyan-500 to-purple-500 text-white shadow-lg shadow-cyan-500/25">
                <HomeIcon size={40} />
            </span>

            <h1 className="mb-5 max-w-2xl text-4xl font-extrabold tracking-tight text-gray-900 sm:text-5xl dark:text-white">
                Bienvenue sur votre projet React
            </h1>

            <p className="mb-10 max-w-2xl text-lg leading-relaxed text-gray-600 sm:text-xl dark:text-gray-300">
                Ce projet est pré-configuré avec{' '}
                <span className="font-semibold text-cyan-600 dark:text-cyan-400"> Shadcn UI</span>,
                <span className="font-semibold text-purple-600 dark:text-purple-400"> TailwindCSS</span>{' '}
                et
                <span className="font-semibold text-pink-600 dark:text-pink-400">
                    {' '}
                    Lucide Icons{' '}
                </span>
                pour un développement rapide et élégant.
            </p>

            <div className="flex flex-col items-center gap-4 sm:flex-row">
                <Button
                    size="lg"
                    className="w-full cursor-pointer bg-linear-to-r from-cyan-500 to-purple-500 text-white shadow-lg transition-all duration-300 hover:-translate-y-0.5 hover:from-purple-500 hover:to-cyan-500 sm:w-auto"
                >
                    <Rocket size={20} />
                    Démarrer
                </Button>

                <Button
                    variant="outline"
                    size="lg"
                    className="w-full cursor-pointer border-purple-300 text-purple-600 shadow-sm transition-all duration-300 hover:-translate-y-0.5 hover:bg-purple-50 sm:w-auto dark:border-purple-700 dark:text-purple-300 dark:hover:bg-purple-900/50"
                >
                    <BookOpen size={20} />
                    Documentation
                </Button>
            </div>

            <ToggleMode className="fixed top-5 right-5 z-50" />
        </main>
    );
}
'@

$react_vite_shadecn_project_not_found_page_content = @'
import { Button } from '@/components/ui/button';
import { ArrowLeft, Ban, HomeIcon } from 'lucide-react';
import { Link, useNavigate } from 'react-router-dom';

export default function NotFound() {
    const navigate = useNavigate();

    return (
        <main className="relative flex min-h-screen flex-col items-center justify-center overflow-hidden px-6 py-16 text-center bg-linear-to-br from-slate-50 via-white to-indigo-50 transition-colors dark:from-gray-950 dark:via-gray-900 dark:to-indigo-950">
            <div className="pointer-events-none absolute -top-24 -left-24 h-72 w-72 rounded-full bg-pink-400/20 blur-3xl" />
            <div className="pointer-events-none absolute -bottom-24 -right-24 h-72 w-72 rounded-full bg-purple-500/20 blur-3xl" />

            <span className="mb-6 inline-flex items-center gap-2 rounded-full border border-pink-200/60 bg-white/60 px-4 py-1.5 text-xs font-semibold tracking-wider text-pink-600 uppercase shadow-sm backdrop-blur dark:border-pink-800 dark:bg-gray-800/60 dark:text-pink-300">
                Erreur 404
            </span>

            <span className="mb-8 inline-flex h-20 w-20 items-center justify-center rounded-2xl bg-linear-to-br from-pink-500 to-purple-500 text-white shadow-lg shadow-pink-500/25">
                <Ban size={40} />
            </span>

            <h1 className="mb-5 max-w-2xl text-4xl font-extrabold tracking-tight text-gray-900 sm:text-5xl dark:text-white">
                Page introuvable
            </h1>

            <p className="mb-10 max-w-2xl text-lg leading-relaxed text-gray-600 sm:text-xl dark:text-gray-300">
                Oups... la page que vous cherchez semble avoir disparu 🫥 <br />
                Vérifiez l'URL ou revenez à une page connue.
            </p>

            <div className="flex flex-col items-center gap-4 sm:flex-row">
                <Button
                    size="lg"
                    onClick={() => navigate(-1)}
                    className="w-full cursor-pointer bg-linear-to-r from-pink-500 to-purple-500 text-white shadow-lg transition-all duration-300 hover:-translate-y-0.5 hover:from-purple-500 hover:to-pink-500 sm:w-auto"
                >
                    <ArrowLeft size={20} />
                    Retour
                </Button>

                <Link to="/">
                    <Button
                        variant="outline"
                        size="lg"
                        className="w-full cursor-pointer border-purple-300 text-purple-600 shadow-sm transition-all duration-300 hover:-translate-y-0.5 hover:bg-purple-50 sm:w-auto dark:border-purple-700 dark:text-purple-300 dark:hover:bg-purple-900/50"
                    >
                        <HomeIcon size={20} />
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

$react_vite_shadecn_project_default_layout_content = @'
import { Outlet } from 'react-router-dom';

export default function DefaultLayout() {
    return <Outlet />;
}
'@

$react_vite_shadecn_project_toogle_mode_content = @'
import { Check, Monitor, Moon, Sun } from 'lucide-react';

import { Button } from '@/components/ui/button';
import {
    DropdownMenu,
    DropdownMenuContent,
    DropdownMenuItem,
    DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu';
import { UseTheme } from '@/theme/ThemeProvider';

const OPTIONS = [
    { value: 'light', label: 'Light', Icon: Sun },
    { value: 'dark', label: 'Dark', Icon: Moon },
    { value: 'system', label: 'System', Icon: Monitor },
] as const;

export function ToggleMode({ className }: { className?: string }) {
    const { theme, setTheme } = UseTheme();

    const CurrentIcon = OPTIONS.find((o) => o.value === theme)?.Icon ?? Monitor;

    return (
        <div className={className}>
            <DropdownMenu>
                <DropdownMenuTrigger asChild>
                    <Button variant="outline" size="icon" aria-label="Changer de thème">
                        <CurrentIcon size={22} />
                    </Button>
                </DropdownMenuTrigger>
                <DropdownMenuContent align="end" className="min-w-[10rem]">
                    {OPTIONS.map(({ value, label, Icon }) => (
                        <DropdownMenuItem key={value} onClick={() => setTheme(value)}>
                            <Icon size={18} className="mr-2 h-4 w-4" />
                            <span>{label}</span>
                            {theme === value && <Check size={18} className="ml-auto h-4 w-4" />}
                        </DropdownMenuItem>
                    ))}
                </DropdownMenuContent>
            </DropdownMenu>
        </div>
    );
}
'@

<#
.SYNOPSIS
    Crée un projet Vite + React 19 + Shadcn UI + TypeScript pré-configuré.

.DESCRIPTION
    Installe TailwindCSS, initialise Shadcn (boutons + dropdown-menu) et React Router,
    puis génère le layout, les pages Home/404 et le sélecteur de thème.

.PARAMETER PROJECT_NAME
    Nom du répertoire du projet à créer.

.EXAMPLE
    New-ReactViteShadecnUi myapp
#>
function New-ReactViteShadecnUi {
    param([string]$PROJECT_NAME)

    if (-not $PROJECT_NAME) { $PROJECT_NAME = Read-Host "Project name" }

    Write-Host "Creating project: $PROJECT_NAME (Vite + React 19 + Shadcn UI + TypeScript)"
    npx create-vite@latest "$PROJECT_NAME" --template react-ts --no-immediate

    Set-Location "$PROJECT_NAME"

    Clear-Host
    Write-Host "Installing dependencies..."
    npm install react-router-dom tailwindcss @tailwindcss/vite

    $PRETTIE = Read-Host "Would you like to install Prettier? (Y/N)"
    if ($PRETTIE.Trim() -match '^[Yy]') {
        Install-Prettier
    }

    Remove-Item "src/App.css" -Recurse -Force -ErrorAction SilentlyContinue
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

    Set-Content "vite.config.ts" -Value $react_vite_shadecn_project_config_content -Encoding UTF8
    Set-Content "tsconfig.json" -Value $react_vite_shadecn_project_tsconfig_content -Encoding UTF8
    Set-Content "tsconfig.app.json" -Value $react_vite_shadecn_project_tsconfig_app_content -Encoding UTF8

    Write-Host "Initializing Shadcn UI..."
    npx shadcn@latest init -y -b neutral -f
    npx shadcn@latest add button dropdown-menu -y

    Move-Item "src/index.css" "src/styles/index.css" -Force -ErrorAction SilentlyContinue

    Set-Content "vite.config.ts" -Value $react_vite_shadecn_project_config_content -Encoding UTF8
    Set-Content "src/main.tsx" -Value $react_vite_shadecn_project_main_content -Encoding UTF8
    Set-Content "src/theme/ThemeProvider.tsx" -Value $react_vite_shadecn_project_theme_content -Encoding UTF8
    Set-Content "src/routes/index.tsx" -Value $react_vite_shadecn_project_route_content -Encoding UTF8
    Set-Content "src/pages/Home.tsx" -Value $react_vite_shadecn_project_home_page_content -Encoding UTF8
    Set-Content "src/pages/NotFound.tsx" -Value $react_vite_shadecn_project_not_found_page_content -Encoding UTF8
    Set-Content "src/layouts/default.tsx" -Value $react_vite_shadecn_project_default_layout_content -Encoding UTF8
    Set-Content "src/components/ToggleMode.tsx" -Value $react_vite_shadecn_project_toogle_mode_content -Encoding UTF8

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
