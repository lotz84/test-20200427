{-# LANGUAGE OverloadedStrings #-}

module Main where

import Control.Monad (forM, forM_, when)
import Data.Maybe (catMaybes)

import CMarkGFM
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.IO as T
import System.Directory
import System.FilePath


-- | サブディレクトリを再帰的に操作してファイルのみを列挙する
listDirectoryRecursively :: FilePath -> IO [FilePath]
listDirectoryRecursively prepath = do
  ps <- listDirectory prepath
  fmap concat . forM ps $ \path -> do
    let fullpath = prepath </> path
    isDir <- doesDirectoryExist fullpath
    if isDir
       then listDirectoryRecursively fullpath
       else pure [fullpath]


-- | NodeTypeを変換しながらNodeを再帰的に操作する関数
mapNode :: (NodeType -> a) -> Node -> [a]
mapNode f (Node _ nt []) = [f nt]
mapNode f (Node _ nt ns) = f nt : concatMap (mapNode f) ns


-- | Markdownテキストのhs/haskellコードブロックの中身だけ結合して返す
-- もし該当するコードブロックがなければNothingを返す
md2hs :: Text -> Maybe Text
md2hs = aggregate . catMaybes . mapNode getHsText . commonmarkToNode [] []
  where
    getHsText (CODE_BLOCK "hs"      code) = Just code
    getHsText (CODE_BLOCK "haskell" code) = Just code
    getHsText _                           = Nothing
    aggregate [] = Nothing
    aggregate ts = Just (T.unlines ts)


main :: IO ()
main = do
  ps <- listDirectoryRecursively "docs"
  forM_ ps $ \path ->
    let (filename, ext) = splitExtension path
     in when (ext == ".md") $ do
          code <- md2hs <$> T.readFile path
          case code of
            Nothing   -> pure ()
            Just code -> T.writeFile (filename ++ ".hs") code
