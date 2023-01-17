# Run all of the whisper settings on audio.ogg
# Note that whisper results are non-deterministic so running this script
# multiple times will result in different results.

for m in tiny.en tiny base.en base small.en small medium.en medium large-v1 large-v2 large
do
    time ~/.local/bin/whisper --model $m audio.ogg
    mkdir $m
    mv audio.ogg.* $m
done


