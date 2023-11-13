# ./script.sh my_argument

# Arg1 Path to script
# Arg2 Path To projects
# Arg3 Path To ProjectName
# Arg4 Path To Src

# Remaining Arguments are files
# GenerateDoScript ./tmp/test.do $TestResultsDir "internalLogic" $SrcDir "internalLogic" "internalLogictb"
# RunDoFile ./tmp/test.do $TestResultsDir "internalLogic" ./tmp/results
# vsim -c -do

function SetupTestEnv {
    CallRoot="$(pwd)"

    # Default values
    TestResultsDir=${1:-./testResults}


    SrcDir=${2:-../5710-Final-Project}

    TestResultsDir="$CallRoot/$TestResultsDir"
    ProjectDir="$TestResultsDir/InternalLogic_Tb"
    
    SrcDir="$CallRoot/$SrcDir"
    DoScripts="$CallRoot/doScripts"
    
    mkdir -p $TestResultsDir
    mkdir -p $ProjectDir
    mkdir -p $DoScripts
}

# Arg1 Path to script
# Arg2 Path To projects
# Arg3 Path To ProjectName
# Arg4 Path To Src

# Remaining Arguments are files
function GenerateDoScript {
    local DoFile=$1
    echo "Testing: $DoFile"
    if [ -f "$DoFile" ] ; then
        rm "$DoFile"
    fi
    touch $DoFile
    local projectName=$3
    local projectDir=$2/$3
    local srcFolder=$4
    shift 4
    local files=("$@")
    echo "#stops current running simulation" >> $DoFile
    echo "quit -sim" >> $DoFile
    echo "#Clean up any existing project in the folder" >> $DoFile
    echo "rm -rf $projectDir" >> $DoFile
    echo "#adds the Project and files, The compiles" >> $DoFile
    echo "mkdir $projectDir" >> $DoFile
    echo "project new $projectDir $projectName" >> $DoFile
    for i in "${files[@]}";
    do
        echo "project addfile $srcFolder/$i.v" >> $DoFile
    done
    echo "project compileall" >> $DoFile
    echo "#Starts simulation with the project files and no optimization" >> $DoFile
    packageList=""
    for i in "${files[@]}";
    do
        packageList+=" work.$i"
    done
    echo "vsim -t ns$packageList -voptargs=+acc" >> $DoFile
    echo "run -all" >> $DoFile
    echo "quit" >> $DoFile
}

# Arg1 DoFilePath
# Arg2 Path To projects
# Arg3 Path To ProjectName
# Arg4 LogFilePath
function RunDoFile {
    local projectDir=$2/$3
    local cwd=$(pwd)
    local LogFilePath=$4
    if [ -f "$LogFilePath" ] ; then
        rm "$LogFilePath"
    fi

    touch $LogFilePath
    cd $2
    vsim -c -do "$1" > "$LogFilePath"
    cd $cwd
}

# Arg1 TestName

# Arg2-N compiled Files
function RunTest {
    local TestName=$1
    shift
    local files=("$@")
    mkdir -p $TestResultsDir/Logs

    GenerateDoScript $DoScripts/$TestName.do $TestResultsDir $TestName $SrcDir ${files[@]}
    RunDoFile $DoScripts/$TestName.do $TestResultsDir $TestName $TestResultsDir/Logs/$TestName.log
}