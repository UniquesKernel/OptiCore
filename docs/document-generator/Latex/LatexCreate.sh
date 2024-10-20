#!/bin/bash

folder=$1
project_name=$2
currentFolder="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mkdir ${folder}
mkdir ${folder}/00-DocumentSettings
mkdir ${folder}/01-FrontMatter
mkdir ${folder}/02-Body
mkdir ${folder}/03-EndMatter

cp ${currentFolder}/snippet/tikz-uml.sty ./${folder}
cp ${currentFolder}/snippet/Latex.tex ./${folder}/${project_name}.tex
cp ${currentFolder}/snippet/Preamble.tex ./${folder}/00-DocumentSettings/Preamble.tex
cp ${currentFolder}/snippet/PreTitle.tex ./${folder}/00-DocumentSettings/PreTitle.tex
cp ${currentFolder}/snippet/Definitions.tex ./${folder}/00-DocumentSettings/Definitions.tex

cp ${currentFolder}/snippet/Abstract.tex ./${folder}/01-FrontMatter/Abstract.tex
cp ${currentFolder}/snippet/Title.tex ./${folder}/01-FrontMatter/Title.tex
cp ${currentFolder}/snippet/TOC.tex ./${folder}/01-FrontMatter/TOC.tex
cp ${currentFolder}/snippet/FrontMatter.tex ./${folder}/01-FrontMatter/FrontMatter.tex

cp ${currentFolder}/snippet/Body.tex ./${folder}/02-Body/Body.tex
cp ${currentFolder}/snippet/Introduction.tex ./${folder}/02-Body/Introduction.tex

cp ${currentFolder}/snippet/EndMatter.tex ./${folder}/03-EndMatter/EndMatter.tex
cp ${currentFolder}/snippet/References.tex ./${folder}/03-EndMatter/References.tex
cp ${currentFolder}/snippet/References.bib ./${folder}/03-EndMatter/References.bib

