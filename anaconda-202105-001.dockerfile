FROM anaconda-202105-000:v1

RUN conda update -n base -c defaults conda \
    && conda install -y -c conda-forge pymysql sqlalchemy plotly dynaconf lightgbm
