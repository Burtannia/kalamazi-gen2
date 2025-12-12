module Data.Guide where

data GuideAggregate = GuideAggregate
  { 
  }

class Aggregate event command err where
  runCommand :: command -> Either err [event] 
  
