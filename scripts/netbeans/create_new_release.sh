#!/bin/bash

OLD=${1}
NEW=${2}
SOURCE_URL=${3}

if [[ -z "${OLD}" ]] || [[ -z "${NEW}" ]] || [[ -z "${SOURCE_URL}" ]] ; then
	echo "Usage: <old_version_string> <new_version_string> <new_source_url>"
	exit 1
fi

pushd $(dirname $(dirname $(dirname $(readlink -f ${0})))) >/dev/null || exit 1

for file in */*/*${OLD}*.ebuild ; do
	cp ${file} $(echo ${file} | sed "s/${OLD}/${NEW}/") || exit 1
done

sed -i "s%SOURCE_URL=.*%SOURCE_URL=\"${SOURCE_URL}\"%" */*/*${NEW}*.ebuild || exit 1

for file in */*/*${NEW}*.ebuild ; do
	ebuild ${file} manifest
done

popd >/dev/null || exit 1
