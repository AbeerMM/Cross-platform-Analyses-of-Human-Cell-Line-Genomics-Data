FROM jupyter/r-notebook:599db13f9123

MAINTAINER Reem Almugbel <reem2@uw.edu>
LABEL authors="Reem Almugbel, Abeer Almutairy"
USER root

# Customized using Jupyter Notebook R Stack https://github.com/jupyter/docker-stacks/tree/master/r-notebook


# R pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-dejavu \
    gfortran \
    gcc && apt-get clean && \
    rm -rf /var/lib/apt/lists/*
   
USER $NB_USER

# R packages

RUN conda config --add channels r
RUN conda config --add channels bioconda
RUN conda install -c conda-forge jupyter_contrib_nbextensions
RUN jupyter nbextension enable toc2/main
RUN jupyter nbextension enable collapsible_headings/main
RUN jupyter nbextension enable dragdrop/main
RUN jupyter nbextension enable highlighter/highlighter
RUN jupyter nbextension enable printview/main
RUN jupyter nbextension enable runtools/main
RUN jupyter nbextension enable codefolding/main
RUN jupyter nbextension enable comment-uncomment/main
RUN jupyter nbextension enable equation-numbering/main
RUN jupyter nbextension enable freeze/main
RUN jupyter nbextension enable toggle_all_line_numbers/main
RUN jupyter nbextension enable spellchecker/main
RUN jupyter nbextension enable codefolding/edit
RUN jupyter nbextension enable execute_time/ExecuteTime
RUN jupyter nbextension enable gist_it/main
RUN jupyter nbextension enable move_selected_cells/main
RUN jupyter nbextension enable skip-traceback/main
RUN jupyter nbextension enable highlight_selected_word/main
RUN jupyter nbextension enable search-replace/main
RUN jupyter nbextension enable snippets/main
RUN jupyter nbextension enable varInspector/main


RUN conda install --quiet --yes \
    'r-base=3.3.2' \
    'r-irkernel=0.7*' \
    'r-plyr=1.8*' \
    'r-devtools=1.12*' \
    'r-shiny=0.14*' \
    'r-rmarkdown=1.2*' \
    'r-rsqlite=1.1*' \
    'r-reshape2=1.4*' \
    'r-nycflights13=0.2*' \
    'r-caret=6.0*' \
    'r-rcurl=1.95*' \
    'r-xml=3.98_1.5' \
    'r-crayon=1.3*' && conda clean -tipsy

RUN echo "c.NotebookApp.token = u''" >> $HOME/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.iopub_data_rate_limit=1e22" >> $HOME/.jupyter/jupyter_notebook_config.py

RUN pip install --upgrade pip
RUN pip install matplotlib

RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('plotly')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('cluster')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('stringr')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('base')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('stats')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('bios2mds')" | R --vanilla

RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('build-dep')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('r-cran-rgl')" | R --vanilla

RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('rgl')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('ggdendro')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('ggplot2')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('RCurl')" | R --vanilla

RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('mclust')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('corpcor')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('bitops')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('heatmaply')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('sparcl')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('ape')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('factoextra')" | R --vanilla


WORKDIR /home/jovyan
ADD . /home/jovyan
