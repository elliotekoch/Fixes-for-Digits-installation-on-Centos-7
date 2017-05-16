# Fixes-for-Digits-installation-on-Centos-7
Digits 5.x can be installed on Centos 7 but is not officially supported

There is an unofficial script provided by Luke Yeager https://gist.github.com/lukeyeager/ba948f1d56e4ab407874 which does a pretty good job of installing Digits on centos 7, but has a couple of issues. 

1. The cloning process will not allow you to overwrite an existin directory, so i have added some pre-cleanup to his script enclosed in this repository.

2. To compile correctly, there are some minor code modifications required to Caffe. Both the original I started with and the modified version are included here. I'm not a hard core C programmer so... 

=== USE AT YOUR OWN RISK ===
