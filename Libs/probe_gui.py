import random
from fileinput import filename

from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from time import sleep


def first_view(site):
    driver = webdriver.Chrome()
    driver.get(site)
    print(driver.title)
    # driver.find_element("body > form > input:nth-child(1)").send_keys("admin")
    # driver.find_element("body > form > button").click()
    # driver.find_element("Login")    # find element
    username = driver.find_element(By.NAME, "user")
    # password = driver.find_element(By.NAME, "password")

    username.send_keys("admin")

    driver.find_element(By.XPATH, "/html/body/form/button").click()

    sleep(10)

    print("------------------------------ FIND TO TRY ------------------------------")

    # driver.find_element(By.XPATH, '//*[@id="hwiButton"]/input').click()
    driver.find_element(By.CSS_SELECTOR, "#hwiButton > input[type=button]")\
        # .click()

    with open('out' + str(random.randint(1, 2078)) + '.txt', 'w') as f:
        print('Filename:', filename, file=f)

    print("------------------------------ FOUND ------------------------------")
