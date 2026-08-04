$react_vite_chakra_project_config_content = @'
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

$react_vite_chakra_project_tsconfig_app_content = @'
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

$react_vite_chakra_project_main_content = @'
import './styles/index.css';

import router from '@/routes';
import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';
import { RouterProvider } from 'react-router-dom';
import { ChakraProvider, defaultSystem } from '@chakra-ui/react';
import { ColorModeProvider } from './components/ui/color-mode';

createRoot(document.getElementById('root')!).render(
    <StrictMode>
        <ChakraProvider value={defaultSystem}>
            <ColorModeProvider>
                <RouterProvider router={router} />
            </ColorModeProvider>
        </ChakraProvider>
    </StrictMode>,
);
'@

$react_vite_chakra_project_style_content = @'
/* Global css styles */
html {
    scroll-behavior: smooth;
}
'@

$react_vite_chakra_project_route_content = @'
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

$react_vite_chakra_project_home_page_content = @'
import ToggleMode from '@/components/ToggleMode';
import { Box, Button, Flex, Icon, Text } from '@chakra-ui/react';
import { HomeIcon } from 'lucide-react';

export default function Home() {
    return (
        <Box
            position="relative"
            minHeight="100vh"
            overflow="hidden"
            display="flex"
            flexDirection="column"
            alignItems="center"
            justifyContent="center"
            paddingInline="6"
            paddingY="16"
            textAlign="center"
            transition="colors"
            bgGradient={{
                base: 'linear(to-br, slate.50, white, indigo.50)',
                _dark: 'linear(to-br, gray.950, gray.900, indigo.950)',
            }}
        >
            <Box
                position="absolute"
                top="-6rem"
                left="-6rem"
                width="18rem"
                height="18rem"
                bg="cyan.400"
                opacity="0.15"
                borderRadius="full"
                filter="blur(3rem)"
                pointerEvents="none"
            />
            <Box
                position="absolute"
                bottom="-6rem"
                right="-6rem"
                width="18rem"
                height="18rem"
                bg="purple.500"
                opacity="0.15"
                borderRadius="full"
                filter="blur(3rem)"
                pointerEvents="none"
            />

            <Flex
                alignItems="center"
                gap="2"
                mb="6"
                px="4"
                py="1.5"
                borderRadius="full"
                borderWidth="1px"
                borderColor="cyan.200"
                bg="whiteAlpha.700"
                backdropFilter="blur(8px)"
                boxShadow="sm"
                _dark={{ borderColor: 'cyan.800', bg: 'gray.800' }}
            >
                <Box width="2" height="2" borderRadius="full" bg="cyan.500" />
                <Text
                    fontSize="xs"
                    fontWeight="semibold"
                    textTransform="uppercase"
                    letterSpacing="wider"
                    color="cyan.700"
                    _dark={{ color: 'cyan.300' }}
                >
                    React 19 • Chakra UI
                </Text>
            </Flex>

            <Flex
                mb="8"
                alignItems="center"
                justifyContent="center"
                width="20"
                height="20"
                borderRadius="2xl"
                bgGradient="linear(to-br, cyan.500, purple.500)"
                boxShadow="lg"
                color="white"
            >
                <Icon>
                    <HomeIcon size={40} />
                </Icon>
            </Flex>

            <Text
                textStyle="5xl"
                fontWeight="extrabold"
                mb="5"
                maxW="2xl"
                color="gray.900"
                _dark={{ color: 'white' }}
            >
                Bienvenue sur votre projet React
            </Text>

            <Text
                fontSize={{ base: 'lg', sm: 'xl' }}
                mb="10"
                maxW="2xl"
                lineHeight="relaxed"
                color="gray.600"
                _dark={{ color: 'gray.300' }}
            >
                Ce projet est pré-configuré avec{' '}
                <Text as="span" fontWeight="semibold" color="cyan.600" _dark={{ color: 'cyan.400' }}>
                    Chakra UI
                </Text>
                ,<Text as="span" fontWeight="semibold" color="purple.600" _dark={{ color: 'purple.400' }}>
                    {' '}
                    React Router{' '}
                </Text>
                et
                <Text as="span" fontWeight="semibold" color="pink.600" _dark={{ color: 'pink.400' }}>
                    {' '}
                    Lucide Icons{' '}
                </Text>
                pour un développement rapide et élégant.
            </Text>

            <Flex direction={{ base: 'column', sm: 'row' }} gap="4" align="center" justify="center">
                <Button
                    size="lg"
                    color="white"
                    bgGradient="linear(to-r, cyan.500, purple.500)"
                    boxShadow="lg"
                    borderRadius="full"
                    _hover={{ transform: 'translateY(-2px)', boxShadow: 'xl' }}
                    transition="all 0.3s"
                    cursor="pointer"
                >
                    <HomeIcon size={20} /> Démarrer
                </Button>

                <Button
                    variant="outline"
                    size="lg"
                    color="purple.600"
                    borderColor="purple.300"
                    boxShadow="sm"
                    borderRadius="full"
                    _hover={{ bg: 'purple.50', transform: 'translateY(-2px)', boxShadow: 'md' }}
                    _dark={{ color: 'purple.300', borderColor: 'purple.700', _hover: { bg: 'purple.900' } }}
                    transition="all 0.3s"
                    cursor="pointer"
                >
                    <HomeIcon size={20} /> Documentation
                </Button>
            </Flex>

            <Box position="fixed" top={5} right={8} zIndex="50">
                <ToggleMode />
            </Box>
        </Box>
    );
}
'@

