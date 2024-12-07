# typst-acmart

Typst template mimicking acmart latex class

# Development

A `diff.pdf` is generated for every commit to show the differences between `sample-acmsmall.pdf` and `sample-typst-acmsmall.pdf`.

For a faster feedback loop, you may use the provided `just watch` recipe which will update `diff.pdf` whenever `sample-typst-acmsmall.typ` is changed. To acquire all the necessary dependencies, a `flake.nix` is provided. If you use `nix`, run `nix develop` to enter the `devShell` with all dependencies. Otherwise, install them manually:

- `typst`
- `diff-pdf` (https://github.com/vslavik/diff-pdf)
- `just` (https://github.com/casey/just/)
- `watchexec` (https://github.com/watchexec/watchexec)
- Libertine fonts

Once the dependencies are installed, run `just watch` and open `diff.pdf` in a PDF viewer that's able to update the view when the file changes.
