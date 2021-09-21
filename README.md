# movie_scrapper
This Python-Flask based small program will get movie plot information from IMDB, I use BeautifulSoup to parse IMDB website and get the info I want, I'm not a Python developer and this is my first try

# **PART 1: How to Build From Scratch**
You can follow this instruction to setup your development environment from scratch then run the program and build it as Docker image and run it in a container. You can skip this section and proceed to PART 2 if you only interested in running the image in Docker container and test it.

## Development Setup Requirements:  
- Python -> This program is based on Python  
- Flask and other required library -> install using pip  
- WSL2 -> Running Linux as Windows subsystem, basically running Linux directly in Windows, what not to love!  
- Docker -> Obviously you need this  
- Windows Terminal -> Faboulous terminal to run multiple terminal session side-by-side  
- Visual Studio Code -> nice and lighweight IDE with support of multiple programming languages and plugins

## Install WSL2
- to install WSL 2 on Windows 10 OS Build 2004 or later you need to open the command prompt app with Administrator permissions, and enter the following command:  

`wsl.exe --install`  

- Once done you can reboot and Windows will continue to install Ubuntu, after that you will be prompted to create new Ubuntu user ID and set the password

## Install Windows Terminal  
- You can easily install Windows Terminal from Microsoft Store  
![windows_terminal](https://user-images.githubusercontent.com/91014925/134155910-af473976-d139-47cc-bdee-85feea9db8e3.jpg)

## Install Docker for Windows
- Get the latest version of [Docker for Windows here](https://docs.docker.com/desktop/windows/install/), just click next and intall it, once the installation finished you can double click Docker icon in your destop to laumch the GUI, go to Settings page to enable WSL2 integration then save and restart Docker  
![docker_wsl](https://user-images.githubusercontent.com/91014925/134161226-508fc2d7-5cb6-4732-95ec-3f9bee2bdc40.jpg)

## Install Visual Studio Code
- You can use any IDE of your choice but I've been digging Visual Studio Code recently, get it [here](https://code.visualstudio.com/), install it and also dont forget to install Python plugins and Visual Studio IntelliCode to use IntelliSense (syntax highlighting, autocomplete, etc). This is optional and only required if you want to check the source code  
![vs_code](https://user-images.githubusercontent.com/91014925/134157594-34c2b1d7-0742-4591-9bd5-29592549088b.jpg)  

## Install Python  
- Open your Windows Terminal, switch to Ubuntu terminal and run below command  
`sudo apt-get update` This is to update your Ubuntu update repository  
`sudo apt-get install python3.9` this is to install Python 3.9  
- Run `python3 --version` to verify your Python installation  

## Create The Project Structure    
You can download **movie_scrapper_html.zip** and unzip it, alternatively you can do manually using below steps  
- Go to **movie_scrapper_html** folder and create **app** folder  
- Place **run.py** file to **movie_scrapper_html** folder  
- Go to **app** folder and create **templates** folder
- Place __init__.py and views.py into **app** folder  
- Go to **templates** folder and place all the **.html** files there 
## Install the required libraries and components to develop and run the program  
- Open Windows Terminal and switch to Ubuntu Terminal  
- Install PIP using this command `sudo apt install python3-pip`
- Navigate to **movie_scrapper_html** folder and run `pip3 install -r requirements.txt` to install all the components at one go  
- Close and open the terminal again  
- Run `flask --version` to verify Flask installation  

## Test Your Development Environment  
- Open Windows Terminal and select Ubuntu  
![terminal_ubuntu](https://user-images.githubusercontent.com/91014925/134158228-0e62d925-1f7d-4a2f-83ed-0c36f5fcf0bb.jpg)

- Type `wslfetch` to verify your WSL2 installation, should see something like below  
![wsl2_linux](https://user-images.githubusercontent.com/91014925/134159929-fb15f141-8cff-4409-913e-ba5972b66740.jpg)

- Type `docker --version` in your terminal to verify if Docker configured properly  
![docker_version](https://user-images.githubusercontent.com/91014925/134160303-fd51c2d9-0a1c-41b6-95a6-0206a58eda58.jpg)

## Enable Python Virtual Environment  
This steo is to create a virtual environment for your development so if anything bad happen it won't affect your main Python installation  
- Run `pip3 install virtualenv` to install **virtualenv**  
- Run `virtualenv movie_scrapper_html` to create virtual environment in folder **movie_scrapper_html**
- Go to one level above **movie_scrapper_html** folder and run `source movie_scrapper_html/bin/activate` to activate the virtual environment, You should see the name of your virtual environment in brackets on your terminal line e.g. (mypython)  
![virtualenv](https://user-images.githubusercontent.com/91014925/134171198-716dc2b9-aa42-4ba8-8106-5a1ca1bcc44f.jpg)  

## Run The Program  
- Make sure you are inside **movie_scrapper_html** folder and the run `flask run --host=0.0.0.0 --port=5050` command to start the application  
![flask_run](https://user-images.githubusercontent.com/91014925/134171924-c3be618d-01d9-4ff5-b5d7-339b2bd43b8f.jpg)  

- Open browser and access this URL to access the application  
`http://localhost:5050/`  
![app_run](https://user-images.githubusercontent.com/91014925/134184751-a1040b7a-9203-475a-aae7-abeed72024fc.jpg)  
Enter any movie title and the application will give you the plot, this is a dumb application since it only give you the first movie and plot it can find which can be inaccurate  
## Dockerize your Python Application  
- You need to create a dockerfile first, go to **movie_scrapper_html** folder and place **dockerfile** file inside, this file basically tell Docker the steps and the requirements needed by the application to run, docker will build the application image based on the instruction inside this file

- Run below command to build your Docker image and tag/name it as **movie_scrapper**  
`docker build --tag movie_scrapper .`  
![docker_build](https://user-images.githubusercontent.com/91014925/134175430-a0aec091-65a9-4a74-b4f5-dcbed80fca28.jpg)


- Run below command to list all your available Docker image  
`docker images`  
![docker_images](https://user-images.githubusercontent.com/91014925/134175586-843c3975-27ef-4006-8798-f1ae2e2d5519.jpg)


- Run the image in a container, this will map internal port 5050 of the container to your localhost port 5050, **-d** is to tell Docker to run application in the background  
`docker run -d -p 5050:5050 movie_scrapper`  
![docker_run](https://user-images.githubusercontent.com/91014925/134175761-3f625a7e-a5c3-4ea9-9606-3f7a0930f4c8.jpg)  

- Open browser and navigate to `http://localhost:5050/` to access the app  

## Push The Image to Docker Hub  
- Login to Docker Hub using below command, replace **userID** with your Docker Hub ID  
`docker login --username userID`  

- Tag your Docker image using this format docker_user_ID/repo_name, replace **userID** with your Docker Hub ID  
`docker tag movie_scrapper userID/movie_scrapper`  

- Push your image to Docker Hub, replace **userID** with your Docker Hub ID  
`docker push userID/movie_scrapper`  
![docker_push](https://user-images.githubusercontent.com/91014925/134188952-fc43fa1c-b6bf-4594-a0d5-dd0d270c4b10.jpg)




# **PART 2: How to Pull The Image From Docker Hub**  
This part is for those who want to pull the application image from Docker Hub and run the app in a Docker container  

## Pull image from public repository  
- Run below command from your terminal to pull image from my public repository  
`docker pull coldspidey/movie_scrapper`  

- Verify if the image successfully pulled  
`docker images`  

## Run the image  
- Run the image in a container, this will map internal port 5050 of the container to your localhost port 5050, **-d** is to tell Docker to run application in the background  
`docker run -d -p 5050:5050 coldspidey/movie_scrapper`  

![docker_run](https://user-images.githubusercontent.com/91014925/134175761-3f625a7e-a5c3-4ea9-9606-3f7a0930f4c8.jpg)  

- Open browser and navigate to `http://localhost:5050/` to access the app  





