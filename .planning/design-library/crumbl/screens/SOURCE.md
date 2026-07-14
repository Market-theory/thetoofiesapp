# Crumbl — pixel source

Founder-selected reference. Pull real screens on the Mac (Mobbin is login-gated
from the cloud):

```
cd tools/mobbin-pull
node pull.mjs crumbl "https://mobbin.com/apps/crumbl-cookies-ios-f28817af-246a-411e-b42e-504e9478f8ed/c3d54962-ed7c-474d-bef8-8e129bbab34c/screens"
```

Screens land here. Then tell Claude they're here and `../patterns.md` gets
refined from the real pixels (color values, type scale, spacing).
