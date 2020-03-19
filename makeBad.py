
from PIL import Image
import sys

name = sys.argv[1]
i = int(sys.argv[2])

jpg = Image.open(f'./prints/jpegs/{name}-{i}.jpg')
jpg.save(f'./prints/jpegs/{name}-{i}.jpg',"JPEG", quality=5)
jpg.close()
