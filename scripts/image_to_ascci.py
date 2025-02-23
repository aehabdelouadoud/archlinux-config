import sys
from PIL import Image

# More detailed set of ASCII characters
ASCII_CHARS = ['@', '#', '8', '&', '%', '$', '*', '+', '=', '-', ':', '.', ' ']

# Function to resize the image to fit the output width
def resize_image(image, new_width=100):
    width, height = image.size
    ratio = height / width
    new_height = int(new_width * ratio)
    resized_image = image.resize((new_width, new_height))
    return resized_image

# Function to convert the image to grayscale
def grayscale_image(image):
    return image.convert("L")

# Function to map each pixel to an ASCII character
def pixel_to_ascii(image):
    pixels = image.getdata()
    ascii_str = ''
    for pixel in pixels:
        ascii_str += ASCII_CHARS[pixel // 25]  # Dividing pixel value by 25 to match ASCII range
    return ascii_str

# Function to convert image to ASCII art
def image_to_ascii(image_path, new_width=100):
    try:
        image = Image.open(image_path)
    except Exception as e:
        print("Error opening image:", e)
        return

    # Resize and convert to grayscale
    image = resize_image(image, new_width)
    image = grayscale_image(image)

    # Convert to ASCII
    ascii_str = pixel_to_ascii(image)

    # Get the width of the image for formatting
    img_width = image.width
    ascii_str_len = len(ascii_str)
    ascii_img = ""

    # Split the ASCII string into multiple lines based on the image width
    for i in range(0, ascii_str_len, img_width):
        ascii_img += ascii_str[i:i + img_width] + "\n"

    return ascii_img

# Function to save the ASCII art to a text file
def save_ascii_art(ascii_art, output_file="ascii_art.txt"):
    with open(output_file, "w") as f:
        f.write(ascii_art)

# Main function
def main():
    if len(sys.argv) != 2:
        print("Usage: python image_to_ascii.py <path_to_image>")
        return

    image_path = sys.argv[1]
    ascii_art = image_to_ascii(image_path, new_width=150)  # Adjust width as necessary

    if ascii_art:
        print(ascii_art)  # Print to the console
        save_ascii_art(ascii_art)  # Save to a text file

if __name__ == "__main__":
    main()

