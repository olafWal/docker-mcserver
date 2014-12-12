#! /bin/bash
DATADIR=/var/data
WORLDDIR=${DATADIR}/worlds
RUNDIR=/var/MCServer
# First start code
if [ ! -f ${DATADIR}/initialized ]; then
    echo "Moving files to volume and symlinking"
    for i in "banlist.sqlite" "motd.txt" "Ranks.sqlite" "settings.ini" "webadmin.ini" "ProtectionAreas.ini" "ProtectionAreas.sqlite"; do
	echo  mv ${RUNDIR}/$i ${DATADIR}
	mv ${RUNDIR}/$i ${DATADIR}
	echo ln -s ${DATADIR}/$i ${RUNDIR}/$i
        ln -s ${DATADIR}/$i ${RUNDIR}/$i
    done

    echo "Adding existing worlds to config"
    WORLDSTR="DefaultWorld"
    for i in $(ls ${WORLDDIR}); do
	if [ -d ${WORLDDIR}/$i ]; then 
	    echo LINK: ln -s ${WORLDDIR}/$i ${RUNDIR}
	    ln -s ${WORLDDIR}/$i ${RUNDIR}
	    echo $WORLDSTR=$i >> ${DATADIR}/settings.ini
	    WORLDSTR="World"
	fi
    done

    touch ${DATADIR}/initialized
else
    # It may be an update
    for i in $(ls ${WORLDDIR}); do
	if [ -d ${WORLDDIR}/$i ]; then 
	    if [ -d ${RUNDIR}/$i ]; then
		continue;
	    fi
	    echo UPDATE: ln -s ${WORLDDIR}/$i ${RUNDIR}
	    ln -s ${WORLDDIR}/$i ${RUNDIR}
	fi
    done
    echo "Symlinking files from datadir"
    for i in "banlist.sqlite" "motd.txt" "Ranks.sqlite" "settings.ini" "webadmin.ini" "ProtectionAreas.ini" "ProtectionAreas.sqlite"; do
	rm -f ${RUNDIR}/$i 
        ln -s ${DATADIR}/$i ${RUNDIR}/$i
    done
fi;




cd /var/MCServer
./MCServer
