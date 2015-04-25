import urllib
import os.path
import math

baseURL = "https://maps.googleapis.com/maps/api/staticmap?key=AIzaSyCa1GKC_r_vjxEbOmebtiiFdLxmxG9A9UU"

zoom = 14

imsize = 1000

#imwidth = 0.0065 #for zoom=17
#imheight = 0.005 #for zoom=17
#imwidth = 0.0133 #for zoom=16
#imheight = 0.01 #for zoom=16
imwidth = 0.05 #for zoom=14
imheight = 0.039725 #for zoom=14

west = -88.932317
#east = -88.832317 #fake
east = -88.252538
south = 40.616319
#south = 41.004988 #fake
north = 41.104988

overlap = 0.9

numrows = int(math.ceil((north - south) / (imheight * overlap)))
numcols = int(math.ceil((east - west) / (imwidth * overlap)))

def getImage(lat, long, filename):
	urlStr = '{}&zoom={}&size={}x{}&maptype=satellite&center={}, {}'.format(baseURL, zoom, imsize, imsize,lat,long)
	urllib.urlretrieve(urlStr, filename)

def main():
	for row in range(0, numrows):
		latitude = north - row * (imheight * overlap)
		for col in range(0, numcols):
			longitude = west + col * (imwidth * overlap)
			filename = 'row{}col{}.png'.format(row, col)
			if not os.path.isfile(filename):
				print '{}: pulling...'.format(filename)
				getImage(latitude, longitude, filename)
			else:
				print '{}: already found, skipping'.format(filename)
			col = col+1
		row = row+1
