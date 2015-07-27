{-# LANGUAGE CPP, ForeignFunctionInterface #-}

#include "mraa.h"

module System.Hardware.Mraa.Gpio (
  GpioMode
  , GpioDirection
  , GpioHandlePtr
  , mraaGpioStrong
  , mraaGipoPullup
  , mraaGipoPulldown
  , mraaGpioHiz
  , mraaGpioOut
  , mraaGpioIn
  , mraaGpioOutHigh
  , mraaGpioOutLow
  , pinInit
  , pinDirection
  , pinRead
  , pinWrite
) where
import Foreign
import Foreign.C
import System.IO.Unsafe
import Prelude as P
import System.Hardware.Mraa.Types

#include <mraa/gpio.h>

newtype GpioMode = GpioMode { mraaGpioMode :: CInt } deriving (Eq, Show)
#{enum GpioMode, GpioMode
, mraaGpioStrong = MRAA_GPIO_STRONG
, mraaGipoPullup = MRAA_GPIO_PULLUP
, mraaGipoPulldown = MRAA_GPIO_PULLDOWN
, mraaGpioHiz = MRAA_GPIO_HIZ
}

newtype GpioDirection = GpioDirection { mraaGpioDirection :: CInt } deriving (Eq, Show)
#{enum GpioDirection, GpioDirection
, mraaGpioOut = MRAA_GPIO_OUT
, mraaGpioIn = MRAA_GPIO_IN
, mraaGpioOutHigh = MRAA_GPIO_OUT_HIGH
, mraaGpioOutLow = MRAA_GPIO_OUT_LOW
}

data GpioHandle
type GpioHandlePtr = Ptr GpioHandle

foreign import ccall "mraa_gpio_init" c_GpioInit :: Int -> IO GpioHandlePtr
foreign import ccall "mraa_gpio_dir" c_GpioDir :: GpioHandlePtr -> GpioDirection -> IO MraaResult
foreign import ccall "mraa_gpio_read" c_GpioRead :: GpioHandlePtr -> IO MraaResult
foreign import ccall "mraa_gpio_write" c_GpioWrite :: GpioHandlePtr -> CInt -> IO MraaResult

pinInit :: Int -> IO GpioHandlePtr
pinInit = c_GpioInit

pinDirection :: GpioHandlePtr -> GpioDirection -> Maybe GpioHandlePtr
pinDirection handle = isSuccess handle . c_GpioDir handle

pinRead :: GpioHandlePtr -> Maybe GpioHandlePtr
pinRead handle = isSuccess handle $ c_GpioRead handle

pinWrite :: GpioHandlePtr -> Int32 -> Maybe GpioHandlePtr
pinWrite handle value = isSuccess handle $ c_GpioWrite handle (CInt value)

isSuccess :: GpioHandlePtr -> IO MraaResult -> Maybe GpioHandlePtr
isSuccess handle result = unsafePerformIO $ do
    r <- result
    return (judge r)
    where
        judge r
            | r == mraaSuccess = Just handle
            | otherwise = Nothing
