import os
import subprocess

'''
note:
this is propably the worst, least secure/flexible
code I've ever written

that said i do not care beacuse it works just fine

requires texlive docker image:
https://hub.docker.com/r/texlive/texlive
'''

# chdir to src folder
os.chdir('src')

# get all folders in root filestructure
folders = next(os.walk('.'))[1]

# initialize vars
tex_command = ""
pdf_filename = ""

for folder in folders:
    
    # change directory to a selected (current) folder
    os.chdir(f'./{folder}')
    
    # find .TeX file
    tex_filename = subprocess.check_output("ls | grep *.tex", shell=True).decode("utf-8").strip()

    # compile found .TeX file
    tex_command = f'sudo docker run -i --rm --name latex -v \"$PWD\":/usr/src/app -w /usr/src/app registry.gitlab.com/islandoftex/images/texlive:latest pdflatex {tex_filename}'
    os.system(tex_command)

    # find .PDF file (if not found throw an exception or smth idk)
    pdf_filename = subprocess.check_output("ls | grep *.pdf", shell=True).decode("utf-8").strip()

    # move created PDF to pdf directory
    copy_command = os.system(f"mv -f {pdf_filename} ../../pdf/{folder}.pdf")

    # return to scr directory and clear variables for good measure
    os.chdir("..")
    tex_command = ""
    pdf_filename = ""
