substitute:
	./gensub

injector:
	xcodebuild -derivedDataPath ./inj -project glowd/glowd.xcodeproj -scheme glowd build

dylib:
	xcodebuild -derivedDataPath ./lib -project glowengine/glowengine.xcodeproj -scheme glowengine build

install:
	@rm -rf /Library/GlowSupport
	@mkdir /Library/GlowSupport
	@cp substitute.dylib /Library/GlowSupport/substitute.dylib
	@cp inj/Build/Products/Debug/glowd /Library/GlowSupport/glow.injector
	@cp lib/Build/Products/Debug/glowengine.bundle/Contents/MacOS/glowengine /Library/GlowSupport/glow.dylib
	@rm -rf substitute
	@rm -rf inj
	@rm -rf lib

load:
	@cp glowinj.plist /Library/LaunchDaemons/com.bedtime.glowinj.startup.plist
	@launchctl load -w /Library/LaunchDaemons/com.bedtime.glowinj.startup.plist
