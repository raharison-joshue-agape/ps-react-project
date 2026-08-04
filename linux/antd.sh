#!/usr/bin/env bash
# antd.sh — Crée un projet Vite + React 19 + Ant Design + TypeScript pré-configuré.

new_react_vite_antd() {
    local PROJECT_NAME="${1:-}"

    if [ -z "$PROJECT_NAME" ]; then
        read -r -p "Project name: " PROJECT_NAME
    fi

    echo "Creating project: $PROJECT_NAME (Vite + React 19 + Ant Design + TypeScript)"
    npx create-vite@latest "$PROJECT_NAME" --template react-ts --no-immediate

    cd "$PROJECT_NAME" || return 1

    clear
    echo "Installing dependencies..."
    npm install antd @ant-design/icons react-router-dom

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
import { ThemeProviderWrapper } from '@/theme/ThemeContext';
import router from '@/routes';

createRoot(document.getElementById('root')!).render(
    <StrictMode>
        <ThemeProviderWrapper>
            <RouterProvider router={router} />
        </ThemeProviderWrapper>
    </StrictMode>,
);
EOF

    cat > src/theme/ThemeContext.tsx <<'EOF'
import { createContext, type ReactNode, useContext, useEffect, useMemo, useState } from 'react';
import { ConfigProvider, theme as antdTheme } from 'antd';

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

    const isDark = mode === 'system' ? systemDark : mode === 'dark';

    useEffect(() => {
        localStorage.setItem('theme', mode);
        document.documentElement.classList.toggle('dark', isDark);
    }, [mode, isDark]);

    const algorithm = useMemo(
        () => (isDark ? antdTheme.darkAlgorithm : antdTheme.defaultAlgorithm),
        [isDark],
    );

    return (
        <ThemeContext.Provider value={{ mode, setMode }}>
            <ConfigProvider theme={{ algorithm }}>{children}</ConfigProvider>
        </ThemeContext.Provider>
    );
}
EOF

    cat > src/styles/index.css <<'EOF'
/* Global css styles */
html,
body {
    margin: 0;
    min-height: 100%;
}
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
import { Button, Flex, Space, Typography, theme } from 'antd';
import { BookOutlined, HomeOutlined, RocketOutlined } from '@ant-design/icons';
import ToggleMode from '@/components/ToggleMode';

const { Title, Paragraph, Text } = Typography;

export default function Home() {
    const { token } = theme.useToken();

    const gradient = `linear-gradient(135deg, ${token.colorPrimaryBg}, ${token.colorBgContainer} 50%, ${token.colorInfoBg})`;

    return (
        <Flex
            vertical
            align="center"
            justify="center"
            style={{ minHeight: '100vh', padding: '0 24px', textAlign: 'center', background: gradient, transition: 'background 0.3s' }}
        >
            <Flex
                align="center"
                gap={8}
                style={{ padding: '4px 16px', borderRadius: 999, border: `1px solid ${token.colorPrimaryBorder}`, background: token.colorBgContainer, boxShadow: token.boxShadowTertiary }}
            >
                <span style={{ width: 8, height: 8, borderRadius: '50%', background: token.colorPrimary, boxShadow: `0 0 0 4px ${token.colorPrimaryBg}` }} />
                <Text strong style={{ textTransform: 'uppercase', letterSpacing: '0.05em', fontSize: 12, color: token.colorPrimary }}>
                    React 19 • Ant Design
                </Text>
            </Flex>

            <Flex
                align="center"
                justify="center"
                style={{ width: 80, height: 80, borderRadius: 20, margin: '24px 0', background: 'linear-gradient(135deg, #06b6d4, #a855f7)', color: '#fff', boxShadow: token.boxShadow, fontSize: 40 }}
            >
                <HomeOutlined />
            </Flex>

            <Title level={1} style={{ marginBottom: 16 }}>
                Bienvenue sur votre projet React
            </Title>

            <Paragraph style={{ maxWidth: 640, fontSize: 18, marginBottom: 32 }}>
                Ce projet est pré-configuré avec{' '}
                <Text strong style={{ color: token.colorPrimary }}>Ant Design</Text>,{' '}
                <Text strong style={{ color: token.colorInfo }}>React Router</Text> et{' '}
                <Text strong style={{ color: token.colorWarning }}>Ant Design Icons</Text> pour un
                développement rapide et élégant.
            </Paragraph>

            <Space size="middle">
                <Button
                    type="primary"
                    size="large"
                    icon={<RocketOutlined />}
                    style={{ background: 'linear-gradient(135deg, #06b6d4, #a855f7)', boxShadow: token.boxShadow }}
                >
                    Démarrer
                </Button>

                <Button size="large" icon={<BookOutlined />}>
                    Documentation
                </Button>
            </Space>

            <ToggleMode className="fixed top-5 right-5" />
        </Flex>
    );
}
EOF

    cat > src/pages/NotFound.tsx <<'EOF'
