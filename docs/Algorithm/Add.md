# This is Markdown Test

```hs
module Algorithm.Add where

import Data.List.Extra (upper)
```

```hs
-- | add desc
-- >>> add 1 2
-- 3
add :: Int -> Int -> Int
add = (+)
```

List.Extra test

```hs
-- | u
-- >>> a "test"
-- "TEST"
a :: String -> String
a = upper
```
