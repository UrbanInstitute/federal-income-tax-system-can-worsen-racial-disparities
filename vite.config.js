import { sveltekit } from "@sveltejs/kit/vite";
import { defineConfig } from "vitest/config";
import dsv from '@rollup/plugin-dsv';
import yaml from "@rollup/plugin-yaml";

export default defineConfig({
  plugins: [sveltekit(), dsv(), yaml()],
  test: {
    include: ["src/**/*.{test,spec}.{js,ts}", "test/**/*.{test,spec}.{js,ts}"],
  },
});