import { Button, Flex, Space, Typography, theme } from 'antd';
import { ArrowLeftOutlined, BlockOutlined, HomeOutlined } from '@ant-design/icons';
import { Link, useNavigate } from 'react-router-dom';
import ToggleMode from '@/components/ToggleMode';

const { Title, Paragraph, Text } = Typography;

export default function NotFound() {
    const navigate = useNavigate();
    const { token } = theme.useToken();

    const gradient = `linear-gradient(135deg, ${token.colorErrorBg}, ${token.colorBgContainer} 50%, ${token.colorInfoBg})`;

    return (
        <Flex
            vertical
            align="center"
            justify="center"
            style={{ minHeight: '100vh', padding: '0 24px', textAlign: 'center', background: gradient, transition: 'background 0.3s' }}
        >
            <Flex
                align="center"
                gap={8}
                style={{ padding: '4px 16px', borderRadius: 999, border: `1px solid ${token.colorErrorBorder}`, background: token.colorBgContainer, boxShadow: token.boxShadowTertiary }}
            >
                <Text strong style={{ textTransform: 'uppercase', letterSpacing: '0.05em', fontSize: 12, color: token.colorError }}>
                    Erreur 404
                </Text>
            </Flex>

            <Flex
                align="center"
                justify="center"
                style={{ width: 80, height: 80, borderRadius: 20, margin: '24px 0', background: 'linear-gradient(135deg, #ec4899, #a855f7)', color: '#fff', boxShadow: token.boxShadow, fontSize: 40 }}
            >
                <BlockOutlined />
            </Flex>

            <Title level={1} style={{ marginBottom: 16 }}>
                Page introuvable
            </Title>

            <Paragraph style={{ maxWidth: 640, fontSize: 18, marginBottom: 32 }}>
                Oups... la page que vous cherchez semble avoir disparu 🫥 <br />
                Vérifiez l'URL ou revenez à une page connue.
            </Paragraph>

            <Space size="middle">
                <Button
                    type="primary"
                    size="large"
                    icon={<ArrowLeftOutlined />}
                    onClick={() => navigate(-1)}
                    style={{ background: 'linear-gradient(135deg, #ec4899, #a855f7)', boxShadow: token.boxShadow }}
                >
                    Retour
                </Button>

                <Link to="/">
                    <Button size="large" icon={<HomeOutlined />}>
                        Accueil
                    </Button>
                </Link>
            </Space>

            <Text type="secondary" style={{ marginTop: 40 }}>
                Code erreur : 404 — Ressource introuvable
            </Text>
        </Flex>
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
import { Segmented } from 'antd';
import { LaptopOutlined, MoonOutlined, SunOutlined } from '@ant-design/icons';
import { UseThemeMode } from '@/theme/ThemeContext';

export default function ToggleMode({ className }: { className?: string }) {
    const { mode, setMode } = UseThemeMode();

    return (
        <div className={className}>
            <Segmented
                value={mode}
                onChange={(value) => setMode(value as 'light' | 'dark' | 'system')}
                options={[
                    { value: 'system', icon: <LaptopOutlined />, label: 'System' },
                    { value: 'light', icon: <SunOutlined />, label: 'Light' },
                    { value: 'dark', icon: <MoonOutlined />, label: 'Dark' },
                ]}
            />
        </div>
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
