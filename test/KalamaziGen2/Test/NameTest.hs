module KalamaziGen2.Test.NameTest where

import Hedgehog (TestT, (===))

import KalamaziGen2 (name)

test_name :: TestT IO ()
test_name = "kalamazi-gen2" === name
