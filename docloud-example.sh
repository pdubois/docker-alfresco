sudo docker run -it -e DOCKERCLOUD_USER=yourid -e DOCKERCLOUD_PASS=yourpass --rm dockercloud/cli service run \
-e INITIAL_PASS=admun \
-e ALF_1=mail.host.EQ.smtp.gmail.com \
-e ALF_2=mail.port.EQ.587 \
-e ALF_3=mail.username.EQ.xxxxx@gmail.com \
-e ALF_4=mail.password.EQ.xxxxxxx \
-e ALF_5=mail.protocol.EQ.smtp \
-e ALF_6=mail.encoding.EQ.UTF-8 \
-e ALF_7=mail.from.default.EQ.pdubois824@gmail.com \
-e ALF_8=mail.smtp.starttls.enable.EQ.true \
-e ALF_9=mail.smtp.auth.EQ.true \
-e ALF_10=mail.smtp.debug.EQ.false \
-e ALF_11=mail.testmessage.send.EQ.true \
-e ALF_12=mail.testmessage.to.EQ.xxxxxx@gmail.com \
-e ALF_13=mail.testmessage.subject.EQ."Outbound SMTP" \
-e ALF_14=mail.testmessage.text.EQ."The Outbound SMTP email subsystem is working." \
-e ALF_15=mail.smtp.socketFactory.port.EQ.587 \
-e ALF_16=mail.smtp.socketFactory.class.EQ.javax.net.ssl.SSLSocketFactory \
-e ALF_17=mail.smtp.socketFactory.fallback.EQ.false \
-e ALF_18=share.context.EQ.alfresco-test-docker \
-e ALF_19=share.host.EQ.146.185.143.92 \
-e ALF_20=share.port.EQ.8443 \
-e ALF_21=share.protocol.EQ.https \
-e ALF_22=share.protocol.EQ.https \
-p 8449:8443 pdubois/docker-alfresco:master


