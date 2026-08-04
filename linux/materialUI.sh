#!/usr/bin/env bash
# materialUI.sh — Crée un projet Vite + React 19 + Material UI + TypeScript pré-configuré.

new_react_vite_material_ui() {
    local PROJECT_NAME="${1:-}"

    if [ -z "$PROJECT_NAME" ]; then
        read -r -p "Project name: " PROJECT_NAME
    fi

    echo "Creating project: $PROJECT_NAME (Vite + React 19 + MUI + TypeScript)"
    npx create-vite@latest "$PROJECT_NAME" --template react-ts --no-immediate

    cd "$PROJECT_NAME" || return 1

    clear
    echo "Installing dependencies..."
    npm install @mui/material @emotion/react @emotion/styled @fontsource/roboto @mui/icons-material react-router-dom tailwindcss @tailwindcss/vite

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
    </StrictMode>,
);
EOF

    cat > src/theme/ThemeContext.tsx <<'EOF'
import { createContext, type ReactNode, useContext, useEffect, useMemo, useState } from 'react';
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
    const [systemDark, setSystemDark] = useState(() =>
        window.matchMedia('(prefers-color-scheme: dark)').matches,
    );

    useEffect(() => {
        const media = window.matchMedia('(prefers-color-scheme: dark)');
        const onChange = () => setSystemDark(media.matches);
        media.addEventListener('change', onChange);
        return () => media.removeEventListener('change', onChange);
    }, []);

    const isDark = mode === 'system' ? systemDark : mode === 'dark';

    useEffect(() => {
        const root = document.documentElement;
        root.classList.toggle('dark', isDark);
        localStorage.setItem('theme', mode);
    }, [mode, isDark]);

    const muiTheme = useMemo(
        () =>
            createTheme({
                palette: { mode: isDark ? 'dark' : 'light', primary: { main: '#06b6d4' } },
            }),
        [isDark],
    );

    return (
        <ThemeContext.Provider value={{ mode, setMode }}>
            <ThemeProvider theme={muiTheme}>
                <CssBaseline />
                {children}
            </ThemeProvider>
        </ThemeContext.Provider>
    );
}
EOF

    cat > src/styles/index.css <<'EOF'
@layer theme, base, mui, components, utilities;
@import 'tailwindcss';
@custom-variant dark (&:where(.dark, .dark *));
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
import { Button } from '@mui/material';
import { Home as HomeIcon, MenuBook, RocketLaunch } from '@mui/icons-material';
import ToggleMode from '@/components/ToggleMode';

export default function HomePage() {
    return (
        <main className="relative flex min-h-screen flex-col items-center justify-center overflow-hidden px-6 py-16 text-center bg-linear-to-br from-slate-50 via-white to-indigo-50 transition-colors dark:from-gray-950 dark:via-gray-900 dark:to-indigo-950">
            <div className="pointer-events-none absolute -top-24 -left-24 h-72 w-72 rounded-full bg-cyan-400/20 blur-3xl" />
            <div className="pointer-events-none absolute -bottom-24 -right-24 h-72 w-72 rounded-full bg-purple-500/20 blur-3xl" />

            <span className="mb-6 inline-flex items-center gap-2 rounded-full border border-cyan-200/60 bg-white/60 px-4 py-1.5 text-xs font-semibold tracking-wider text-cyan-700 uppercase shadow-sm backdrop-blur dark:border-cyan-800 dark:bg-gray-800/60 dark:text-cyan-300">
                <span className="relative flex h-2 w-2">
                    <span className="absolute inline-flex h-full w-full animate-ping rounded-full bg-cyan-400 opacity-75" />
                    <span className="relative inline-flex h-2 w-2 rounded-full bg-cyan-500" />
                </span>
                React 19 • Material UI
            </span>

            <span className="mb-8 inline-flex h-20 w-20 items-center justify-center rounded-2xl bg-linear-to-br from-cyan-500 to-purple-500 text-white shadow-lg shadow-cyan-500/25">
                <HomeIcon fontSize="large" />
            </span>

            <h1 className="mb-5 max-w-2xl text-4xl font-extrabold tracking-tight text-gray-900 sm:text-5xl dark:text-white">
                Bienvenue sur votre projet React
            </h1>

            <p className="mb-10 max-w-2xl text-lg leading-relaxed text-gray-600 sm:text-xl dark:text-gray-300">
                Ce projet est pré-configuré avec{' '}
                <span className="font-semibold text-cyan-600 dark:text-cyan-400"> Material UI</span>,
                <span className="font-semibold text-purple-600 dark:text-purple-400"> TailwindCSS</span>{' '}
                et
                <span className="font-semibold text-pink-600 dark:text-pink-400">
                    {' '}
                    Material Icons{' '}
                </span>
                pour un développement rapide et élégant.
            </p>

            <div className="flex flex-col items-center gap-4 sm:flex-row">
                <Button
                    variant="contained"
                    size="large"
                    startIcon={<RocketLaunch />}
                    className="bg-linear-to-r from-cyan-500 to-purple-500 text-white shadow-lg transition-all duration-300 hover:-translate-y-0.5 hover:from-purple-500 hover:to-cyan-500"
                >
                    Démarrer
                </Button>

                <Button
                    variant="outlined"
                    size="large"
                    startIcon={<MenuBook />}
                    className="border-purple-300 text-purple-600 shadow-sm transition-all duration-300 hover:-translate-y-0.5 hover:bg-purple-50 dark:border-purple-700 dark:text-purple-300 dark:hover:bg-purple-900/50"
                >
                    Documentation
                </Button>
            </div>

            <ToggleMode className="fixed top-5 right-5 z-50" />
        </main>
    );
}
EOF

    cat > src/pages/NotFound.tsx <<'EOF'
