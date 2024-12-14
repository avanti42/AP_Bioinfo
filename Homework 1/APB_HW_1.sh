Lecture 1


3. I can tell I was successful as there was a Linux icon at the end of the list of folders in my documents, After opening Ubuntu I got the prompt  username@hostname:~$
When I used pwd and then made a new directory I could manually locate my directory.
4.   I could not run the samtools program so I installed it using the command line -
sudo apt install samtools
5. samtools 1.13
6. https://github.com/avanti42/AP_Bioinfo.git


Lecture 2


1. htop is a command that launches an interactive dashboard displaying real-time information about the system processes, memory usage, etc. It helps to monitor system processes interactively in real time.  It can be used when many processes are running together on a system/server to identify how much resources they consume. 
2. htop -u username 
This customization can be used to open the htop dashboard to display the processes only run by that username. The -u flag is filtering the system processing and only shows information for usage for a specified username. 
3. Adding -h to the ls command will convert the file sizes into a more human-readable format. This flag can be combined with other parameters like -1h etc.
4. The Flag -i will make the rm command ask for permission when removing a file.
5. #Nested Directory structure
pwd
mkdir -p /home/avabioinfo/folder1
mkdir -p /home/avabioinfo/folder2
mkdir -p /home/avabioinfo/folder1/folder3
#Create files in different directories
touch /home/avabioinfo/folder1/file1.sh
touch /home/avabioinfo/folder2/file2.c
touch /home/avabioinfo/folder1/folder3/code.t
#Verify if the files and directories got made
ls -R /home/avabioinfo


6. #Absolute path to a file
ls /home/avabioinfo/folder1
#Relative path to a file
ls folder1
7. #Current directory shortcut
ls .
#Parent directory shortcut
cd ../
#Home directory shortcut
cd ~/