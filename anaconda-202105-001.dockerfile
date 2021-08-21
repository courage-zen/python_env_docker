FROM anaconda-202105-000:v1

RUN conda install -y -c conda-forge pymysql sqlalchemy plotly dynaconf
