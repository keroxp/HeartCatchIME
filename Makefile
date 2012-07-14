buildandinstall: xcodebuild install

install: 
	cp -r Build/Products/Debug/HeartCatchIME.app ~/Library/Input\ Methods

xcodebuild:
	xcodebuild -target HeartCatchIME -configuration Debug 

dmg:
	/bin/rm -f HeartCatchIME.dmg 
	hdiutil create -srcfolder Build/Products/Debug/HeartCatchIME.app -volname HeartCatchIME HeartCatchIME.dmg
