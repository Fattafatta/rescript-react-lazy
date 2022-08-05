/// <reference types="vite/client" />

import { defineConfig } from 'vite';
import reactRefresh from '@vitejs/plugin-react-refresh';
import createReScriptPlugin from '@jihchi/vite-plugin-rescript';

export default defineConfig({
  plugins: [reactRefresh(), createReScriptPlugin()],
});
