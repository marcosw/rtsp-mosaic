ffmpeg -rtsp_transport tcp \
    -i rtsp://admin:pass@192.168.0.211:554/Streaming/Channels/1 \
    -i rtsp://admin:pass@192.168.0.210:554/Streaming/Channels/1 \
    -i rtsp://admin:pass@192.168.0.211:554/Streaming/Channels/1 \
    -i rtsp://admin:pass@192.168.0.210:554/Streaming/Channels/1 \
    -filter_complex "
		nullsrc=size=1920×1080 [base];
		[0:v] setpts=PTS-STARTPTS, scale=960×540 [upperleft];
		[1:v] setpts=PTS-STARTPTS, scale=960×540 [upperright];
		[2:v] setpts=PTS-STARTPTS, scale=960×540 [lowerleft];
		[3:v] setpts=PTS-STARTPTS, scale=960×540 [lowerright];
		[base][upperleft] overlay=shortest=1 [tmp1];
		[tmp1][upperright] overlay=shortest=1:x=960 [tmp2];
		[tmp2][lowerleft] overlay=shortest=1:y=540 [tmp3];
		[tmp3][lowerright] overlay=shortest=1:x=960:y=540
	" \
	-c:v libx264 -preset superfast -crf 18 -f matroska – | ffplay –
