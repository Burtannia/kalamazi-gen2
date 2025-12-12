module Event where

import Data.Time (UTCTime)
import Data.Text (Text)
import qualified Data.Aeson as Aeson
import Data.UUID (UUID)

newtype EventId = EventId { getUuid :: UUID }
newtype AggregateId = AggregateId { getUuid :: UUID }

-- TODO: Do we have a sequence ID or just order
-- by timestamp.
-- Or use the ordered UUID thing?
data Event = Event
  { id :: EventId
  , aggregateId :: AggregateId
  , timestamp :: UTCTime
  , author :: Text
  , body :: Aeson.Object
  }
