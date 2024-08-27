# Easy Zip
## A Command Line utility to make extracting .zip, .gz, .tar, and much more, a lot easier!

### Current Commands
- ```-h:   help menu```
- ```-c:   shows where extracted file contents are outputed.```
- ```-a:   shows how many archives have been extracted to output.```
- ```-e:   erase all archives in your output directory.```
- ```-rc:  reset config file.```
- ```-zip: unzip file (ezzip -zip <directory to file.zip>)```
- ```-gz:  uncompress .gz file (ezzip -gz <directory to file.gz>)```
- ```-tar: uncompress .tar file (ezzip -tarr <directory to file.tar>)```
- ```-tar.gz: uncompress .tar.gz (ezzip -tar.gz <directory to file.tar.gz>)```

### Changing your config
Whenever you start or use ezzip, ezzip will check for a config file. If there is not ezzip folder inside of the .config folder, it will create one called ```ezzip``` and put an ```ezziprc.sh``` file inside. This ezziprc.sh file will contain the directory all your decompressed files will go to. This is also your config file. If you change the directory to something that doesn't exist, it will automatically create the ouput folder for you. So, everything will be handled for you. The directory of your config file will always be inside ```~/.config/ezzip/```. If you put the config file anywhere else, it wont be detected. 

MAKE SURE TO ADD THE DIRECTORY OF THE EXECUTABLE TO THE PATH!