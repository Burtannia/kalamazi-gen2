module Id where

import Data.UUID (UUID)

newtype Id (x :: k) = Id { uuid :: UUID }
  deriving stock (Show, Eq)
