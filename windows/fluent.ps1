$react_vite_fluent_project_config_content = @'
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
$react_vite_fluent_project_tsconfig_app_content = @'
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
$react_vite_fluent_project_main_content = @'
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
$react_vite_fluent_project_theme_content = @'
import { createContext, type ReactNode, useContext, useEffect, useState } from 'react';
import {
    FluentProvider,
    webDarkTheme,
    webLightTheme,
    type Theme,
} from '@fluentui/react-components';

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

    const fluentTheme: Theme = resolved === 'dark' ? webDarkTheme : webLightTheme;

    return (
        <ThemeContext.Provider value={{ mode, setMode }}>
            <FluentProvider theme={fluentTheme}>{children}</FluentProvider>
        </ThemeContext.Provider>
    );
}
'@
$react_vite_fluent_project_style_content = @'
* {
    box-sizing: border-box;
}

html,
body,
#root {
    margin: 0;
    height: 100%;
}

body {
    font-family:
        'Segoe UI',
        'Segoe UI Variable',
        -apple-system,
        BlinkMacSystemFont,
        'Helvetica Neue',
        sans-serif;
}
'@
$react_vite_fluent_project_route_content = @'
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
$react_vite_fluent_project_home_page_content = @'
import { Badge, Button, Text, Title1, makeStyles } from '@fluentui/react-components';
import { BookOpen24Regular, Home24Regular, Rocket24Regular } from '@fluentui/react-icons';
import ToggleMode from '@/components/ToggleMode';

const useStyles = makeStyles({
    main: {
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        justifyContent: 'center',
        minHeight: '100vh',
        textAlign: 'center',
        gap: '20px',
        padding: '64px 24px',
        backgroundImage: 'linear-gradient(135deg, rgba(6, 182, 212, 0.08), rgba(139, 92, 246, 0.08))',
    },
    heroIcon: {
        width: '80px',
        height: '80px',
        borderRadius: '20px',
        display: 'inline-flex',
        alignItems: 'center',
        justifyContent: 'center',
        backgroundImage: 'linear-gradient(135deg, #06b6d4, #8b5cf6)',
        color: '#fff',
        boxShadow: '0 12px 32px rgba(6, 182, 212, 0.25)',
    },
    buttons: {
        display: 'flex',
        gap: '12px',
        flexWrap: 'wrap',
        justifyContent: 'center',
    },
});

export default function Home() {
    const styles = useStyles();

    return (
        <main className={styles.main}>
            <Badge appearance="filled" color="brand" shape="rounded">
                React 19 • Fluent UI
            </Badge>

            <span className={styles.heroIcon}>
                <Home24Regular fontSize={40} />
            </span>

            <Title1 as="h1">Bienvenue sur votre projet React</Title1>

            <Text size={400} style={{ maxWidth: 640 }}>
                Ce projet est pré-configuré avec <strong>Fluent UI</strong>,{' '}
                <strong>Fluent Icons</strong> et <strong>React Router</strong> pour un
                développement rapide et élégant.
            </Text>

            <div className={styles.buttons}>
                <Button appearance="primary" size="large" icon={<Rocket24Regular />}>
                    Démarrer
                </Button>
                <Button appearance="secondary" size="large" icon={<BookOpen24Regular />}>
                    Documentation
                </Button>
            </div>

            <ToggleMode className="fixed top-5 right-5 z-50" />
        </main>
    );
}
'@
$react_vite_fluent_project_not_found_page_content = @'
import { Badge, Button, Text, Title1, makeStyles } from '@fluentui/react-components';
import { ArrowLeft24Regular, ErrorCircle24Regular, Home24Regular } from '@fluentui/react-icons';
import { Link, useNavigate } from 'react-router-dom';
import ToggleMode from '@/components/ToggleMode';

const useStyles = makeStyles({
    main: {
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        justifyContent: 'center',
        minHeight: '100vh',
        textAlign: 'center',
        gap: '20px',
        padding: '64px 24px',
        backgroundImage: 'linear-gradient(135deg, rgba(244, 114, 182, 0.08), rgba(139, 92, 246, 0.08))',
    },
    heroIcon: {
        width: '80px',
        height: '80px',
        borderRadius: '20px',
        display: 'inline-flex',
        alignItems: 'center',
        justifyContent: 'center',
        backgroundImage: 'linear-gradient(135deg, #ec4899, #8b5cf6)',
        color: '#fff',
        boxShadow: '0 12px 32px rgba(236, 72, 153, 0.25)',
    },
    buttons: {
        display: 'flex',
        gap: '12px',
        flexWrap: 'wrap',
        justifyContent: 'center',
    },
});

