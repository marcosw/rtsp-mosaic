#!/bin/sh

#Exporta variáveis de ambiente do arquivo .env
export $(cat .env | xargs)

#É necessário criar um script em tempo de execução pois o arquivo vlm não aceita variáveis externas (ex: $STREAM01)
cat > rtsp_mosaic.vlm << EOF

del all

new ch1 broadcast enabled
setup ch1 input $STREAM01
setup ch1 output #mosaic-bridge{id=ch1,width=640,height=540}

new ch2 broadcast enabled
setup ch2 input $STREAM02
setup ch2 output #mosaic-bridge{id=ch2,width=640,height=540}

new ch3 broadcast enabled
setup ch3 input $STREAM03
setup ch3 output #mosaic-bridge{id=ch3,width=640,height=540}

new bg broadcast enabled
# The following background file is simply a black picture with specified dimensions, you can create one with any image editor, like mspaint, it is required for proper mosaic size
setup bg input "bg.jpg"
setup bg option image-duration=-1

setup bg option image-fps=15
setup bg option mosaic-width=1920
setup bg option mosaic-height=1080
setup bg option mosaic-keep-picture=1	

setup bg output #transcode{vcodec=mp4v,vb=0,fps=0,acodec=none,channels=3,sfilter=mosaic{alpha=255,width=1280,height=1080,cols=2,rows=2,position=1,order="ch1,ch2,ch3",keep-aspect-ratio=enabled,mosaic-align=0,keep-picture=1}}:bridge-in{offset=100}:display

control bg play
control ch1 play
control ch2 play
control ch3 play

EOF

#Atribui permissão de execução
chmod +x rtsp_mosaic.vlm

#Executa o mosaico de streamings com o vlc
vlc --vlm-conf rtsp_mosaic.vlm
