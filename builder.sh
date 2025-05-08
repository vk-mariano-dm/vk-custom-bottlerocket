cd /bottlerocket
ls -la .

cargo make -e BUILDSYS_VARIANT=aws-k8s-1.32
cargo test --verbose
cp *.img /dist

