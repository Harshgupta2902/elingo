#!/bin/bash


echo 'user123' | sudo -S /opt/lampp/xampp start

# Function to update ChromeDriver
#update_chromedriver() {
#    # Determine the current version of Google Chrome installed
#    chrome_version=$(google-chrome --version | awk '{print $3}')
#    major_version=$(echo "$chrome_version" | cut -d '.' -f1)
#
#    # Download the corresponding ChromeDriver version
#    chromedriver_url="https://chromedriver.storage.googleapis.com/LATEST_RELEASE_${major_version}"
#    chromedriver_version=$(curl -s "${chromedriver_url}")
#    chromedriver_download_url="https://chromedriver.storage.googleapis.com/${chromedriver_version}/chromedriver_linux64.zip"
#
#    echo "Downloading ChromeDriver version ${chromedriver_version}..."
#    curl -o chromedriver_linux64.zip "${chromedriver_download_url}"
#
#    # Extract the downloaded ChromeDriver binary
#    unzip -o chromedriver_linux64.zip
#
#    # Replace the existing ChromeDriver binary
#    sudo mv chromedriver /usr/local/bin/
#
#    # Set executable permissions
#    sudo chmod +x /usr/local/bin/chromedriver
#
#    # Clean up downloaded files
#    rm chromedriver_linux64.zip
#
#    echo "ChromeDriver has been updated to version ${chromedriver_version}."
#}
#
## Check if ChromeDriver is installed
#if ! command -v chromedriver &> /dev/null; then
#    echo "ChromeDriver is not installed. Updating..."
#    update_chromedriver
#else
#    # Check if ChromeDriver version is compatible
#    chromedriver_version=$(chromedriver --version | awk '{print $2}')
#    if [[ "$chromedriver_version" != "122.0.0.0" ]]; then
#        echo "ChromeDriver is outdated. Updating..."
#        update_chromedriver
#    else
#        echo "ChromeDriver is up to date."
#    fi
#fi

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "Python3 is not installed. Please install Python3."
    exit 1
fi

# Check if Selenium is installed
if ! python3 -c "import selenium" &> /dev/null; then
    echo "Selenium is not installed. Installing..."
    sudo apt install python3-pip
    pip3 install selenium
fi

# Define the Python script
python_script=$(cat << 'EOF'
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import time

try:
    # Set Chrome options to ignore SSL certificate errors
    chrome_options = Options()
    chrome_options.add_argument("--ignore-certificate-errors")

    # Initialize the WebDriver with Chrome options
    driver = webdriver.Chrome(options=chrome_options)

    # URL of the authentication page
    url = "https://10.26.2.2:8090/httpclient.html"

    # Open the URL in the browser
    driver.get(url)

    # Wait for the page to load
    # time.sleep(1)

    # Find the username and password input fields by their names and enter your credentials
    username_input = driver.find_element(By.CSS_SELECTOR, "input[name='username']")
    password_input = driver.find_element(By.CSS_SELECTOR, "input[name='password']")

    username = "harsh.gupta"
    password = "Harsh@7890"

    username_input.send_keys(username)
    password_input.send_keys(password)

    # Submit the form
    login_button = driver.find_element(By.CSS_SELECTOR, "div#loginbutton")
    login_button.click()

    # Wait for the authentication process to complete
    time.sleep(1)

except Exception as e:
    print("An error occurred:", e)

finally:
    # Close the browser
    if 'driver' in locals():
        driver.quit()
EOF
)

# Execute the Python script
echo "Executing Python script..."
python3 -c "$python_script"
