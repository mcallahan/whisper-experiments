# Experiments with OpenAI Whisper

OpenAI recently released Whisper, an audio(speech) to text model.  An interesting capability of the Whisper model is it's ability to translate other languages into English text.  Real time translation could be a big deal if it really works.  The Whisper home page can be found at [Whisper](https://openai.com/blog/whisper/) for more information.

## Experiment 1: Automatic Subtitles

The first experiment starts with simple English to text transcription as it is easier to verify that it is working properly.  The target for text was the OSS Blender movie "Sprite Fright".  It's handy to have OSS movies to experiment on and "Sprite Fright" contains both much tricky dialog and existing subtitles.

Setting up Whisper was somemwhat cumbersome as it did not python venv particularly well and the instructions are to pipe curl into sudo (no).  After installation it was run with various settings to compare against the existing "Sprite Fright" subtitles.  This was fairly straightforward and the resulting subtitles can be found in the `experiments1` subdirectory of this repository.  The new subtitle text was then compared against the original subtitles.  The new subtitles were also reattached to the movie for comparison purposes. The movie can be found in the `data` subdirectory as `Sprite_Fright_whisper.webm`.

### Runtime

Whisper was ran on an older Dell XPS laptop with no GPU.  The tiny and base models run faster than real time.  The small model runs close to real time.  "medium" and up are too slow to run in real time without a GPU.

```
# Sprite Fright is 10m31.56s long
tiny.en	  1m24.699s
base.en	  6m4.119s
small.en  11m54.155s
medium.en 23m27.226s
large1	  53m2.897s
large2	  58m27.615s
```

### Non-deterministic output

By default `whisper` will not create the same text for the same audio.  It is disconcerting to have the resulting output so fragile and it makes results hard to reproduce.  Much of the spurious differences appear in the noisy parts of the audio and using a Voice Activation Detection(VAD) method to only process the speech may help.

### Puns/Wordplay

Whisper has trouble with wordplay and puns of which there are many in "Sprite Fright".  It does not understand "fungi" vs "fun guy", struggles with the latin names, and other similar issues.  This might just be a limitation of the whisper training model approach.  It would be interesting to see if pre-seeding the text with the puns helps at all.  It might help with names?  More experimentation here would be warranted.

### Hallucinations

Whisper really struggles with audio that is not speech.  The most interesting failure reported on the whisper forums is that German translations of near silence result in a closed caption copyright notice because the training data is not clean enough [copyright in silence](https://github.com/openai/whisper/discussions/679#discussioncomment-4621056).

"Sprite Fright" shows several similarly degenerate behaviors:

1) Light music confuses the model and causes it to both extend closed captions and to fill them with junk.  The clearest example is from the "tiny.en" captions where the following text is fabricated for the first minute of the movie: "I can't believe we've got to stop with the truth, I can't believe we've got to stop with the truth."  Similarly the sprites singing in the background at around the three minute mark confuses most of the model sizes.

2) Whisper randomly duplicates adjacent text, particularly low-signal text as seen in the "tiny.en" opening sequence.  This seems to be a recognition of bad text from noise but may be a bug in whisper.  There is a [bug report](https://github.com/openai/whisper/discussions/679) with the whisper source code for more context.

It appears that the best fix for hallucinations would be to run a Voice Activation Detection(VAD) algorithm to pick out just the voices from the audio, and then only run whisper on the detected segments.  There is an [ailabs tutorial](https://lablab.ai/t/whisper-transcription-and-speaker-identification) on using pyannote to determine which audio is speech and just detecting on those.

### Addendum

While watching a [YouTube video](https://www.youtube.com/watch?v=s_nc1IVoMxc) with closed captioning on I found that it exhibits many of the same issues found with this whisper experiment.  Good enough for production?