$react_vite_chakra_project_not_found_page_content = @'
import { Link, useNavigate } from 'react-router-dom';
import { Box, Button, Flex, Icon, Text } from '@chakra-ui/react';
import { ArrowLeft, BanIcon, HomeIcon } from 'lucide-react';
import ToggleMode from '@/components/ToggleMode';

export default function NotFound() {
    const navigate = useNavigate();

    return (
        <Box
            position="relative"
            minHeight="100vh"
            overflow="hidden"
            display="flex"
            flexDirection="column"
            alignItems="center"
            justifyContent="center"
            paddingInline="6"
            paddingY="16"
            textAlign="center"
            transition="colors"
            bgGradient={{
                base: 'linear(to-br, slate.50, white, indigo.50)',
                _dark: 'linear(to-br, gray.950, gray.900, indigo.950)',
            }}
        >
            <Box
                position="absolute"
                top="-6rem"
                left="-6rem"
                width="18rem"
                height="18rem"
                bg="pink.400"
                opacity="0.15"
                borderRadius="full"
                filter="blur(3rem)"
                pointerEvents="none"
            />
            <Box
                position="absolute"
                bottom="-6rem"
                right="-6rem"
                width="18rem"
                height="18rem"
                bg="purple.500"
                opacity="0.15"
                borderRadius="full"
                filter="blur(3rem)"
                pointerEvents="none"
            />

            <Flex
                alignItems="center"
                gap="2"
                mb="6"
                px="4"
                py="1.5"
                borderRadius="full"
                borderWidth="1px"
                borderColor="pink.200"
                bg="whiteAlpha.700"
                backdropFilter="blur(8px)"
                boxShadow="sm"
                _dark={{ borderColor: 'pink.800', bg: 'gray.800' }}
            >
                <Text
                    fontSize="xs"
                    fontWeight="semibold"
                    textTransform="uppercase"
                    letterSpacing="wider"
                    color="pink.600"
                    _dark={{ color: 'pink.300' }}
                >
                    Erreur 404
                </Text>
            </Flex>

            <Flex
                mb="8"
                alignItems="center"
                justifyContent="center"
                width="20"
                height="20"
                borderRadius="2xl"
                bgGradient="linear(to-br, pink.500, purple.500)"
                boxShadow="lg"
                color="white"
            >
                <Icon>
                    <BanIcon size={40} />
                </Icon>
            </Flex>

            <Text
                textStyle="5xl"
                fontWeight="extrabold"
                mb="5"
                maxW="2xl"
                color="gray.900"
                _dark={{ color: 'white' }}
            >
                Page introuvable
            </Text>

            <Text
                fontSize={{ base: 'lg', sm: 'xl' }}
                mb="10"
                maxW="2xl"
                lineHeight="relaxed"
                color="gray.600"
                _dark={{ color: 'gray.300' }}
            >
                Oups... la page que vous cherchez semble avoir disparu 🫥 <br />
                Vérifiez l'URL ou revenez à une page connue.
            </Text>

            <Flex direction={{ base: 'column', sm: 'row' }} gap="4" align="center" justify="center">
                <Button
                    size="lg"
                    color="white"
                    bgGradient="linear(to-r, pink.500, purple.500)"
                    boxShadow="lg"
                    borderRadius="full"
                    onClick={() => navigate(-1)}
                    _hover={{ transform: 'translateY(-2px)', boxShadow: 'xl' }}
                    transition="all 0.3s"
                    cursor="pointer"
                >
                    <ArrowLeft size={20} /> Retour
                </Button>

                <Link to="/">
                    <Button
                        variant="outline"
                        size="lg"
                        color="purple.600"
                        borderColor="purple.300"
                        boxShadow="sm"
                        borderRadius="full"
                        _hover={{ bg: 'purple.50', transform: 'translateY(-2px)', boxShadow: 'md' }}
                        _dark={{ color: 'purple.300', borderColor: 'purple.700', _hover: { bg: 'purple.900' } }}
                        transition="all 0.3s"
                        cursor="pointer"
                    >
                        <HomeIcon size={20} /> Accueil
                    </Button>
                </Link>
            </Flex>

            <Text mt="10" fontSize="sm" color="gray.400" _dark={{ color: 'gray.500' }}>
                Code erreur : 404 — Ressource introuvable
            </Text>

            <Box position="fixed" top={5} right={8} zIndex="50">
                <ToggleMode />
            </Box>
        </Box>
    );
}
'@

