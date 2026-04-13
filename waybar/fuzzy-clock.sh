#!/bin/bash

# hourNames array (12 hours x 12 sectors)
hour_names=(
    "One o'clock" "Five past one" "Ten past one" "Quarter past one" "Twenty past one" "Twenty-five past one" "Half past one" "Twenty-five to two" "Twenty to two" "Quarter to two" "Ten to two" "Five to two"
    "Two o'clock" "Five past two" "Ten past two" "Quarter past two" "Twenty past two" "Twenty-five past two" "Half past two" "Twenty-five to three" "Twenty to three" "Quarter to three" "Ten to three" "Five to three"
    "Three o'clock" "Five past three" "Ten past three" "Quarter past three" "Twenty past three" "Twenty-five past three" "Half past three" "Twenty-five to four" "Twenty to four" "Quarter to four" "Ten to four" "Five to four"
    "Four o'clock" "Five past four" "Ten past four" "Quarter past four" "Twenty past four" "Twenty-five past four" "Half past four" "Twenty-five to five" "Twenty to five" "Quarter to five" "Ten to five" "Five to five"
    "Five o'clock" "Five past five" "Ten past five" "Quarter past five" "Twenty past five" "Twenty-five past five" "Half past five" "Twenty-five to six" "Twenty to six" "Quarter to six" "Ten to six" "Five to six"
    "Six o'clock" "Five past six" "Ten past six" "Quarter past six" "Twenty past six" "Twenty-five past six" "Half past six" "Twenty-five to seven" "Twenty to seven" "Quarter to seven" "Ten to seven" "Five to seven"
    "Seven o'clock" "Five past seven" "Ten past seven" "Quarter past seven" "Twenty past seven" "Twenty-five past seven" "Half past seven" "Twenty-five to eight" "Twenty to eight" "Quarter to eight" "Ten to eight" "Five to eight"
    "Eight o'clock" "Five past eight" "Ten past eight" "Quarter past eight" "Twenty past eight" "Twenty-five past eight" "Half past eight" "Twenty-five to nine" "Twenty to nine" "Quarter to nine" "Ten to nine" "Five to nine"
    "Nine o'clock" "Five past nine" "Ten past nine" "Quarter past nine" "Twenty past nine" "Twenty-five past nine" "Half past nine" "Twenty-five to ten" "Twenty to ten" "Quarter to ten" "Ten to ten" "Five to ten"
    "Ten o'clock" "Five past ten" "Ten past ten" "Quarter past ten" "Twenty past ten" "Twenty-five past ten" "Half past ten" "Twenty-five to eleven" "Twenty to eleven" "Quarter to eleven" "Ten to eleven" "Five to eleven"
    "Eleven o'clock" "Five past eleven" "Ten past eleven" "Quarter past eleven" "Twenty past eleven" "Twenty-five past eleven" "Half past eleven" "Twenty-five to twelve" "Twenty to twelve" "Quarter to twelve" "Ten to twelve" "Five to twelve"
    "Twelve o'clock" "Five past twelve" "Ten past twelve" "Quarter past twelve" "Twenty past twelve" "Twenty-five past twelve" "Half past twelve" "Twenty-five to one" "Twenty to one" "Quarter to one" "Ten to one" "Five to one"
)

hours=$(date +%H)
hours=${hours#0}
minutes=$(date +%M)

# Fuzziness 1 logic exactly as provided
if [ "$minutes" -gt 2 ]; then
    sector=$(( (minutes - 3) / 5 + 1 ))
else
    sector=0
fi

sector=$((sector))

# realHour calculation
if [ $((hours % 12)) -gt 0 ]; then
    real_hour=$((10#${hours} % 12 - 1))
else
    real_hour=$((12 - (10#${hours} % 12 + 1)))
fi

# Sector 12 handling
if [ "$sector" -eq 12 ]; then
    real_hour=$((real_hour + 1))
    if [ "$real_hour" -ge 12 ]; then
        real_hour=0
    fi
    sector=0
fi

# Get the phrase (each hour has 12 entries, 144 total)
index=$((real_hour * 12 + sector))
phrase="${hour_names[$index]}"

# Add AM/PM
ampm=$(date +%p)
echo "$phrase $ampm"       

echo "$(date '+%H:%M on %Y-%m-%d')"
#echo "$(date +%H:%M)"
