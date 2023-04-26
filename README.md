# rtsp-mosaic
Script do vlc para adicionar multiplos streams rtsp em uma única janela

Setup:
* Ubuntu 18.04
* VLC 3.0.8

Modelos RTSP:
* Hikvision:
* #rtsp://[usuario]:[senha]@[ip]:554/Streaming/Channels/101
* #rtsp://[usuario]:[senha]@[ip]:554/Streaming/Channels/102

Modelos webcam:
* v4l2:///dev/video2
* Obs.: o comando acima obtém a webcam visível pelo sistema. Para utilizar smartphone, pode-se utilizar o app droidcam em conjunto. Instalação em: https://diolinux.com.br/aplicativos/droidcam-webcam-com-o-smartphone.html

Execução:
1) Crie um arquivo .env utilizando o arquivo .env.example com exemplo.
2) Execute "source execute_rtsp_mosaic.sh"
