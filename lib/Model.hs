module Model where

data Guide = Guide
    { metadata :: GuideMetadata
    , sections :: [Section]
    }

data GuideMetadata = GuideMetadata
    { title :: Text
    , created :: UTCTime
    , edited :: UTCTime
    , description :: Maybe Text
    , video :: Maybe URI
    , tags :: [Text]
    }
-- TODO: We might also want to give special treatment to the video
-- guide associated with the given class or raid.
-- Maybe highlight that as a special part of the dropdown
-- menu using Tailwind "Header".

-- TODO: What's the difference between a Section
-- and a higher-order component?
--
-- Answer: Sections have a title and description,
-- higher-order components, such as a grid, do not.
-- With that said, a Grid will have metadata such
-- as dimensions, so perhaps this is no different
-- from a Section having a title/description?
data Section = Section
    { title :: Text
    , description :: Maybe Text
    , components :: [Component]
    }

-- TODO: Perhaps these should be more
-- domain specific and generic things
-- like `TextSwitch` should be another
-- layer which then builds into more
-- domain specific components like
-- "Consumables". The question then
-- is, what do we do between expensions
-- if the type of a "Consumable" component
-- changes?
-- Perhaps we commit to wiping guides between
-- expansions?
data Component
    = TextSwitch TextSwitchDetails
    | ImageSwitch ImageSwitchDetails
    | Image ImageDetails
    | Paragraph ParagraphDetails -- TODO: Within a paragraph, we will want to support linking item names etc. to Wowhead so that the tooltips will work.
    -- Is there an API from Wowhead that we can use to create a flow such as:
    -- 1) Click "add wowhead link"
    -- 2) Type to search wowhead entity
    -- 3) Click the result to generate a linked piece of text
    | YoutubeEmbed YoutubeEmbedDetails
    | TwitchEmbed TwitchEmbedDetails
    | AbilityRotation AbilityRotationDetails
    | TierSet TierSetDetails -- do we need this???
    | Gear GearDetails -- what does this do???
    | StatWeights StatWeightsDetails -- auto-include the caveat of simming
    | Consumables ConsumablesDetails -- is this just an ImageSwitch? What about enchants/gems?
    | Profile ProfileDetails

-----------------------
-- Image sources
-----------------------
-- Uploaded e.g. a screenshot
-- these will most likely be placed in Image components
-- as a standalone item on the page.
--
-- Icons fetched from Wowhead or Blizzard API
-- we will then "download" them behind the scenes.
-- Likely used for image toggles such as trinkets.

-- TODO: How do we handle rows/columns/grids?
-- Perhaps more complex layouts like that should
-- just be hard-coded into the guide layout?

-- This is a good example of a domain-level component
-- vs a low-level component. A TextSwitch is a low-level
-- concept and could be used for many domain-level components,
-- such as Consumables or StatWeights, but each of these may
-- require different bodies. A TextSwitch will most frequently
-- have a Paragraph body but there's nothing preventing it
-- from havint something else such as a an image or even
-- another switch component.
data TextSwitchDetails = TextSwitchDetails
    { items :: [(Text, _)]
    }

-- TODO: What is an Image?
data ImageSwitchDetails = ImageSwitchDetails
    { items :: [(Image, _)]
    }

-- TODO: Do we need to discriminate between
-- Wowhead items that have thumbnails and those
-- that don't?
--
-- Wowhead's guide reads as if every linkable item
-- receives a tooltip so we probably shouldn't worry
-- about it.
--
-- Every item has a tooltip, but not everything
-- has an icon. Wowhead links work by default with
-- anchor tags. Not sure what happens with an image.
--
-- Wowhead script replaces the body of the anchor
-- tag with the name of the linked entity, be it
-- a spell or a quest. This poses an issue for
-- adding tooltips to the images in an ImageSwitch.
--
-- Can we get Kala/Neri to get WowHead to provide
-- an option where the tooltip doesn't override
-- the child elements of the anchor tag?
--
-- Worst case scenario we can hack it by removing
-- the child added by wowhead, removing the background
-- image and re-adding the image we want.
--  - Remove the class
--  - Remove the span child
--  - Remove the background image
--  - Re-add the img child
data WowheadItem = _

-- TODO: How do we want to handle the variants of each spec e.g. Hellcaller vs Diabolist?
