# Duolingo — pixel source

Founder-selected reference. Pull real screens on the Mac (Mobbin is login-gated
from the cloud):

```
cd tools/mobbin-pull
node pull.mjs duolingo "https://mobbin.com/apps/duolingo-ios-688f6e68-12be-4b63-80b7-8377c8482911/2585ff78-3ef5-4b78-9923-f0ee512dbb99/screens"
```

Screens land here. Then tell Claude they're here and `../patterns.md` gets
refined from the real pixels (color values, type scale, spacing).
