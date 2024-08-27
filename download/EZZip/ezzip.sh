# Michael S. 2021
# Easy Unzip Tool
#!/usr/bin/env bash

fileType=$1
file=$2

if [ ! -d $HOME/.config/ezzip ]; then
	mkdir $HOME/.config/ezzip
	touch $HOME/.config/ezzip/ezziprc.sh
	echo "# Default EzZip Config" > $HOME/.config/ezzip/ezziprc.sh
	echo "outputFolder=${HOME}/EzZip" > $HOME/.config/ezzip/ezziprc.sh
	source $HOME/.config/ezzip/ezziprc.sh
else
	if [ -e $HOME/.config/ezzip/ezziprc.sh ]; then
		source $HOME/.config/ezzip/ezziprc.sh
	else
		touch $HOME/.config/ezzip/ezziprc.sh
		echo "# Default EzZip Config" > $HOME/.config/ezzip/ezziprc.sh
		echo "outputFolder=${HOME}/EzZip" > $HOME/.config/ezzip/ezziprc.sh
		source $HOME/.config/ezzip/ezziprc.sh
	fi
fi

if [ ! -d $outputFolder ]; then
	echo "EzZip destination directory not found. Creating..."
	mkdir "$outputFolder"
	echo
fi

case $fileType in
    -h)
	echo "Easy Unzip v1.1.3"
	echo "-h:      shows all args"
	echo "-c:      see your current config"
	echo "-rc:     reset config file"
	echo "-a:      show amount of archives in ${outputFolder}"
	echo "-e:      erase all archives in ${outputFolder}"
	echo "-zip:    unzip file (ezzip -zip <directory to file.zip>)"
	echo "-gz:     uncompress .gz file (ezzip -gz <directory to file.gz>)"
	echo "-tar:    uncompress .tar file (ezzip -tar <directory to file.tar>)"
	echo "-tar.gz: uncompress .tar.gz file (ezzip -tar.gz <directory to file.tar.gz>)"
	;;
	-rc)
	if [[ ! -e $HOME/.config/ezzip/ezziprc.sh ]]; then
		echo "Resetting config."
		touch $HOME/.config/ezzip/ezziprc.sh
		echo "# Default EzZip Config" > $HOME/.config/ezzip/ezziprc.sh
		echo "outputFolder=${HOME}/EzZip" > $HOME/.config/ezzip/ezziprc.sh
	else
		echo "Resetting config."
		rm $HOME/.config/ezzip/ezziprc.sh
		touch $HOME/.config/ezzip/ezziprc.sh
		echo "# Default EzZip Config" > $HOME/.config/ezzip/ezziprc.sh
		echo "outputFolder=${HOME}/EzZip" > $HOME/.config/ezzip/ezziprc.sh
	fi
	;;
	-c)
	echo "Easy Unzip v1.1.3 Config"
	echo "Current output folder: ${outputFolder}"
	;;
	-a)
	sa=$(ls -l ${outputFolder} | grep "^d" | wc -l)
	echo "There are currently: ${sa} archives in ${outputFolder}!"
	;;
	-e)
	read -p "Are you sure you want to delete all archives? (Y/n) " delArchives
	case $delArchives in
		[Yy]* ) echo "Overwriting..."
			rm -r $outputFolder/*
			;;
		[Nn]* ) echo "Not deleting." ;;
		*) echo "Not valid!" ;;
	esac
	;;
	-zip)
	if [[ "${2: -4}" == ".zip" ]]; then 
		if [[ -f $2 ]]; then
			thing="$(basename "$2" | sed 's/\(.*\)\..*/\1/')"
			f=$(unzip "$2" -d $outputFolder/$thing)
			echo "Successfully extracted."
		else
			echo "The file you tried to unzip couldn't be found."
		fi
	else
		echo "That is not a zip file!"
	fi
	;;
	-gz)
	if [[ "${2: -3}" == ".gz" ]]; then 
		if [[ -f $2 ]]; then
			thing="$(basename "$2" | sed 's/\(.*\)\..*/\1/' | sed 's/\(.*\)\..*/\1/')"
			cp $2 $outputFolder
			#files="$(ls $HOME/EzZip/*.gz)"
			fff=${2##*/}
			if [[ ! -d $outputFolder/$thing ]]; then
				mkdir $outputFolder/$thing
				gzip -dc < $outputFolder/$fff > $outputFolder/$thing/$thing
				rm -r $outputFolder/$fff
				echo "Successfully extracted."
			else
				read -p "You have already extracted this archive! Overwrite (Y/n) " overwriteUno
				case $overwriteUno in
					[Yy]* ) echo "Overwriting..."
							rm -r $outputFolder/$thing
							rm -r $outputFolder/$fff
							;;
					[Nn]* ) echo "Not overwriting." ;;
					* ) echo "Not valid!" ;;
				esac
			fi
		else
			echo "The file you tried to gunzip couldn't be found."
		fi
	else
		echo "That is not a gz file!"
	fi	
	;;
	-tar)
	#tar -xvf filename.tar
	if [[ "${2: -4}" == ".tar" ]]; then 
		if [[ -f $2 ]]; then
			thing="$(basename "$2" | sed 's/\(.*\)\..*/\1/')"
			if [[ ! -d $outputFolder/$thing ]]; then			
				f=$(mkdir $outputFolder/$thing)
				g=$(tar -xvf $2 -C $outputFolder/$thing)
				echo "Successfully extracted."
			else
				echo "This archive has already been extracted!"
			fi
		else
			echo "The file you tried to decompress couldn't be found."
		fi
	else
		echo "That is not a tar file!"
	fi	
	;;
	-tar.gz)
	#tar -xzf filename.tar.gz
	if [[ "${2: -7}" == ".tar.gz" ]]; then 
		if [[ -f $2 ]]; then
			thing="$(basename "$2" | sed 's/\(.*\)\..*/\1/' | sed 's/\(.*\)\..*/\1/')"
			if [[ ! -d $outputFolder/$thing ]]; then			
				f=$(mkdir $outputFolder/$thing)
				g=$(tar -xzf $2 -C $outputFolder/$thing)
				echo "Successfully extracted."
			else
				echo "This archive has already been extracted!"
			fi
		else
			echo "The file you tried to decompress couldn't be found."
		fi
	else
		echo ${2: -4}
		echo "That is not a tar.gz file!"
	fi	
	;;
    *)
	echo "That isn't valid!"
	;;
esac