#stops current running simulation
quit -sim
#Clean up any existing project in the folder
rm -rf /home/u1173001/ece_5710_final_project/TestRunner/./testResults/internalLogic
#adds the Project and files, The compiles
mkdir /home/u1173001/ece_5710_final_project/TestRunner/./testResults/internalLogic
project new /home/u1173001/ece_5710_final_project/TestRunner/./testResults/internalLogic internalLogic
project addfile /home/u1173001/ece_5710_final_project/TestRunner/../5710-Final-Project/internalLogic.v
project addfile /home/u1173001/ece_5710_final_project/TestRunner/../5710-Final-Project/internalLogictb.v
project compileall
#Starts simulation with the project files and no optimization
vsim -t ns work.internalLogic work.internalLogictb -voptargs=+acc
run -all
quit
