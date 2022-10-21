import os
import argparse
import uuid

script_path = os.path.dirname(os.path.realpath(__file__))
    
def rate_images(images_dir="", output_dir="", image_type="png"):
    images_dir = os.path.realpath(images_dir)
    basename_images = os.path.basename(images_dir)
    unique_id = uuid.uuid1()
    predictions_files = [
        f"predictions_{unique_id}_aesthetic.json",
        f"predictions_{unique_id}_technical.json"
    ]
    weights_file = [
        os.path.join(script_path, "models\MobileNet\weights_mobilenet_aesthetic_0.07.hdf5"),
        os.path.join(script_path, "models\MobileNet\weights_mobilenet_aesthetic_0.07.hdf5")
    ]
    output_dir = os.path.realpath(output_dir)
    for idx, file in enumerate(predictions_files):
        predictions_file = os.path.join(output_dir, file)
        f = open(predictions_file, "w", encoding="utf8")
        f.close()
        entrypoint = "entrypoints/entrypoint.predict.cpu.sh"
        os.system(f"docker run --rm --entrypoint {entrypoint} -v {images_dir}:/src/{basename_images} -v {predictions_file}:/src/{file} -v {weights_file[idx]}:/src/weights.hdf5 nima-cpu MobileNet /src/weights.hdf5 /src/{basename_images} /src/{file} {image_type}")

parser = argparse.ArgumentParser()
parser.add_argument("-i", "--images-dir", type=str, default="", help="directory of images", required=True)
parser.add_argument("-o", "--output-dir", type=str, default="", help="where to output the ratings", required=True)
parser.add_argument("-t", "--image-type", type=str, default="png", help="image file type", required=False)

if __name__ == "__main__":
    args = parser.parse_args()
    rate_images(**args.__dict__)