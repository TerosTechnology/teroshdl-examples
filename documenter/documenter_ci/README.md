# Documenter CI

The CLI of the terosHDL backend is used in CI to generate documentation from HDL code.
The backend is provided as a docker image in CI and the documentation is generated from HDL files.


Pull the docker:
```
docker pull terostech/colibri
```
- CLI documentation: 

[Colibri](https://github.com/TerosTechnology/colibri)

- The generated documentation is published in github pages after the build.

[Example os generated documentation](https://terostechnology.github.io/teroshdl-examples)

- Github actions CI example:

[github workflow](../../.github/workflows/doc.yml)



