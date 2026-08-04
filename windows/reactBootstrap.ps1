$react_vite_bootstrap_project_config_content = @'
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

$react_vite_bootstrap_project_tsconfig_app_content = @'
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

$react_vite_bootstrap_project_style_content = @'
/* Global style */
html {
    scroll-behavior: smooth;
}
'@

$react_vite_bootstrap_project_main_content = @'
import 'bootstrap';
import '@/styles/index.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap-icons/font/bootstrap-icons.css';

import router from '@/routes';
import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';
import { RouterProvider } from 'react-router-dom';
import { ThemeProvider } from './theme/ThemeContext';

createRoot(document.getElementById('root')!).render(
    <StrictMode>
        <ThemeProvider>
            <RouterProvider router={router} />
        </ThemeProvider>
    </StrictMode>,
);
'@

$react_vite_bootstrap_project_theme_content = @'
import { createContext, type ReactNode, useContext, useEffect, useState, useCallback } from 'react';

export type Theme = 'light' | 'dark' | 'system';

interface ThemeContextType {
    theme: Theme;
    setTheme: (theme: Theme) => void;
}

const ThemeContext = createContext<ThemeContextType | undefined>(undefined);

export const ThemeProvider = ({ children }: { children: ReactNode }) => {
    const [theme, setTheme] = useState<Theme>(() => {
        return (localStorage.getItem('theme') as Theme) || 'system';
    });

    const getSystemTheme = (): 'light' | 'dark' => {
        return window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
    };

    const applyTheme = useCallback((mode: Theme) => {
        const root = document.documentElement;

        if (mode === 'system') {
            root.setAttribute('data-bs-theme', getSystemTheme());
        } else {
            root.setAttribute('data-bs-theme', mode);
        }
    }, []);

    useEffect(() => {
        localStorage.setItem('theme', theme);
        applyTheme(theme);
    }, [theme, applyTheme]);

    useEffect(() => {
        const media = window.matchMedia('(prefers-color-scheme: dark)');

        const listener = () => {
            if (theme === 'system') {
                applyTheme('system');
            }
        };

        media.addEventListener('change', listener);
        return () => media.removeEventListener('change', listener);
    }, [theme, applyTheme]);

    return <ThemeContext.Provider value={{ theme, setTheme }}>{children}</ThemeContext.Provider>;
};

export const UseTheme = (): ThemeContextType => {
    const context = useContext(ThemeContext);
    if (!context) {
        throw new Error('useTheme must be used within ThemeProvider');
    }
    return context;
};
'@

$react_vite_bootstrap_project_route_content = @'
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

$react_vite_bootstrap_project_home_page_content = @'
import ToggleMode from '@/components/ToggleMode';
import { Button } from 'react-bootstrap';

export default function Home() {
    return (
        <main className="vh-100 d-flex flex-column justify-content-center align-items-center text-center bg-body px-3">
            <span className="badge rounded-pill text-bg-light border border-info-subtle text-info-emphasis mb-4 px-3 py-2 fw-semibold text-uppercase shadow-sm d-inline-flex align-items-center gap-2">
                <span className="spinner-grow spinner-grow-sm" style={{ width: '0.5rem', height: '0.5rem' }} />
                React 19 • React Bootstrap
            </span>

            <span
                className="mb-4 d-inline-flex align-items-center justify-content-center text-white shadow-lg"
                style={{ width: 80, height: 80, borderRadius: 20, background: 'linear-gradient(135deg, #06b6d4, #a855f7)' }}
            >
                <i className="bi bi-house" style={{ fontSize: '2.2rem' }} />
            </span>

            <h1 className="display-5 fw-bold text-body mb-4">Bienvenue sur votre projet React</h1>

            <p className="lead text-body-secondary col-lg-6 mb-5">
                Ce projet est pré-configuré avec{' '}
                <span className="fw-semibold text-info">React Bootstrap</span>,{' '}
                <span className="fw-semibold text-primary">Bootstrap 5</span> et{' '}
                <span className="fw-semibold text-danger">Bootstrap Icons </span>
                pour un développement rapide et élégant.
            </p>

            <div className="d-flex flex-column flex-sm-row gap-3 justify-content-center">
                <Button
                    variant="primary"
                    size="lg"
                    className="border-0 shadow"
                    style={{ background: 'linear-gradient(135deg, #06b6d4, #a855f7)' }}
                >
                    <i className="bi bi-rocket-takeoff me-2" />
                    Démarrer
                </Button>

                <Button
                    variant="outline-primary"
                    size="lg"
                    className="shadow-sm"
                    style={{ borderColor: 'rgba(168,85,247,0.4)', color: '#7e22ce' }}
                >
                    <i className="bi bi-book me-2" />
                    Documentation
                </Button>
            </div>

            <ToggleMode className="position-fixed top-0 end-0 m-3" />
        </main>
    );
}
'@

$react_vite_bootstrap_project_not_found_page_content = @'
import { Link, useNavigate } from 'react-router-dom';
import { Button } from 'react-bootstrap';
import ToggleMode from '@/components/ToggleMode';

