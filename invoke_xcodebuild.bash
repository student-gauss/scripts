# Invoke xcodebuild at the nearest ancestral directory where
# *.xcodeproj file is located.

project_directory=$PWD

until [ "$project_directory" = "/" ] ; do
    FILTER=$(find $project_directory -maxdepth 1 \( -name "*.xcodeproj" \) )
    if [ ${FILTER} ] ; then
        xcodebuild -project ${FILTER} -alltargets
        break
    fi
    project_directory=$(dirname $project_directory)
done

