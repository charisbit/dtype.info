import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import sourceMap from 'source-map';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const mapFile = path.join(__dirname, 'package', 'cli.js.map');

async function extractSources() {
  console.log('Reading source map...');
  const rawData = JSON.parse(fs.readFileSync(mapFile, 'utf8'));
  const consumer = await new sourceMap.SourceMapConsumer(rawData);
  
  const outputDir = path.join(__dirname, 'extracted-src');
  fs.mkdirSync(outputDir, { recursive: true });
  
  let count = 0;
  for (const file of consumer.sources) {
    const content = consumer.sourceContentFor(file, true);
    if (content) {
      // Paths in source map are like "../node_modules/..." so strip leading ../
      const normalizedFile = file.replace(/^\.\.\//, '');
      const filePath = path.join(outputDir, normalizedFile);
      fs.mkdirSync(path.dirname(filePath), { recursive: true });
      fs.writeFileSync(filePath, content);
      count++;
      if (count % 200 === 0) console.log(`Extracted ${count} files...`);
    }
  }
  
  console.log(`Done! Extracted ${count} files to ${outputDir}`);
  consumer.destroy();
}

extractSources().catch(console.error);
