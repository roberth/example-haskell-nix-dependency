module Configuration where
import System.FilePath(FilePath, (</>))

-- | Nothing in non-Nix builds
--
-- Just storePath when built with the appropriate Nix expression.
helloPrefix :: Maybe FilePath
helloPrefix = Nothing

helloPath :: FilePath
helloPath = addBinPrefix helloPrefix "hello"

addBinPrefix :: Maybe FilePath -> FilePath -> FilePath
addBinPrefix (Just prefix) command = prefix </> "bin" </> command
addBinPrefix _             command = command
