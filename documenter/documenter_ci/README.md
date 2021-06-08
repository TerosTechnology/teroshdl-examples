# Documenter CI

The CLI of the terosHDL backend is used in CI to generate documentation from HDL code.
The backend is provided as a docker image in CI and the documentation is generated from HDL files and a teros' project file.

Pull the docker:
```
docker pull terostech/colibri
```

The generated documentation is published in github pages after the build.

`https://terostechnology.github.io/teroshdl-examples/`

github CI example:

[github workflow](../../.github/workflows/doc.yml)



