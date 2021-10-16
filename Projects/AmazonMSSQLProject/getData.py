## Ahmet Furkan DEMIR ##

from selenium import webdriver
import time 
from selenium.webdriver.common.keys import Keys
import os
import pymssql

con = pymssql.connect(server="localhost", user="SA", password="demiraiAI1881", database="DB_AmazonProducts")
cur = con.cursor()

path = os.getcwd()

browser = webdriver.Chrome("{}/ChromeDriver/chromedriver".format(path))
browser2 = webdriver.Chrome("{}/ChromeDriver/chromedriver".format(path))
browser.maximize_window()
browser.get("https://www.amazon.com.tr/Elektronik-Amazon-com-tr/s?rh=n%3A12466496031%2Cp_6%3AA1UNQM1SR2CHM")
time.sleep(3)

count = 0
page = 1
image_number = 1

def writeDatabase(names, images, urls, prices, count):

    for i in range(len(names)):

        ts = None

        try:

            cur.executemany("INSERT INTO TB_AmazonProducts VALUES (%s, %s, %s, %d)",[(names[i], images[i], urls[i], prices[i])])
            con.commit()

        except:

            ts = False

        if ts == None:

            print("Sucsses : ",count)
            count+=1

        else:

            print("DB Error XXX")


    return count


while True:

    try:

        imagesLink = browser.find_elements_by_css_selector(".s-image")
        elementsLink = browser.find_elements_by_css_selector(".a-size-base-plus")
        pricesLink = browser.find_elements_by_css_selector(".a-price-whole")
        urlsLink = browser.find_elements_by_css_selector(".s-no-outline")

        names = []
        images = []
        prices = []
        urls = []

        for i in elementsLink:

            names.append(i.text)

        for i in imagesLink:

            site = i.get_attribute("src")
            browser2.get(site)
            image = browser2.find_element_by_xpath("/html/body/img")

            images.append(image.screenshot_as_png)
            image_number+=1

        for i in pricesLink:

            prices.append(i.text)

        for i in urlsLink:

            urls.append(i.get_attribute("href"))

        count = writeDatabase(names, images, urls, prices, count)

        page = page + 1
        url = "https://www.amazon.com.tr/Elektronik-Amazon-com-tr/s?i=electronics&rh=n%3A12466496031%2Cp_6%3AA1UNQM1SR2CHM&page={}&qid=1633872486&ref=sr_pg_{}".format(page,page)
        browser.get(url)

    except:

        browser = webdriver.Chrome("{}/ChromeDriver/chromedriver".format(path))
        browser2 = webdriver.Chrome("{}/ChromeDriver/chromedriver".format(path))
        browser.maximize_window()
        browser.get("https://www.amazon.com.tr/Elektronik-Amazon-com-tr/s?rh=n%3A12466496031%2Cp_6%3AA1UNQM1SR2CHM")
        print("selenium ERROR XX")
        time.sleep(3)


con.close()
browser.close()

