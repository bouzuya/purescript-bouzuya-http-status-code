module Test.Main where

import Bouzuya.HTTP.StatusCode (ResponseClass(..), StatusCode(..), getResponseClass, isClientError, isInformational, isRedirection, isServerError, isSuccessful, status100, status200, status201, status300, status400, status500)
import Bouzuya.HTTP.StatusCode as StatusCode
import Effect (Effect)
import Data.Maybe (Maybe(..))
import Data.Show (show)
import Data.Unit (Unit)
import Prelude (discard, ($), (/=), (==))
import Test.Unit (suite, test)
import Test.Unit.Assert as Assert
import Test.Unit.Main (runTest)

main :: Effect Unit
main = runTest do
  suite "StatusCode" do
    test "Eq" do
      Assert.assert "==" $ status200 == status200
      Assert.assert "/=" $ status200 /= status201

    test "Show" do
      Assert.equal "OK" (show status200)

    test "StatusCode(StatusCode)" do
      Assert.equal (StatusCode 200 "OK") status200

  suite "ResponseClass" do
    test "Eq" do
      Assert.assert "==" $
        (getResponseClass status200) == (getResponseClass status201)
      Assert.assert "/=" $
        (getResponseClass status200) /= (getResponseClass status300)

    test "Show" do
      Assert.equal "1xx (Informational)" (show Informational)

    test "ResponseClass(..)" do
      Assert.equal (Just Informational) (getResponseClass status100)
      Assert.equal (Just Successful) (getResponseClass status200)
      Assert.equal (Just Redirection) (getResponseClass status300)
      Assert.equal (Just ClientError) (getResponseClass status400)
      Assert.equal (Just ServerError) (getResponseClass status500)

  test "fromInt" do
    Assert.equal (StatusCode.fromInt 200) (Just status200)
    Assert.equal (StatusCode.fromInt 600) Nothing

  test "getResponseClass" do
    Assert.equal (getResponseClass status200) (Just Successful)
    Assert.equal (getResponseClass (StatusCode 600 "Invalid")) Nothing

  test "isInformational" do
    Assert.equal (isInformational status100) true
    Assert.equal (isInformational status200) false

  test "isSuccessful" do
    Assert.equal (isSuccessful status200) true
    Assert.equal (isSuccessful status300) false

  test "isRedirection" do
    Assert.equal (isRedirection status300) true
    Assert.equal (isRedirection status400) false

  test "isClientError" do
    Assert.equal (isClientError status400) true
    Assert.equal (isClientError status500) false

  test "isServerError" do
    Assert.equal (isServerError status500) true
    Assert.equal (isServerError status100) false

  test "statusXXX" do
    Assert.equal status100 (StatusCode 100 "Continue")
    Assert.equal status200 (StatusCode 200 "OK")
