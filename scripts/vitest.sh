#!/bin/bash

# installs vitest
npm install vitest --save-dev

echo "adding <"test": "vitest"> to scripts in the package.json file"

# adds <"test": "vitest"> to scripts in the package.json file
npm pkg set scripts.test=vitest

mkdir tests

# Write the test file content
cat << 'EOF' > tests/App.test.jsx
import { describe, it, expect } from "vitest";
import { render, screen } from "@testing-library/react";
import App from "../src/App";

describe("App component", () => {
  it("renders correct heading", () => {
    render(<App />);
    expect(screen.getByRole("heading").textContent).toMatch(/our first test/i);
  });
});
EOF

echo "testing for the first time..."

npm install jsdom --save-dev


# add configs to the vite.config.js
cat << 'EOF' > vite.config.js
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  test: {
    environment: 'jsdom',
  },
});
EOF

npm install @testing-library/react @testing-library/jest-dom --save-dev

# Write another test file content
cat << 'EOF' > tests/setup.js
import { expect, afterEach } from 'vitest';
import { cleanup } from '@testing-library/react';
import * as matchers from "@testing-library/jest-dom/matchers";

expect.extend(matchers);

afterEach(() => {
  cleanup();
});
EOF

# add configs to the vite.config.js
cat << 'EOF' > vite.config.js
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  test: {
    globals: true,
    environment: 'jsdom',
    setupFiles: './tests/setup.js',
  },
});
EOF

npm install @testing-library/user-event --save-dev