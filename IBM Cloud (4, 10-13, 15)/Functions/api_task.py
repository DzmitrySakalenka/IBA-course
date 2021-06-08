import sys
import requests

def main(dict):
	currency = dict['currency'] if ('currency' in dict) and (dict['currency'] in ['USD', 'EUR', 'RUB']) else 'USD'
	url = f'https://www.nbrb.by/api/exrates/rates/{currency}?parammode=2'
	#resp = requests.get(url).json()
	#print({'Cur_OfficialRate': resp['Cur_OfficialRate']})
	return requests.get(url).json()