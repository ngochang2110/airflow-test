
FROM apache/airflow:latest-python3.8

USER root

ENV AIRFLOW_HOME=/opt/airflow

# Copy your project files
COPY . ${AIRFLOW_HOME}

# Change ownership to the airflow user
RUN chown -R airflow: ${AIRFLOW_HOME}

USER airflow

# Install any required Python packages
RUN pip install --upgrade pip
RUN if [ -s ${AIRFLOW_HOME}/requirements.txt ]; then pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org -r ${AIRFLOW_HOME}/requirements.txt; fi

# Set PYTHONPATH to include the dags directory
ENV PYTHONPATH="${PYTHONPATH}:${AIRFLOW_HOME}/dags"

USER ${AIRFLOW_UID}
