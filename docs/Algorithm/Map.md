# This is Test

aaaaaa

**aaaa**bbb

> asfa

```hs
module Algorithm.Map where

-- | aa
-- >>> myMap (+1) [1,2,3]
-- [2,3,4]
myMap :: (a -> b) -> [a] -> [b]
myMap f []     = []
myMap f (x:xs) = f x : myMap f xs
```

__bbb__

<b>aaaa</b>

```haskell
-- | This is not Const
-- >>> myConst 1
-- "test"
myConst :: a -> String
myConst _ = "test"
```

that is it!
