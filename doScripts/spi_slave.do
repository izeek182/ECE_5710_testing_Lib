#stops current running simulation
quit -sim
#Clean up any existing project in the folder
rm -rf /home/u1173001/ece_5710_final_project/TestRunner/./testResults/spi_slave
#adds the Project and files, The compiles
mkdir /home/u1173001/ece_5710_final_project/TestRunner/./testResults/spi_slave
project new /home/u1173001/ece_5710_final_project/TestRunner/./testResults/spi_slave spi_slave
project addfile /home/u1173001/ece_5710_final_project/TestRunner/../5710-Final-Project/spi_slave.v
project addfile /home/u1173001/ece_5710_final_project/TestRunner/../5710-Final-Project/spi_slave_testbench.v
project compileall
#Starts simulation with the project files and no optimization
vsim -t ns work.spi_slave work.spi_slave_testbench -voptargs=+acc
run -all
quit
