CEFSIMPLE_APP = cef3simple
HELPER_APP = cef3simple\ Helper
HELPER_EXECUTABLE_PATH = $(HELPER_APP).app/Contents/MacOS/$(HELPER_APP)
CEFSIMPLE_EXECUTABLE_PATH = $(CEFSIMPLE_APP).app/Contents/MacOS/$(CEFSIMPLE_APP)

All: cef3simple_APP

Helper_APP:
	mkdir -p $(HELPER_APP).app/Contents
	mkdir -p $(HELPER_APP).app/Contents/MacOS
	mkdir -p $(HELPER_APP).app/Contents/Resources
	
	sed -e "s/\$${PRODUCT_NAME}/$(HELPER_APP)/"  \
	-e "s/\$${EXECUTABLE_NAME}/$(HELPER_APP)/"   mac/helper-Info.plist >$(HELPER_APP).app/Contents/Info.plist
	/bin/echo "APPL????" >$(HELPER_APP).app/Contents/PkgInfo
	
	g++ -arch i386 -o process_helper_mac.o -c -I../cef process_helper_mac.cpp
	
	g++ -arch i386 -o $(HELPER_EXECUTABLE_PATH) -L../cef/xcodebuild/Debug -lcef_dll_wrapper -F../cef/Debug -framework Chromium\ Embedded\ Framework  -stdlib=libstdc++ process_helper_mac.o
	
	install_name_tool -change "@executable_path/Chromium Embedded Framework" "@executable_path/../../../../Frameworks/Chromium Embedded Framework.framework/Chromium Embedded Framework" $(shell pwd)/$(HELPER_EXECUTABLE_PATH)
	
	#../cef/tools/change_mach_o_flags_from_xcode.sh $(shell pwd)/$(HELPER_EXECUTABLE_PATH)

cef3simple_APP: Helper_APP
	g++ -arch i386 -stdlib=libstdc++ -c -I../cef simple_handler_mac.mm
	g++ -arch i386 -stdlib=libstdc++ -c -I../cef simple_app.cpp
	g++ -arch i386 -stdlib=libstdc++ -c -I../cef cefsimple_mac.mm
	g++ -arch i386 -stdlib=libstdc++ -c -I../cef simple_handler.cpp
	
	mkdir -p $(CEFSIMPLE_APP).app/Contents
	mkdir -p $(CEFSIMPLE_APP).app/Contents/MacOS
	mkdir -p $(CEFSIMPLE_APP).app/Contents/Frameworks
	mkdir -p $(CEFSIMPLE_APP).app/Contents/Resources
	
	sed -e "s/\$${PRODUCT_NAME}/$(CEFSIMPLE_APP)/"  \
	-e "s/\$${EXECUTABLE_NAME}/$(CEFSIMPLE_APP)/"   mac/Info.plist >$(CEFSIMPLE_APP).app/Contents/Info.plist
	/bin/echo "APPL????" >$(CEFSIMPLE_APP).app/Contents/PkgInfo
	
	cp -Rf ../cef/Debug/Chromium\ Embedded\ Framework.framework $(CEFSIMPLE_APP).app/Contents/Frameworks
	cp -Rf $(HELPER_APP).app $(CEFSIMPLE_APP).app/Contents/Frameworks
	
	g++ -arch i386 simple_handler_mac.o simple_app.o cefsimple_mac.o simple_handler.o -stdlib=libstdc++ -L../cef/xcodebuild/Debug -lcef_dll_wrapper -F../cef/Debug -framework Chromium\ Embedded\ framework -framework Cocoa -o $(CEFSIMPLE_EXECUTABLE_PATH)
	
	install_name_tool -change "@executable_path/Chromium Embedded Framework" "@executable_path/../Frameworks/Chromium Embedded Framework.framework/Chromium Embedded Framework" "$(shell pwd)/$(CEFSIMPLE_EXECUTABLE_PATH)"
	
	../tools/make_more_helpers.sh "$(shell pwd)/$(CEFSIMPLE_APP).app/Contents/Frameworks" cef3simple 
	#../cef/tools/change_mach_o_flags_from_xcode.sh $(shell pwd)/$(CEFSIMPLE_EXECUTABLE_PATH)

clean:
	rm -f ./*.o
	rm -rf *.app
