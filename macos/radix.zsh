#!/usr/bin/env zsh
# radix.zsh — Crée un projet Vite + React 19 + Radix UI + TypeScript pré-configuré.

new_react_vite_radix() {
    local PROJECT_NAME="${1:-}"

    if [ -z "$PROJECT_NAME" ]; then
        read -r "PROJECT_NAME?Project name: "
    fi

    echo "Creating project: $PROJECT_NAME (Vite + React 19 + Radix UI + TypeScript)"
    npx create-vite@latest "$PROJECT_NAME" --template react-ts --no-immediate

    cd "$PROJECT_NAME" || return 1

    clear
    echo "Installing dependencies..."
    npm install react-router-dom tailwindcss @tailwindcss/vite @radix-ui/react-dropdown-menu lucide-react

    local PRETTIE
    read -r "PRETTIE?Would you like to install Prettier? (Y/N): "
    if [[ "$PRETTIE" =~ ^[Yy] ]]; then
        install_prettier
    fi

    rm -f src/App.css src/index.css src/App.tsx

    mkdir -p src/components src/layouts src/pages src/routes src/styles src/theme

    cat > vite.config.ts <<'EOF'
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
import { ThemeProvider } from '@/theme/ThemeProvider';
import router from '@/routes';

createRoot(document.getElementById('root')!).render(
    <StrictMode>
        <ThemeProvider defaultTheme="system" storageKey="vite-ui-theme">
            <RouterProvider router={router} />
        </ThemeProvider>
    </StrictMode>,
);
EOF
    cat > src/theme/ThemeProvider.tsx <<'EOF'
import { createContext, type ReactNode, useContext, useEffect, useState } from 'react';

export type Theme = 'dark' | 'light' | 'system';

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

        const systemTheme = window.matchMedia('(prefers-color-scheme: dark)').matches
            ? 'dark'
            : 'light';
        const resolved = theme === 'system' ? systemTheme : theme;

        root.classList.add(resolved);
        root.setAttribute('data-theme', resolved);
    }, [theme]);

    useEffect(() => {
        if (theme !== 'system') return;

        const media = window.matchMedia('(prefers-color-scheme: dark)');
        const onChange = () => {
            const root = window.document.documentElement;
            const next = media.matches ? 'dark' : 'light';
            root.classList.remove('light', 'dark');
            root.classList.add(next);
            root.setAttribute('data-theme', next);
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
EOF
    cat > src/styles/index.css <<'EOF'
@import 'tailwindcss';

@custom-variant dark (&:is(.dark *));
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
import ToggleMode from '@/components/ToggleMode';
import { BookOpen, HomeIcon, Rocket } from 'lucide-react';

export default function Home() {
    return (
        <main className="relative flex min-h-screen flex-col items-center justify-center overflow-hidden px-6 py-16 text-center bg-linear-to-br from-slate-50 via-white to-indigo-50 transition-colors dark:from-gray-950 dark:via-gray-900 dark:to-indigo-950">
            <div className="pointer-events-none absolute -top-24 -left-24 h-72 w-72 rounded-full bg-cyan-400/20 blur-3xl" />
            <div className="pointer-events-none absolute -bottom-24 -right-24 h-72 w-72 rounded-full bg-purple-500/20 blur-3xl" />

            <span className="mb-6 inline-flex items-center gap-2 rounded-full border border-cyan-200/70 bg-cyan-50/50 px-4 py-1.5 text-xs font-semibold tracking-wider text-cyan-700 uppercase shadow-sm backdrop-blur dark:border-cyan-800 dark:bg-cyan-950/40 dark:text-cyan-300">
                <span className="relative flex h-2 w-2">
                    <span className="absolute inline-flex h-full w-full animate-ping rounded-full bg-cyan-400 opacity-75" />
                    <span className="relative inline-flex h-2 w-2 rounded-full bg-cyan-500" />
                </span>
                React 19 • Radix UI
            </span>

            <span className="mb-8 inline-flex h-20 w-20 items-center justify-center rounded-2xl bg-linear-to-br from-cyan-500 to-purple-500 text-white shadow-lg shadow-cyan-500/25">
                <HomeIcon size={40} />
            </span>

            <h1 className="mb-5 max-w-2xl text-4xl font-extrabold tracking-tight text-gray-900 sm:text-5xl dark:text-white">
                Bienvenue sur votre projet React
            </h1>

            <p className="mb-10 max-w-2xl text-lg leading-relaxed text-gray-600 sm:text-xl dark:text-gray-300">
                Ce projet est pré-configuré avec{' '}
                <span className="font-semibold text-cyan-600 dark:text-cyan-400">Radix UI</span>,
                <span className="font-semibold text-purple-600 dark:text-purple-400"> TailwindCSS</span>{' '}
                et
                <span className="font-semibold text-pink-600 dark:text-pink-400">
                    {' '}
                    Lucide Icons{' '}
                </span>
                pour un développement rapide et élégant.
            </p>

            <div className="flex flex-col items-center gap-4 sm:flex-row">
                <button
                    type="button"
                    className="inline-flex items-center gap-2 rounded-xl bg-linear-to-r from-cyan-500 to-purple-500 px-6 py-3 text-base font-semibold text-white shadow-lg transition-all duration-300 hover:-translate-y-0.5 hover:from-purple-500 hover:to-cyan-500"
                >
                    <Rocket size={20} />
                    Démarrer
                </button>

                <button
                    type="button"
                    className="inline-flex items-center gap-2 rounded-xl border border-purple-300 px-6 py-3 text-base font-semibold text-purple-600 shadow-sm transition-all duration-300 hover:-translate-y-0.5 hover:border-purple-400 hover:bg-purple-50 dark:border-purple-700 dark:text-purple-300 dark:hover:bg-purple-900/50"
                >
                    <BookOpen size={20} />
                    Documentation
                </button>
            </div>

            <ToggleMode className="fixed top-5 right-5 z-50" />
        </main>
    );
}
EOF
    cat > src/pages/NotFound.tsx <<'EOF'
import ToggleMode from '@/components/ToggleMode';
import { ArrowLeft, Ban, HomeIcon } from 'lucide-react';
import { Link, useNavigate } from 'react-router-dom';

export default function NotFound() {
    const navigate = useNavigate();

    return (
        <main className="relative flex min-h-screen flex-col items-center justify-center overflow-hidden px-6 py-16 text-center bg-linear-to-br from-slate-50 via-white to-indigo-50 transition-colors dark:from-gray-950 dark:via-gray-900 dark:to-indigo-950">
            <div className="pointer-events-none absolute -top-24 -left-24 h-72 w-72 rounded-full bg-pink-400/20 blur-3xl" />
            <div className="pointer-events-none absolute -bottom-24 -right-24 h-72 w-72 rounded-full bg-purple-500/20 blur-3xl" />

            <span className="mb-6 inline-flex items-center gap-2 rounded-full border border-pink-200/70 bg-pink-50/50 px-4 py-1.5 text-xs font-semibold tracking-wider text-pink-600 uppercase shadow-sm backdrop-blur dark:border-pink-800 dark:bg-pink-950/40 dark:text-pink-300">
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
                <button
                    type="button"
                    onClick={() => navigate(-1)}
                    className="inline-flex items-center gap-2 rounded-xl bg-linear-to-r from-pink-500 to-purple-500 px-6 py-3 text-base font-semibold text-white shadow-lg transition-all duration-300 hover:-translate-y-0.5 hover:from-purple-500 hover:to-pink-500"
                >
                    <ArrowLeft size={20} />
                    Retour
                </button>

                <Link to="/">
                    <button
                        type="button"
                        className="inline-flex items-center gap-2 rounded-xl border border-purple-300 px-6 py-3 text-base font-semibold text-purple-600 shadow-sm transition-all duration-300 hover:-translate-y-0.5 hover:border-purple-400 hover:bg-purple-50 dark:border-purple-700 dark:text-purple-300 dark:hover:bg-purple-900/50"
                    >
                        <HomeIcon size={20} />
                        Accueil
                    </button>
                </Link>
            </div>

            <p className="mt-10 text-sm text-gray-400 dark:text-gray-500">
                Code erreur : 404 — Ressource introuvable
            </p>

            <ToggleMode className="fixed top-5 right-5 z-50" />
        </main>
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
import { UseTheme, type Theme } from '@/theme/ThemeProvider';
import * as DropdownMenu from '@radix-ui/react-dropdown-menu';
import { Monitor, Moon, Sun } from 'lucide-react';

const OPTIONS: { value: Theme; label: string; Icon: typeof Sun }[] = [
    { value: 'light', label: 'Light', Icon: Sun },
    { value: 'dark', label: 'Dark', Icon: Moon },
    { value: 'system', label: 'System', Icon: Monitor },
];

export default function ToggleMode({ className }: { className?: string }) {
    const { theme, setTheme } = UseTheme();
    const CurrentIcon = OPTIONS.find((option) => option.value === theme)?.Icon ?? Sun;

    return (
        <div className={className}>
            <DropdownMenu.Root>
                <DropdownMenu.Trigger asChild>
                    <button
                        type="button"
                        className="inline-flex h-9 items-center gap-2 rounded-full border border-gray-300 bg-white/80 px-4 text-sm font-medium text-gray-700 shadow-sm backdrop-blur transition-colors hover:bg-gray-100 dark:border-gray-700 dark:bg-gray-900/80 dark:text-gray-200 dark:hover:bg-gray-800"
                    >
                        <CurrentIcon size={16} />
                        {theme}
                    </button>
                </DropdownMenu.Trigger>

                <DropdownMenu.Portal>
                    <DropdownMenu.Content
                        sideOffset={6}
                        align="end"
                        className="z-50 min-w-[150px] rounded-xl border border-gray-200 bg-white p-1.5 shadow-lg dark:border-gray-700 dark:bg-gray-900"
                    >
                        {OPTIONS.map(({ value, label, Icon }) => (
                            <DropdownMenu.Item
                                key={value}
                                onSelect={() => setTheme(value)}
                                className="flex cursor-pointer items-center gap-2 rounded-lg px-3 py-2 text-sm text-gray-700 outline-none select-none data-[highlighted]:bg-gray-100 dark:text-gray-200 dark:data-[highlighted]:bg-gray-800"
                            >
                                <Icon size={16} />
                                {label}
                            </DropdownMenu.Item>
                        ))}
                    </DropdownMenu.Content>
                </DropdownMenu.Portal>
            </DropdownMenu.Root>
        </div>
    );
}
EOF

    if [[ "$PRETTIE" =~ ^[Yy] ]]; then
        npm run format
    fi

    local GIT
    read -r "GIT?Would you like to initialize Git? (Y/N): "
    if [[ "$GIT" =~ ^[Yy] ]]; then
        git init
        git add -A
        git commit -m "Initial commit"
    fi

    echo "Project setup completed successfully."
    npm run dev
}