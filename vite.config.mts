/// <reference types="vitest" />
/// <reference types="vite/client" />

import { defineConfig } from 'vite';
import createReactPlugin from '@vitejs/plugin-react';
import createReScriptPlugin from 'unplugin-rescript/vite';

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [createReactPlugin(), createReScriptPlugin()],
  test: {
    include: ['tests/**/*_test.bs.js'],
    globals: true,
    environment: 'jsdom',
    setupFiles: './tests/setup.ts',
  },
});
