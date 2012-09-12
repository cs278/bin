#!/bin/sh

CARD=0;
IDENT="name=\"Master Playback Volume\"";
MAX=31;
NAME="Master Playback Volume";

if [ "$1" != "" ]; then
	if [ "${1:${#1} - 1:1}" == "%" ]; then
		VOL=${1:0:${#1} - 1};
		VOL=$(( VOL * MAX ));
		VOL=$(( VOL / 100 ));
	else
		VOL=$1;
	fi
	amixer -c $CARD -q cset name='Master Playback Volume' $VOL
fi

amixer -c $CARD cget name='Master Playback Volume' | tail -n 1 | awk '{ print $2; }' | replace values= "" | xargs -d "," | head -n 1 | awk '{ print $1; }'
#amixer -c $CARD cget $IDENT | tail -n 1 | awk '{ print $2; }' | replace values= "" | xargs -d "," | head -n 1 | awk '{ print $1; }'

#amixer -c $CARD --debug cget name='Master';
#echo $X;
#exec $X;

#echo "cget $IDENT" | amixer --stdin --card $CARD --debug 

exit $?;
