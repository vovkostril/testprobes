import random
from fileinput import filename
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
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

    # sleep(10)

    print("------------------------------ FIND TO TRY ------------------------------")
    main_frame = "main"
    WebDriverWait(driver, 20). \
        until(EC.frame_to_be_available_and_switch_to_it((By.NAME, main_frame)))
    driver.implicitly_wait(20)
    print("Find button?")
    driver.find_element(By.CSS_SELECTOR, "#hwiButton > input[type=button]").click()

    # driver.find_element(By.XPATH, '//*[@id="hwiButton"]/input').click()
    # driver.find_element(By.CSS_SELECTOR, "#hwiButton > input[type=button]")\
    # driver.implicitly_wait(20)
    # WebDriverWait(driver, 30).until(
    #     EC.element_to_be_clickable((By.CSS_SELECTOR, "body > toprow > ul > li:nth-child(3) > div > input[type=image]")))\
    #     .click()
    # driver.find_element(By.CSS_SELECTOR, "body > toprow > ul > li:nth-child(3) > div > input[type=image]")
    # .click()

    # with open('out' + str(random.randint(1, 2078)) + '.txt', 'w') as f:
    #     print('Filename:', filename, file=f)

    print("------------------------------ FOUND ------------------------------")
