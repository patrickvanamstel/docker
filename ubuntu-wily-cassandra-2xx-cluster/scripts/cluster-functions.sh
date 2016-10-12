source ./cluster.properties

IMAGE=patrickvanamstel/ubuntu-wily-cassandra-22x

# Check if the datafolder of the cassandra node is there
function foldersAreInPlace {
	node_name=$1_name
	node_ip_address=$1_ip_address
	node_data_folder=$1_data_folder

	if [ ! -d ${!node_data_folder} ] ;
	then
		echo "Datafolder set in property ${node_data_folder} = ${!node_data_folder} does not exist";
		exit ;
	fi
	
}

# Check if name of docker image is not already in use
# Check if ip address is not in use
# sudo docker inspect 5604ad843af8 | jq ".[0].Name" > out.json
# sudo docker ps -a -q
# sudo docker inspect 5604ad843af8 | jq ".[0].Name" | sed 's/"//g' | sed 's/\///g'
function dockerCanBeStarted {
	node_name=$1_name
	node_ip_address=$1_ip_address
	node_data_folder=$1_data_folder
	
	for dockerId in `docker ps -a -q`
	{
		dockerName=`docker inspect $dockerId | jq ".[0].Name" | sed 's/"//g' | sed 's/\///g'`
		if [ "$dockerName" == "${!node_name}" ] ;
		then
			echo "${node_name} = ${!node_name} already exists";
			exit;
		fi
		
	}
}

function stopContainer {
	node_name=$1_name
	node_ip_address=$1_ip_address
	node_data_folder=$1_data_folder
	
	for dockerId in `docker ps -a -q`
	{
		dockerName=`docker inspect $dockerId | jq ".[0].Name" | sed 's/"//g' | sed 's/\///g'`
		if [ "$dockerName" == "${!node_name}" ] ;
		then
			docker stop $dockerName
		fi
	}
}

function startContainer {
	node_name=$1_name
	node_ip_address=$1_ip_address
	node_data_folder=$1_data_folder
	
	for dockerId in `docker ps -a -q`
	{
		dockerName=`docker inspect $dockerId | jq ".[0].Name" | sed 's/"//g' | sed 's/\///g'`
		if [ "$dockerName" == "${!node_name}" ] ;
		then
			docker start $dockerName
		fi
	}
}


function echoImage {
	node_name=$1_name
	node_ip_address=$1_ip_address
	node_data_folder=$1_data_folder
	
	for dockerId in `docker ps -a -q`
	{
		dockerName=`docker inspect $dockerId | jq ".[0].Name" | sed 's/"//g' | sed 's/\///g'`
		if [ "$dockerName" == "${!node_name}" ] ;
		then
			docker inspect --format='{{.Config.Hostname}} {{.Name}} {{.Config.Image}}' --type=container $dockerId
		fi
	}
}

function deleteDockerContainer {
	node_name=$1_name
	node_ip_address=$1_ip_address
	node_data_folder=$1_data_folder
	for dockerId in `docker ps -a -q`
	{
		dockerName=`docker inspect $dockerId | jq ".[0].Name" | sed 's/"//g' | sed 's/\///g'`
		if [ "$dockerName" == "${!node_name}" ] ;
		then
			docker rm $dockerId
		fi
	}

}

function startDockerImage {
	node_name=$1_name
	node_ip_address=$1_ip_address
	node_data_folder=$1_data_folder
	
	if [ $2 == 'seed' ] ;
	then
	   echo "starting seed node ${!node_name}"
	   docker run -d --name ${!node_name} --net iptastic --ip ${!node_ip_address} -it $IMAGE
	elif [ $2 == 'slave' ] ;
	then
	   echo "starting slave node ${!node_name}"
	   docker run -d --name ${!node_name} --net iptastic --ip ${!node_ip_address} --link $SEED:seed -it $IMAGE start seed
	elif [ $2 == 'ops' ] ;
	then
	   echo echo "starting ops node ${!node_name}"
	   
	fi
	
	
	
}

function validateNodeProperties {
	node_name=$1_name
	node_ip_address=$1_ip_address
	node_data_folder=$1_data_folder
	

	if [ -z "${!node_name}" ]; 
	then 
		echo "${node_name} is not set";
		exit; 
	fi

	if [ -z "${!node_ip_address}" ]; 
	then 
		echo "${node_ip_address} is not set";
		exit; 
	fi

	if [ -z "${!node_data_folder}" ]; 
	then 
		echo "${node_data_folder} is not set";
		exit; 
	fi

	echo "${!node_name} ${!node_ip_address} ${!node_data_folder}"; 

}