export default function NotFound() {
    const navigate = useNavigate();

    return (
        <main className="vh-100 d-flex flex-column justify-content-center align-items-center text-center bg-body px-3">
            <span className="badge rounded-pill text-bg-light border border-danger-subtle text-danger-emphasis mb-4 px-3 py-2 fw-semibold text-uppercase shadow-sm">
                Erreur 404
            </span>

            <span
                className="mb-4 d-inline-flex align-items-center justify-content-center text-white shadow-lg"
                style={{ width: 80, height: 80, borderRadius: 20, background: 'linear-gradient(135deg, #ec4899, #a855f7)' }}
            >
                <i className="bi bi-ban" style={{ fontSize: '2.2rem' }} />
            </span>

            <h1 className="display-5 fw-bold text-body mb-4">Page introuvable</h1>

            <p className="lead text-body-secondary col-lg-6 mb-5">
                Oups... la page que vous cherchez semble avoir disparu 🫥 <br />
                Vérifiez l'URL ou revenez à une page connue.
            </p>

            <div className="d-flex flex-column flex-sm-row gap-3 justify-content-center">
                <Button variant="secondary" size="lg" onClick={() => navigate(-1)} className="shadow">
                    <i className="bi bi-arrow-left me-2" />
                    Retour
                </Button>

                <Link to="/" className="text-decoration-none">
                    <Button
                        variant="outline-primary"
                        size="lg"
                        className="shadow-sm"
                        style={{ borderColor: 'rgba(168,85,247,0.4)', color: '#7e22ce' }}
                    >
                        <i className="bi bi-house me-2" />
                        Accueil
                    </Button>
                </Link>
            </div>

            <p className="mt-5 text-body-secondary small">
                Code erreur : 404 — Ressource introuvable
            </p>
        </main>
    );
}
'@

$react_vite_bootstrap_project_default_layout_content = @'
import { Outlet } from 'react-router-dom';

export default function DefaultLayout() {
    return <Outlet />;
}
'@

$react_vite_bootstrap_project_toogle_mode_content = @'
import { Button, ButtonGroup } from 'react-bootstrap';
import { UseTheme, type Theme } from '../theme/ThemeContext';

const OPTIONS: { value: Theme; label: string; icon: string }[] = [
    { value: 'light', label: 'Clair', icon: 'bi-brightness-high-fill' },
    { value: 'dark', label: 'Sombre', icon: 'bi-moon-fill' },
    { value: 'system', label: 'Système', icon: 'bi-laptop' },
];

export default function ToggleMode({ className }: { className?: string }) {
    const { theme, setTheme } = UseTheme();

    return (
        <div className={className}>
            <ButtonGroup aria-label="Changer de thème" className="shadow-sm">
                {OPTIONS.map(({ value, label, icon }) => (
                    <Button
                        key={value}
                        variant={theme === value ? 'primary' : 'outline-primary'}
                        size="sm"
                        onClick={() => setTheme(value)}
                        title={label}
                        aria-label={label}
                    >
                        <i className={`bi ${icon}`} />
                    </Button>
                ))}
            </ButtonGroup>
        </div>
    );
}
'@

<#
.SYNOPSIS
    Crée un projet Vite + React 19 + React Bootstrap + TypeScript pré-configuré.

.DESCRIPTION
    Installe React Bootstrap, Bootstrap 5 et Bootstrap Icons, puis génère le layout,
    les pages Home/404 et le sélecteur de thème (Clair / Sombre / Système).

.PARAMETER PROJECT_NAME
    Nom du répertoire du projet à créer.

.EXAMPLE
    New-ReactViteBootstrap myapp
#>
function New-ReactViteBootstrap {
    param([string]$PROJECT_NAME)

    if (-not $PROJECT_NAME) { $PROJECT_NAME = Read-Host "Project name" }

    Write-Host "Creating project: $PROJECT_NAME (Vite + React 19 + React Bootstrap + TypeScript)"
    npx create-vite@latest "$PROJECT_NAME" --template react-ts --no-immediate

    Set-Location "$PROJECT_NAME"

    Clear-Host
    Write-Host "Installing dependencies..."
    npm install react-bootstrap bootstrap bootstrap-icons react-router-dom

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

    Set-Content "vite.config.ts" -Value $react_vite_bootstrap_project_config_content -Encoding UTF8
    Set-Content "tsconfig.app.json" -Value $react_vite_bootstrap_project_tsconfig_app_content -Encoding UTF8
    Set-Content "src/styles/index.css" -Value $react_vite_bootstrap_project_style_content -Encoding UTF8
    Set-Content "src/main.tsx" -Value $react_vite_bootstrap_project_main_content -Encoding UTF8
    Set-Content "src/theme/ThemeContext.tsx" -Value $react_vite_bootstrap_project_theme_content -Encoding UTF8
    Set-Content "src/routes/index.tsx" -Value $react_vite_bootstrap_project_route_content -Encoding UTF8
    Set-Content "src/pages/Home.tsx" -Value $react_vite_bootstrap_project_home_page_content -Encoding UTF8
    Set-Content "src/pages/NotFound.tsx" -Value $react_vite_bootstrap_project_not_found_page_content -Encoding UTF8
    Set-Content "src/layouts/default.tsx" -Value $react_vite_bootstrap_project_default_layout_content -Encoding UTF8
    Set-Content "src/components/ToggleMode.tsx" -Value $react_vite_bootstrap_project_toogle_mode_content -Encoding UTF8

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