import { Button } from '@mui/material';
import { Block, Home } from '@mui/icons-material';
import ArrowBackIcon from '@mui/icons-material/ArrowBack';
import { Link, useNavigate } from 'react-router-dom';
import ToggleMode from '@/components/ToggleMode';

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
                <Block fontSize="large" />
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
                    variant="contained"
                    size="large"
                    startIcon={<ArrowBackIcon />}
                    onClick={() => navigate(-1)}
                    className="bg-linear-to-r from-pink-500 to-purple-500 text-white shadow-lg transition-all duration-300 hover:-translate-y-0.5 hover:from-purple-500 hover:to-pink-500"
                >
                    Retour
                </Button>

                <Link to="/">
                    <Button
                        variant="outlined"
                        size="large"
                        startIcon={<Home />}
                        className="border-purple-300 text-purple-600 shadow-sm transition-all duration-300 hover:-translate-y-0.5 hover:bg-purple-50 dark:border-purple-700 dark:text-purple-300 dark:hover:bg-purple-900/50"
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
EOF

    cat > src/layouts/default.tsx <<'EOF'
import { Outlet } from 'react-router-dom';

export default function DefaultLayout() {
    return <Outlet />;
}
EOF

    cat > src/components/ToggleMode.tsx <<'EOF'
import { UseThemeMode } from '@/theme/ThemeContext';
import { Box, FormControl, InputLabel, MenuItem, Select } from '@mui/material';
import SunnyIcon from '@mui/icons-material/Sunny';
import BedtimeIcon from '@mui/icons-material/Bedtime';
import LaptopWindowsIcon from '@mui/icons-material/LaptopWindows';

const OPTIONS = [
    { value: 'system', label: 'System', Icon: LaptopWindowsIcon },
    { value: 'light', label: 'Light', Icon: SunnyIcon },
    { value: 'dark', label: 'Dark', Icon: BedtimeIcon },
] as const;

export default function ToggleMode({ className }: { className?: string }) {
    const { mode, setMode } = UseThemeMode();

    const current = OPTIONS.find((o) => o.value === mode) ?? OPTIONS[0];
    const CurrentIcon = current.Icon;

    return (
        <FormControl size="small" className={className} sx={{ minWidth: 130 }}>
            <InputLabel id="theme-select-label">Theme</InputLabel>
            <Select
                labelId="theme-select-label"
                label="Theme"
                value={mode}
                onChange={(e) => setMode(e.target.value as 'light' | 'dark' | 'system')}
                renderValue={() => (
                    <Box sx={{ display: 'flex', alignItems: 'center', gap: 1 }}>
                        <CurrentIcon fontSize="small" />
                        <span style={{ textTransform: 'capitalize' }}>{current.label}</span>
                    </Box>
                )}
                MenuProps={{ slotProps: { paper: { style: { borderRadius: 12, marginTop: 4 } } } }}
            >
                {OPTIONS.map(({ value, label, Icon }) => (
                    <MenuItem key={value} value={value}>
                        <Icon sx={{ mr: 1 }} fontSize="small" />
                        {label}
                    </MenuItem>
                ))}
            </Select>
        </FormControl>
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
