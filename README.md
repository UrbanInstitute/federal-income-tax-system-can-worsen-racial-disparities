# How the Federal Income Tax System Can Worsen Racial Disparities

Svelte project code for a Tax Policy Center [scrolly-telling explainer](https://apps.urban.org/features/federal-income-tax-system-can-worsen-racial-disparities).

## Project credits

Research: Aravind Boddupalli, Elaine Maag

Writing: Dana Ferrante

Editing: Alex Dallman

Design: Christina Baird

Data Visualization and Development: Mitchell Thorson

## Public URL

Production: https://apps.urban.org/features/federal-income-tax-system-can-worsen-racial-disparities

## Development requirements


## Data notes

Source data files for the charts included in this project are in the `data/source` folder. There is a simple transformation script that formats some of this data for the front end in `data/scripts/convert_data.R`.

## Developing

To run this project locally you'll need the following installed on your local computer:

- [Node.js](https://nodejs.org/en/) >= 18.0.0
- [NPM](https://docs.npmjs.com/cli/v9/commands/npm)

Once you have Node and NPM setup, open up the project directory in a terminal and install the project dependencies by running:

```bash
npm install
```

You should now be ready to start developing! Start a local server with:

```bash
npm run dev
```

Open your browser and visit [http://localhost:5173](http://localhost:5173) to see your project running.

## Building for production

If you need to preview a production build locally, you can build your project with:

```bash
npm run build
```

This will generate a production-ready build of your project in the `dist` directory.

You can view the build you just created by running:

```bash
npm run preview
```

and opening your browser to: [http://localhost:4173](http://localhost:4173)

