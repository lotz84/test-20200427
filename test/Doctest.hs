import Test.DocTest

main :: IO ()
main = doctest ["docs/"] -- "docs/Algorithm/Map.hs"] -- ["-isrc", "src/Minfree.hs"]
