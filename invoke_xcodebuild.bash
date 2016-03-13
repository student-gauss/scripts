# Invoke xcodebuild at the nearest ancestral directory where
# *.xcodeproj file is located.

project_directory=$PWD

until [ "$project_directory" = "/" ] ; do
    FILTER=$(find $project_directory -maxdepth 1 \( -name "*.xcodeproj" \) )
    if [ ${FILTER} ] ; then
        project_directory=${FILTER}

        FILTER=$(find $project_directory -maxdepth 1 \( -name "*.xcworkspace" \) )

        if [ ${FILTER} ] ; then
            # The project uses a built-in workspace
            builtin_workspace=${FILTER}

            # The scheme name is assumed to be same as the project name
            scheme_name=$(basename ${project_directory} .xcodeproj)

            xcodebuild -workspace ${builtin_workspace} -scheme ${scheme_name}
        else
            xcodebuild -project ${project_directory} -alltargets
        fi

        break
    fi
    project_directory=$(dirname $project_directory)
done
