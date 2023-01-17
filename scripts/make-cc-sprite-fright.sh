# Rebuild Sprite_Fright with the newly constructed closed captionings.

ffmpeg -i Sprite_Fright.webm \
-i tiny.en/audio.ogg.vtt \
-i tiny/audio.ogg.vtt \
-i base.en/audio.ogg.vtt \
-i base/audio.ogg.vtt \
-i small.en/audio.ogg.vtt \
-i small/audio.ogg.vtt \
-i medium.en/audio.ogg.vtt \
-i medium/audio.ogg.vtt \
-i large-v1/audio.ogg.vtt \
-i large-v2/audio.ogg.vtt \
-i large/audio.ogg.vtt \
-map 0:v -map 0:a \
-map 1 -metadata:s:2 language=tiny.en \
-map 2 -metadata:s:3 language=tiny \
-map 3 -metadata:s:4 language=base.en \
-map 4 -metadata:s:5 language=base \
-map 5 -metadata:s:6 language=small.en \
-map 6 -metadata:s:7 language=small \
-map 7 -metadata:s:8 language=medium.en \
-map 8 -metadata:s:9 language=medium \
-map 9 -metadata:s:10 language=large-v1 \
-map 10 -metadata:s:11 language=large-v2 \
-map 11 -metadata:s:12 language=large \
-c:v copy -c:a copy -c:s webvtt Many.webm
