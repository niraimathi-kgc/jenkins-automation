#FROM ubuntu
#WORKDIR /home/utthunga/test-website/
#RUN apt-get update
#RUN apt -y install apache2
#RUN service nginx start
#COPY ./test/index.html /var/www/html/
#EXPOSE 80
#CMD [ "service", "nginx", "start" ]
#CMD /root/run_apache.sh
FROM ubuntu/apache2
#WORKDIR /Test-Automation-Practice
COPY ./Test-Automation-Practice /var/www/html
EXPOSE 80