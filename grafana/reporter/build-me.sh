set -e

echo "building image"
docker build . -t reporter:local

echo;
echo "saving to image.tar"
docker save reporter > image.tar

echo;
echo "putting into microk8s"
microk8s ctr image import image.tar
