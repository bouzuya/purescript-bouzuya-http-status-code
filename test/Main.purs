module Test.Main
  ( main
  ) where

import Prelude

import Bouzuya.HTTP.StatusCode (ResponseClass(..), StatusCode(..), getResponseClass, isClientError, isInformational, isRedirection, isServerError, isSuccessful, status100, status200, status201, status300, status400, status500)
import Bouzuya.HTTP.StatusCode as StatusCode
import Data.Maybe as Maybe
import Effect (Effect)
import Test.Unit as TestUnit
import Test.Unit.Assert as Assert
import Test.Unit.Main as TestUnitMain

main :: Effect Unit
main = TestUnitMain.runTest do
  TestUnit.suite "StatusCode" do
    TestUnit.test "Eq" do
      Assert.assert "==" $ status200 == status200
      Assert.assert "/=" $ status200 /= status201

    TestUnit.test "Ord" do
      Assert.assert "<" (status200 < status201)

    TestUnit.test "Show" do
      Assert.equal "OK" (show status200)

    TestUnit.test "StatusCode(StatusCode)" do
      Assert.equal (StatusCode 200 "OK") status200

  TestUnit.suite "ResponseClass" do
    TestUnit.test "Eq" do
      Assert.assert "==" $
        (getResponseClass status200) == (getResponseClass status201)
      Assert.assert "/=" $
        (getResponseClass status200) /= (getResponseClass status300)

    TestUnit.test "Show" do
      Assert.equal "1xx (Informational)" (show Informational)

    TestUnit.test "ResponseClass(..)" do
      Assert.equal (Maybe.Just Informational) (getResponseClass status100)
      Assert.equal (Maybe.Just Successful) (getResponseClass status200)
      Assert.equal (Maybe.Just Redirection) (getResponseClass status300)
      Assert.equal (Maybe.Just ClientError) (getResponseClass status400)
      Assert.equal (Maybe.Just ServerError) (getResponseClass status500)

  TestUnit.test "fromInt" do
    Assert.equal (StatusCode.fromInt 200) (Maybe.Just status200)
    Assert.equal (StatusCode.fromInt 600) Maybe.Nothing

  TestUnit.test "getResponseClass" do
    Assert.equal (getResponseClass status200) (Maybe.Just Successful)
    Assert.equal (getResponseClass (StatusCode 600 "Invalid")) Maybe.Nothing

  TestUnit.test "isInformational" do
    Assert.equal (isInformational status100) true
    Assert.equal (isInformational status200) false

  TestUnit.test "isSuccessful" do
    Assert.equal (isSuccessful status200) true
    Assert.equal (isSuccessful status300) false

  TestUnit.test "isRedirection" do
    Assert.equal (isRedirection status300) true
    Assert.equal (isRedirection status400) false

  TestUnit.test "isClientError" do
    Assert.equal (isClientError status400) true
    Assert.equal (isClientError status500) false

  TestUnit.test "isServerError" do
    Assert.equal (isServerError status500) true
    Assert.equal (isServerError status100) false

  TestUnit.test "statusXXX" do
    Assert.equal status100 (StatusCode 100 "Continue")
    Assert.equal status200 (StatusCode 200 "OK")
