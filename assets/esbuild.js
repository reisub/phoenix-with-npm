const esbuild = require("esbuild");

// Decide which mode to proceed with
let mode = "build";
process.argv.slice(2).forEach((arg) => {
  if (arg === "--watch") {
    mode = "watch";
  } else if (arg === "--deploy") {
    mode = "deploy";
  }
});

// Define esbuild options
let opts = {
  entryPoints: ["js/app.js"],
  bundle: true,
  logLevel: "info",
  target: "es2017",
  outdir: "../priv/static/assets",
  external: ["*.css", "fonts/*", "images/*"],
};

switch (mode) {
  case "build":
    esbuild.build(opts);
    break;

  case "deploy":
    opts = {
      minify: true,
      ...opts,
    };
    esbuild.build(opts);
    break;

  case "watch":
    opts = {
      sourcemap: "inline",
      ...opts,
    };
    esbuild
      .context(opts)
      .then((ctx) => {
        ctx.watch();
      })
      .catch((error) => {
        process.exit(1);
      });
    break;
}
