#stops current running simulation
quit -sim
#Clean up any existing project in the folder
rm -rf /home/u1173001/ece_5710_final_project/TestRunner/./testResults/regFile
#adds the Project and files, The compiles
mkdir /home/u1173001/ece_5710_final_project/TestRunner/./testResults/regFile
project new /home/u1173001/ece_5710_final_project/TestRunner/./testResults/regFile regFile
project addfile /home/u1173001/ece_5710_final_project/TestRunner/../5710-Final-Project/regfile.v
project addfile /home/u1173001/ece_5710_final_project/TestRunner/../5710-Final-Project/regfile_testbench.v
project compileall
#Starts simulation with the project files and no optimization
vsim -t ns work.regfile work.regfile_testbench -voptargs=+acc
run -all
quit
