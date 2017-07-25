module Main where

import System.Process(rawSystem)
import System.Exit(exitWith)
import System.IO(hPutStrLn, stderr)
import Configuration

main :: IO ()
main = do
  hPutStrLn stderr $ "Using " ++ show helloPath
  exitStatus <- rawSystem helloPath []
  exitWith exitStatus
