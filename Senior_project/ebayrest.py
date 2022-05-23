from flask import Flask, request
from bs4 import BeautifulSoup
import requests


app = Flask(__name__)

if __name__=='__main__':
    app.run()
    
    
@app.route('/products', methods=['GET'])
def helloWorld():

   # productName= request.args.get('q')  

    htmlSourceCode= getHtmlSourceCode('watches')

    soup= BeautifulSoup(htmlSourceCode, 'html.parser')

    a_tags= soup.find_all('a', {'class':'s-item__link'})
        

    urls= list()

    for a in a_tags:  #soup.find_all('a', {'class':'s-item__link'}):
        urls.append(a['href'])

    #products= list()

    #for url in urls:
     #   product= dict()
      #  page_soup= BeautifulSoup(request.get(url).text, 'html.parser')

      #  name= page_soup.find('h3', {'class':'s-item__title'})
      #  product['name']= name.text

       # price= page_soup.find('span', {'class':'s-item__price'})
        #product['price']= price.text

        #rating= page_soup.find('span', {'class':'clipped'})

        #if rating is None:
         #   product['rating']= '0 ratings'
        #else:
         #    product['rating']= rating.text

        #products.append(product)'''


    return {'urls': urls}

    
def getHtmlSourceCode(productName):

    headers = {
      'authority': 'www.ebay.com',
       'cache-control': 'max-age=0',
       'upgrade-insecure-requests': '1',
       'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.129 Safari/537.36',
       'accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
       'sec-fetch-site': 'same-origin',
       'sec-fetch-mode': 'navigate',
       'sec-fetch-user': '?1',
       'sec-fetch-dest': 'document',
       'referer': 'https://www.ebay.com/sch/i.html?_from=R40^&_trksid=p2380057.m570.l1313.TR0.TRC1.A0.H0.Xbooks.TRS5^&_nkw=books^&_sacat=0',
       'accept-language': 'en-US,en;q=0.9',
       'cookie': 'aam_uuid=40909738087416633221740741948221687199; cid=xcxc0uqfVSymn7No^%^231532830955; DG_SID=24.115.231.18:jDxtn0zK5hezSaQ4FFj/LInbfhoVh7+QyLvkDLTdFtI; AMCVS_A71B5B5B54F607AB0A4C98A2^%^40AdobeOrg=1; cssg=ca0fe9ea16e0a128eca4f189edae708c; PdsCGuid=fed1233b1710ac3c15afd2ccffffffff; PdsSession=fed1233b1710ac3c15afd2ccffffffff; JSESSIONID=5E02AD9D3B11652EADEDF6306EDA8450; _ga=GA1.2.631305832.1589383049; _gid=GA1.2.51209048.1589383049; ak_bmsc=19F43E145B01079C8EF2B620CC049D32ACE8062CA8510000F8FEBC5E9C23520C~plvWkU5zOgKlcu4pVTsoX+wzxUKNfedVV3aWa2JF5KLfCi4Rtfi98AJv33agpjoG3LJNiyy8AU80W78uVo1dRlOHteJeZ1L+7dTak08mbrxL61QyvSd56gABPTSaeTOS9pPHrxsYe6tIrWEoiVsIBnbF4ND7U6oq61NuL4lQWYZRCexLmd8Gl/7uBiyFeuMsBHbNjLzu7RMcXu0D7NnLu7RP88vYmIwPDO0mZ+kgBogAw=; AMCV_A71B5B5B54F607AB0A4C98A2^%^40AdobeOrg=-1303530583^%^7CMCIDTS^%^7C18397^%^7CMCMID^%^7C40923140056530933511739662084139367458^%^7CMCAAMLH-1590049149^%^7C7^%^7CMCAAMB-1590049149^%^7CRKhpRz8krg2tLO6pguXWp5olkAcUniQYPHaMWWgdJ3xzPWQmdj0y^%^7CMCCIDH^%^7C850960099^%^7CMCOPTOUT-1589451549s^%^7CNONE^%^7CvVersion^%^7C3.3.0; npii=btguid/ca0fe9ea16e0a128eca4f189edae708c627f660f^^cguid/ca0fe9ed16e0a128eca4f189edae708a627f660f^^; bm_sv=481EC2BCFEDCA847EA70712EA70B29CF~jOSs0gN3+0X8Eu/6Gf8PVFfEupUmvTN0dBMkli/vE7OTjFnwm92hwL7mJCgKfogqxWi/OFZ2A9IIntOMPFKEe88OK/OVjXA0QTiz+jLi1Iq43UF692mtrZKd/PBLcTF309VlzPKzdaVCeIR9DjLCSg==; ebay=^%^5Esbf^%^3D^%^2340000000000010040000000^%^5Ecv^%^3D15555^%^5Ejs^%^3D1^%^5E; ns1=BAQAAAXHxlODRAAaAAKUADWCeMpoxNTQ2MjM2ODQ0LzA7ANgATGCeMppjNzJ8NjAxXjE1NzYwODM4NDkwNDNeXjFeM3wyfDV8NHw3fDExXjFeMl40XjNeMTJeMTJeMl4xXjFeMF4xXjBeMV42NDQyNDU5MDc1GzE9X1CMT5P2dkPio71+AIpXL6U*; dp1=bkms/in627f661a^^u1f/Brayan627f661a^^u1p/YnJheWFvcnRpNjM*627f661a^^bl/US627f661a^^expt/00015792972694415f12c3b5^^pbf/^%^238000000040c400e00000818802000000609e329a^^; s=CgAD4ACBevlCaY2EwZmU5ZWExNmUwYTEyOGVjYTRmMTg5ZWRhZTcwOGOnSIhy; nonsession=BAQAAAXHxlODRAAaAAJ0ACGCeMpowMDAwMDAwMQFkAAZif2YaIzAwMDhhAAgAHF7kjBoxNTg5MjUzMTgyeDE4NDI4NTg2MzcxM3gweDJZADMADmCeMpoxODM0Ni0wODkyLFVTQQDLAAJevQYiMTEAQAALYJ4ymmJyYXlhb3J0aTYzABAAC2CeMppicmF5YW9ydGk2MwDKACBif2YaY2EwZmU5ZWExNmUwYTEyOGVjYTRmMTg5ZWRhZTcwOGMABAALYANddWJyYXlhb3J0aTYzAJwAOGCeMppuWStzSFoyUHJCbWRqNndWblkrc0VaMlByQTJkajZBQmxJU2pDNWFLcFFpZGo2eDluWStzZVE9PaFf6Q+m5yyxVFrkI7jvkaCQKLip',
    }

    params = (
       ('_from', 'R40^'),
       ('_trksid', 'p2334524.m570.l1313.TR12.TRC2.A0.H0.TRS0^'),
       ('_nkw', productName),
       ('_sacat', '0'),
    )

    response = requests.get('https://www.ebay.com/sch/i.html', headers=headers, params=params)

    return response.text

