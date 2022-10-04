from selenium import webdriver
from selenium.webdriver.common.keys import Keys


def first_view(site):
    driver = webdriver.Chrome()
    driver.get(site)
    print(driver.title)
    # driver.find_element("body > form > input:nth-child(1)").send_keys("admin")
    # driver.find_element("body > form > button").click()
    driver.find_element("Login")    # find element
