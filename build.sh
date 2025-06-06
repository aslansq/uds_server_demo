this_path=$(realpath "$0")
this_dir_path=$(dirname "$this_path")
is_debug_build=0

echoerr() { echo "$@" 1>&2; }

if [ $# -gt 0 ]; then
	is_debug_build=1
fi

ungracefulExit()
{
	echoerr "$@"
	echoerr ERROR!! $0
	exit 1
}

cmb()
{
	rm -rf build
	mkdir -p build
	cd build || ungracefulExit "Failed to change directory to build"
	if [ $is_debug_build -eq 1 ]; then
		cmake .. -DCMAKE_BUILD_TYPE=Debug $@ || ungracefulExit "CMake configuration failed"
	else
		cmake .. $@ || ungracefulExit "CMake configuration failed"
	fi
	make || ungracefulExit "Make failed"
	echo "Build completed successfully."
}

rm -rf $this_dir_path/output
mkdir -p $this_dir_path/output

rm -f $this_dir_path/application/linux_lib $this_dir_path/application/linux_lib

if [ -f "$this_dir_path/seednkey/build32/Debug/seednkey.dll" ]; then
	cp $this_dir_path/seednkey/build32/Debug/seednkey.dll $this_dir_path/output/ || ungracefulExit "Failed to copy seednkey.dll"
fi

cp $this_dir_path/addr.h $this_dir_path/application
cp $this_dir_path/addr.h $this_dir_path/bootloader

cd $this_dir_path/application
ln -sf $this_dir_path/library $this_dir_path/application/linux_lib || ungracefulExit "Failed to create symbolic link to library"
cmb -DUSE_LED_BLUE=1 || ungracefulExit "Failed to build application"
cp $this_dir_path/application/build/uds_application_server.hex $this_dir_path/output/uds_application_server_blue.hex || ungracefulExit "Failed to copy blue application server binary"

cd $this_dir_path/application
ln -sf $this_dir_path/library $this_dir_path/application/linux_lib || ungracefulExit "Failed to create symbolic link to library"
cmb -DUSE_LED_GREEN=1 || ungracefulExit "Failed to build application"
cp $this_dir_path/application/build/uds_application_server.hex $this_dir_path/output/uds_application_server_green.hex || ungracefulExit "Failed to copy green-blue application server binary"

cd $this_dir_path/bootloader
ln -sf $this_dir_path/library $this_dir_path/bootloader/linux_lib || ungracefulExit "Failed to create symbolic link to library"
cmb || ungracefulExit "Failed to build bootloader"
cp $this_dir_path/bootloader/build/uds_bootloader_server.hex $this_dir_path/output/uds_bootloader_server.hex || ungracefulExit "Failed to copy bootloader binary"

echo "Build process completed successfully."