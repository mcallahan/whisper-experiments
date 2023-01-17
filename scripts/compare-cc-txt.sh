# Rough code for counting word differences between two whisper output texts.
# Generally /tmp/words.txt would contain the original expected text and
# would be created separately.
# This does not compute track timing differences.
# This also deduplicates the whisper text because it hallucinates up all
# sorts of adjacent duplicate output.

for m in tiny.en tiny base.en base small.en small medium.en medium large-v1 large-v2 large
do
    uniq $m/audio.ogg.txt | sed 's/ /\n/g' | tr '[:upper:]' '[:lower:]' | tr -d '[:punct:]'> /tmp/$m.txt
    diff /tmp/words.txt /tmp/$m.txt > $m/words.diff
done


#SDQUO=$(echo -ne '\u2018\u2019')
#RDQUO=$(echo -ne '\u201C\u201D')
#$SED -i -e "s/[$SDQUO]/\'/g" -e "s/[$RDQUO]/\"/g" "${1}"
#uniq /tmp/orig.txt | sed 's/ /\n/g' | tr '[:upper:]' '[:lower:]' | tr -d '[:punct:]' | sed "s/[$SDQUO]/\'/g" | sed "s/[RDQUO]/\"/g" > /tmp/words.txt