export default function NotFound() {
    const styles = useStyles();
    const navigate = useNavigate();

    return (
        <main className={styles.main}>
            <Badge appearance="filled" color="danger" shape="rounded">
                Erreur 404
            </Badge>

            <span className={styles.heroIcon}>
                <ErrorCircle24Regular fontSize={40} />
            </span>

            <Title1 as="h1">Page introuvable</Title1>

            <Text size={400} style={{ maxWidth: 640 }}>
                Oups... la page que vous cherchez semble avoir disparu 🫥 <br />
                Vérifiez l'URL ou revenez à une page connue.
            </Text>

            <div className={styles.buttons}>
                <Button
                    appearance="primary"
                    size="large"
                    icon={<ArrowLeft24Regular />}
                    onClick={() => navigate(-1)}
                >
                    Retour
                </Button>
                <Link to="/">
                    <Button appearance="secondary" size="large" icon={<Home24Regular />}>
                        Accueil
                    </Button>
                </Link>
            </div>

            <Text size={200} style={{ marginTop: 8 }}>
                Code erreur : 404 — Ressource introuvable
            </Text>

            <ToggleMode className="fixed top-5 right-5 z-50" />
        </main>
    );
}
'@
$react_vite_fluent_project_default_layout_content = @'
import { Outlet } from 'react-router-dom';

export default function DefaultLayout() {
    return <Outlet />;
}
'@
$react_vite_fluent_project_toggle_mode_content = @'
import { Select, makeStyles } from '@fluentui/react-components';
import { Desktop24Regular, WeatherMoon24Regular, WeatherSunny24Regular } from '@fluentui/react-icons';
import { UseThemeMode, type ThemeMode } from '@/theme/ThemeContext';

const OPTIONS: { value: ThemeMode; label: string; Icon: typeof WeatherSunny24Regular }[] = [
    { value: 'light', label: 'Light', Icon: WeatherSunny24Regular },
    { value: 'dark', label: 'Dark', Icon: WeatherMoon24Regular },
    { value: 'system', label: 'System', Icon: Desktop24Regular },
];

const useStyles = makeStyles({
    select: {
        minWidth: '150px',
    },
});

export default function ToggleMode({ className }: { className?: string }) {
    const { mode, setMode } = UseThemeMode();
    const styles = useStyles();

    return (
        <div className={className}>
            <Select
                className={styles.select}
                value={mode}
                onChange={(_e, data) => setMode(data.value as ThemeMode)}
            >
                {OPTIONS.map(({ value, label }) => (
                    <option key={value} value={value}>
                        {label}
                    </option>
                ))}
            </Select>
        </div>
    );
}
'@

<#
.SYNOPSIS
    Crée un projet Vite + React 19 + Fluent UI + TypeScript pré-configuré.

.DESCRIPTION
    Installe Fluent UI (Microsoft) et Fluent Icons, puis génère le layout, les pages Home/404 et le sélecteur de thème (Clair / Sombre / Système via FluentProvider et webDarkTheme).

.PARAMETER PROJECT_NAME
    Nom du répertoire du projet à créer.

.EXAMPLE
    New-ReactViteFluent myapp
#>
function New-ReactViteFluent {
    param([string]$PROJECT_NAME)

    if (-not $PROJECT_NAME) { $PROJECT_NAME = Read-Host "Project name" }

    Write-Host "Creating project: $PROJECT_NAME (Vite + React 19 + Fluent UI + TypeScript)"
    npx create-vite@latest "$PROJECT_NAME" --template react-ts --no-immediate

    Set-Location "$PROJECT_NAME"

    Clear-Host
    Write-Host "Installing dependencies..."
    npm install @fluentui/react-components @fluentui/react-icons react-router-dom

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

    Set-Content "vite.config.ts" -Value $react_vite_fluent_project_config_content -Encoding UTF8
    Set-Content "tsconfig.app.json" -Value $react_vite_fluent_project_tsconfig_app_content -Encoding UTF8
    Set-Content "src/main.tsx" -Value $react_vite_fluent_project_main_content -Encoding UTF8
    Set-Content "src/theme/ThemeContext.tsx" -Value $react_vite_fluent_project_theme_content -Encoding UTF8
    Set-Content "src/styles/index.css" -Value $react_vite_fluent_project_style_content -Encoding UTF8
    Set-Content "src/routes/index.tsx" -Value $react_vite_fluent_project_route_content -Encoding UTF8
    Set-Content "src/pages/Home.tsx" -Value $react_vite_fluent_project_home_page_content -Encoding UTF8
    Set-Content "src/pages/NotFound.tsx" -Value $react_vite_fluent_project_not_found_page_content -Encoding UTF8
    Set-Content "src/layouts/default.tsx" -Value $react_vite_fluent_project_default_layout_content -Encoding UTF8
    Set-Content "src/components/ToggleMode.tsx" -Value $react_vite_fluent_project_toggle_mode_content -Encoding UTF8

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