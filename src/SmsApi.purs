module SmsApi
       ( SmsApi
       , MessageType
       , authenticateOAuth
       , authenticateSimple
       , authenticateSimpleHashed
       , sendSms
       ) where

import Control.Category ((<<<))
import Data.Unit (Unit)
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Aff.Compat (EffectFnAff, fromEffectFnAff)


----------------------------
-- authentication
----------------------------

-- | Foreign type representing authenticated API
foreign import data SmsApi ∷ Type

foreign import authenticateSimpleImpl ∷ { user ∷ String, password ∷ String } → EffectFnAff SmsApi
foreign import authenticateSimpleHashedImpl ∷ { user ∷ String, md5password ∷ String } → EffectFnAff SmsApi


-- | Requests simple login with Basic auth using user and password.
authenticateSimple ∷ { user ∷ String, password ∷ String } → Aff SmsApi
authenticateSimple = fromEffectFnAff <<< authenticateSimpleImpl


-- | Requests simple login with Basic auth using user and md5-hashed password.
authenticateSimpleHashed ∷ { user ∷ String, md5password ∷ String } → Aff SmsApi
authenticateSimpleHashed = fromEffectFnAff <<< authenticateSimpleHashedImpl

-- | Returns authenticated api using OAuth access token.
foreign import authenticateOAuth ∷ { accessToken ∷ String } → Effect SmsApi

-----------------------------
-- sending simple sms
-----------------------------

foreign import sendSmsImpl ∷ SmsApi → { from ∷ String, to ∷ String, message ∷ String } → EffectFnAff Unit


-- | Data type representing different kinds of messages that Smsapi.pl can send.
-- | Read more at https://www.smsapi.pl/docs/#2-pojedynczy-sms
data MessageType = Eco | TwoWay | Pro { verifiedName ∷ String }


-- | Requests simple sms send.
sendSms ∷ { msgType ∷ MessageType, to ∷ String, message ∷ String } → SmsApi → Aff Unit
sendSms input api = fromEffectFnAff (sendSmsImpl api {from: buildFrom input.msgType, to: input.to, message: input.message })
  where
    buildFrom = case _ of
      Eco → "Eco"
      TwoWay → "2way"
      Pro {verifiedName} → verifiedName
