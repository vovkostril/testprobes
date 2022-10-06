import requests

from bs4 import BeautifulSoup


def relax(site):
    r = requests.get(site)
    print(r.status_code)
