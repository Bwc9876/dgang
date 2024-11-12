// @ts-check
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

// https://astro.build/config
export default defineConfig({
	integrations: [
		starlight({
			title: 'Dear God, Another Nix/NixOS Guide',
			social: {
				github: 'https://github.com/Bwc9876/dgang',
			},
			sidebar: [
				{
					label: 'Chapters',
					autogenerate: { directory: "chapters" }
				},
			],
			customCss: [
				"./src/styles/theme.css"
			]
		}),
	],
});