$react_vite_chakra_project_default_layout_content = @'
import { Outlet } from 'react-router-dom';

export default function DefaultLayout() {
    return <Outlet />;
}
'@

$react_vite_chakra_project_toggle_mode_content = @'
import { Flex, Select, Text } from '@chakra-ui/react';
import { useTheme } from 'next-themes';
import { Monitor, Moon, Sun } from 'lucide-react';

const OPTIONS = [
    { value: 'system', label: 'System', Icon: Monitor },
    { value: 'light', label: 'Light', Icon: Sun },
    { value: 'dark', label: 'Dark', Icon: Moon },
] as const;

export default function ToggleMode({ className }: { className?: string }) {
    const { theme, setTheme } = useTheme();

    const current = theme ?? 'system';
    const CurrentIcon = OPTIONS.find((o) => o.value === current)?.Icon ?? Monitor;

    return (
        <Select.Root
            className={className}
            size="sm"
            width="fit-content"
            value={current}
            onValueChange={(e) => setTheme(e.value)}
        >
            <Select.Trigger>
                <Flex align="center" gap="2">
                    <CurrentIcon size={18} />
                    <Select.ValueText placeholder="Theme">
                        <Text textTransform="capitalize">{current}</Text>
                    </Select.ValueText>
                </Flex>
                <Select.Indicator />
            </Select.Trigger>

            <Select.Content>
                {OPTIONS.map(({ value, label, Icon }) => (
                    <Select.Item key={value} value={value}>
                        <Flex align="center" gap="2">
                            <Icon size={18} />
                            <span>{label}</span>
                        </Flex>
                        <Select.ItemIndicator />
                    </Select.Item>
                ))}
            </Select.Content>
        </Select.Root>
    );
}
'@

<#
.SYNOPSIS
    Crée un projet Vite + React 19 + Chakra UI + TypeScript pré-configuré.

.DESCRIPTION
    Installe Chakra UI v3, React Router, Lucide Icons et next-themes, puis génère le layout,
    les pages Home/404 et le sélecteur de thème (Clair / Sombre / Système).

.PARAMETER PROJECT_NAME
    Nom du répertoire du projet à créer.

.EXAMPLE
    New-ReactViteChakraUi myapp
#>
function New-ReactViteChakraUi {
    param([string]$PROJECT_NAME)

    if (-not $PROJECT_NAME) { $PROJECT_NAME = Read-Host "Project name" }

    Write-Host "Creating project: $PROJECT_NAME (Vite + React 19 + Chakra UI + TypeScript)"
    npx create-vite@latest "$PROJECT_NAME" --template react-ts --no-immediate

    Set-Location "$PROJECT_NAME"

    Clear-Host
    Write-Host "Installing dependencies..."
    npm install react-router-dom @chakra-ui/react @emotion/react lucide-react next-themes
    npx @chakra-ui/cli snippet add color-mode

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

    Set-Content "vite.config.ts" -Value $react_vite_chakra_project_config_content -Encoding UTF8
    Set-Content "tsconfig.app.json" -Value $react_vite_chakra_project_tsconfig_app_content -Encoding UTF8
    Set-Content "src/styles/index.css" -Value $react_vite_chakra_project_style_content -Encoding UTF8
    Set-Content "src/main.tsx" -Value $react_vite_chakra_project_main_content -Encoding UTF8
    Set-Content "src/routes/index.tsx" -Value $react_vite_chakra_project_route_content -Encoding UTF8
    Set-Content "src/pages/Home.tsx" -Value $react_vite_chakra_project_home_page_content -Encoding UTF8
    Set-Content "src/pages/NotFound.tsx" -Value $react_vite_chakra_project_not_found_page_content -Encoding UTF8
    Set-Content "src/layouts/default.tsx" -Value $react_vite_chakra_project_default_layout_content -Encoding UTF8
    Set-Content "src/components/ToggleMode.tsx" -Value $react_vite_chakra_project_toggle_mode_content -Encoding UTF8

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
