# LaTeX batch compile and merge

A collection of _really bad_ Python and Bash scripts, used for batch compilation
and merging of multiple LaTeX projects into one .PDF file.

## Project folder structure
Place your project in directories in `src/` folder with the following names:

`number_name`

or

`number`

example source folder file structure:

```
src/
├── 0_first-project
├── 1_second-project
├── 2
├── 3_fourth-project
└── README
```

The number before name indicates the place of the project in the merged PDF.

## Usage (automatic)

After importing projets, run `make.sh` (`make.sh -v` for verbose output).

## Usage (manual)

After importing projects, run `compile_all_docker.py` script.

```bash
# python compile_all_docker.py
```

You will be asked for a sudo password (required for docker to run texlive form image). After confirming the password the docker will run
and compile every project in source directory, showing pdflatex logs in the background. 

The compilation _shloud_ finish on it's own (the docker images has a full texlive installation), if not, you're on your own.

After verifying proper compilation of projects by checking `pdf/` folder, you can run python merging script:

```bash
$ python merge_all.py
```

Which will merge all pdfs in `pdf/` directory, according to filename sorted by "human readable order", as in:

```
0
1
2
...
10
11
12
...
100
101
102
...
```

The combined PDF will propably be large in size (uncompressed photos etc.). This can be fixed using third and final script:
```bash
$ ./compress.sh
```

Witch will output out_compressed.pdf. That is our final file :)

### Troubleshooting / known issues
- `Command 'ls | grep *.tex' returned non-zero exit status 1.` 

Most likely you have an empty project folder inside src/ directory.

### Important!

Right now the codebase is probably the worst code I've ever written. It't not tested in any way, python scripts run bash commands wihout
any sanitization (as if even using os.system was a good idea in the first place). And it's generally a good display of bad practices.

BUT it works for me, so i don't really care that much, will fix all bugs in the future release ;) 

### Requirements

| Name                                 | Link                                     |
| ---                                  | ---                                      |
| Linux shell with root acces          |                                          |
| Docker                               | https://www.docker.com/                  |
| TeX Live docker image                | https://hub.docker.com/r/texlive/texlive |
| Python 3                             | https://www.python.org/downloads/        |
| pdfunite (merging files)             | https://github.com/mtgrosser/pdfunite    |
| Ghostscript (compressing files)      | https://www.ghostscript.com/             |

The TeX Live docker image shloud download automatically with first `compile_all_docker.py` run.

