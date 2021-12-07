{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE OverloadedStrings #-}

module LearnPersistent where

import Database.Persist.TH
import Database.Persist.Sqlite

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
Country
  name String
  deriving Show
Client
  firstName String
  lastName String
  address String
  age Int
  country CountryId
  deriving Show
|]

exampleConn = runSqlite @IO @() "example.db" $ do
  runMigration migrateAll
  spain <- insert $ Country "Spain"
  _client1 <- insert $ Client "Alejandro" "Serrano" "Home Town, 1" 30 spain
  return ()