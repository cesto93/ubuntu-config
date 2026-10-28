#!/usr/bin/env bun

import { render } from 'pele';
import fs from 'fs';
import { Command } from 'commander';
import path from 'path';

const program = new Command();

program
.name('pele-cli')
.description('CLI per fare diagrammi mermaid usando pele')
.version('1.0.0')
// Opzioni/Flag
  .requiredOption('-i, --input <path>', 'Percorso del file di input (.txt, .mmd, ecc.)')
  .option('-o, --output <path>', 'Percorso del file .svg di output (opzionale)')
  .action((options) => {
    const inputPath = path.resolve(options.input);

    // Se l'output non viene specificato, usa lo stesso nome dell'input cambiando l'estensione in .svg
    const outputPath = options.output
      ? path.resolve(options.output)
      : inputPath.replace(/\.[^/.]+$/, '') + '.svg';

    // 1. Verifico l'esistenza del file di input
    if (!fs.existsSync(inputPath)) {
      console.error(`❌ Errore: Il file di input "${inputPath}" non esiste.`);
      process.exit(1);
    }

    try {
      // 2. Lettura del file di input
      const mermaidText = fs.readFileSync(inputPath, 'utf-8');

      // 3. Rendering SVG tramite Pele
      const { svg } = render(mermaidText);

      // 4. Scrittura del file SVG
      fs.writeFileSync(outputPath, svg);

      console.log(`File SVG generato con successo: ${outputPath}`);
    } catch (error) {
      console.error(`Errore durante la generazione dell'SVG:`, error.message);
      process.exit(1);
    }
  });

program.parse(process.argv);
