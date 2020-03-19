
from PIL import Image
import sys

name = sys.argv[1]
type = sys.argv[3]
folders = {
    'bmp': 'bitmaps',
    'png': 'pngs',
    'jpg': 'jpegs'
}
i = int(sys.argv[2])

og = Image.open(f'./prints/{folders[type]}/{name}-{i}.{type}')
og.save(f'./prints/jpegs/{name}-{i}.jpg',"JPEG", quality=15)
og.close()
jpg = Image.open(f'./prints/jpegs/{name}-{i}.jpg')
jpg.save(f'./prints/{folders[type]}/{name}-{i+1}.{type}')
jpg.close()

