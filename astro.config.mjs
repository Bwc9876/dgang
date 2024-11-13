// @ts-check
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

import sitemap from '@astrojs/sitemap';

import d2 from 'astro-d2';

// https://astro.build/config
export default defineConfig({
    site: "https://dgang.bwc9876.dev",
    integrations: [starlight({
        title: 'Dear God, Another Nix/NixOS Guide',
        social: {
            github: 'https://github.com/Bwc9876/dgang',
        },
        sidebar: [
            {
                label: 'Chapters',
                autogenerate: { directory: "chapters" }
            },
            {
                label: 'Epilogue',
                autogenerate: { directory: "epilogue" }
            }
        ],
        components: {
            Head: "./src/components/Head.astro"
        },
        customCss: [
            "./src/styles/theme.css"
        ]
    }), sitemap(), d2({theme: {default: '8', dark: "200"}})],
});