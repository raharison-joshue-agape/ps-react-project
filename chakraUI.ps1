$react_vite_chakra_project_config_content = @'
import { defineConfig } from 'vite';
import path from 'path';
import react from '@vitejs/plugin-react';

// https://vite.dev/config/
export default defineConfig({
    server: {
        port: 5173,
        host: '::',
    },
    plugins: [react()],
    resolve: {
        tsconfigPaths: true,
        alias: {
            '@': path.resolve(__dirname, 'src'),
        },
    },
});
'@

$react_vite_chakra_project_tsconfig_app_content = @'
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
import { HomeIcon } from 'lucide-react';
import { Box, Button, Flex, Icon, Text } from '@chakra-ui/react';
import { ColorModeButton } from '@/components/ui/color-mode';

export default function Home() {
    return (
        <Box
            minHeight="100vh"
            border={1}
            borderColor="red.500"
            display="flex"
            flexDirection="column"
            alignItems="center"
            justifyContent="center"
            paddingInline="6"
            textAlign="center"
            transition="colors"
            bgGradient={{
                base: 'linear(to-br, cyan.50, purple.50, pink.50)',
                _dark: 'linear(to-br, gray.900, gray.800, gray.900)',
            }}
        >
            <Icon
                color={{ base: 'teal.600', _dark: 'teal.400' }}
                animation="bounce"
                marginBottom="6"
            >
                <HomeIcon size={50} />
            </Icon>

            <Text
                textStyle="6xl"
                color={{ base: 'gray.900', _dark: 'white' }}
                fontWeight="bold"
                mb="10"
            >
                Bienvenue sur votre projet React
            </Text>

            <Text
                fontSize={{ base: 'lg', sm: 'xl', md: '2xl' }}
                color={{ base: 'gray.600', _dark: 'gray.300' }}
                maxW="2xl"
                mb="10"
                lineHeight="relaxed"
                fontWeight={500}
            >
                Ce projet est pré-configuré avec{' '}
                <Text
                    as="span"
                    fontWeight="semibold"
                    color={{ base: 'teal.600', _dark: 'teal.400' }}
                >
                    {' '}
                    Chakra UI{' '}
                </Text>
                et
                <Text
                    as="span"
                    fontWeight="semibold"
                    color={{ base: 'pink.600', _dark: 'pink.400' }}
                >
                    {' '}
                    Lucide Icons{' '}
                </Text>
                pour un développement rapide et élégant.
            </Text>

            <Flex direction={{ base: 'column', sm: 'row' }} gap="6" justify="center">
                <Button
                    size="lg"
                    boxShadow="lg"
                    transition="all 0.3s"
                    cursor="pointer"
                    borderRadius="full"
                    bg={{ base: 'teal.600', _dark: 'teal.400' }}
                >
                    <HomeIcon size={28} />
                    Démarrer
                </Button>

                <Button
                    variant="outline"
                    size="lg"
                    transition="all 0.3s"
                    cursor="pointer"
                    borderRadius="full"
                >
                    Documentation
                </Button>
            </Flex>

            <ColorModeButton position="fixed" top={5} right={8} />
        </Box>
    );
}
'@

$react_vite_chakra_project_not_found_page_content = @'
import { Link, useNavigate } from 'react-router-dom';
import { Box, Button, Flex, Heading, Icon, Text } from '@chakra-ui/react';
import { ArrowLeft, BanIcon, HomeIcon } from 'lucide-react';

export default function NotFound() {
    const navigate = useNavigate();

    return (
        <Box
            minHeight="100vh"
            display="flex"
            flexDir="column"
            alignItems="center"
            justifyContent="center"
            paddingInline="6"
            textAlign="center"
            transition="colors"
            bgGradient={{
                base: 'linear(to-br, cyan.50, purple.50, pink.50)',
                _dark: 'linear(to-br, gray.900, gray.800, gray.900)',
            }}
        >
            <Icon
                color={{ base: 'pink.600', _dark: 'pink.400' }}
                animation="pulse"
                marginBottom="6"
            >
                <BanIcon size={50} />
            </Icon>

            <Text
                fontSize="sm"
                fontWeight="semibold"
                px="4"
                py="1"
                borderRadius="full"
                bg={{ base: 'pink.100', _dark: 'pink.300' }}
                color={{ base: 'pink.600', _dark: 'pink.900' }}
                mb="4"
                boxShadow="sm"
            >
                Erreur 404
            </Text>

            <Heading
                as="h1"
                fontSize={{ base: '3xl', sm: '4xl', md: '5xl' }}
                fontWeight="extrabold"
                color={{ base: 'gray.900', _dark: 'white' }}
                mb="6"
                textShadow="lg"
            >
                Page introuvable
            </Heading>

            <Text
                fontSize={{ base: 'lg', sm: 'xl' }}
                color={{ base: 'gray.600', _dark: 'gray.300' }}
                maxW="2xl"
                mb="10"
                lineHeight="relaxed"
            >
                Oups... la page que vous cherchez semble avoir disparu 🫥 <br />
                Vérifiez l’URL ou revenez à une page connue.
            </Text>

            <Flex direction={{ base: 'column', sm: 'row' }} gap="6" justify="center">
                <Button
                    size="lg"
                    onClick={() => navigate(-1)}
                    boxShadow="lg"
                    transition="all 0.3s"
                    bg={{ base: 'teal.600', _dark: 'teal.400' }}
                    borderRadius="full"
                    _hover={{
                        transform: 'translateY(-4px)',
                    }}
                    cursor="pointer"
                >
                    <ArrowLeft />
                    Retour
                </Button>

                <Link to="/">
                    <Button
                        variant="outline"
                        size="lg"
                        color={{ base: 'purple.600', _dark: 'purple.300' }}
                        borderColor={{ base: 'purple.700', _dark: 'purple.300' }}
                        boxShadow="md"
                        transition="all 0.3s"
                        _hover={{
                            bg: { base: 'purple.50', _dark: 'purple.800' },
                            color: { base: 'purple.600', _dark: 'purple.400' },
                            transform: 'translateY(-4px)',
                        }}
                        borderRadius="full"
                        cursor="pointer"
                    >
                        <HomeIcon />
                        Accueil
                    </Button>
                </Link>
            </Flex>

            <Text mt="10" fontSize="sm" color={{ base: 'gray.400', _dark: 'gray.500' }}>
                Code erreur : 404 — Ressource introuvable
            </Text>
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

function New-ReactViteChakraUi {
    param([string]$PROJECT_NAME)

    if (-not $PROJECT_NAME) { $PROJECT_NAME = Read-Host "Project name" }

    Write-Host "Creating project: $PROJECT_NAME (Vite + React 18 + Chakra UI + TypeScript)"
    Write-Output n | npx create-vite@latest "$PROJECT_NAME" --template react-ts

    Set-Location "$PROJECT_NAME"

    Clear-Host
    Write-Host "Installing dependencies..."
    npm install react-router-dom @chakra-ui/react @emotion/react lucide-react@next
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