{-# LANGUAGE CPP, ForeignFunctionInterface #-}

#include "mraa.h"

module System.Hardware.Mraa.Types where
import Foreign.C

#include <mraa/types.h>

newtype MraaResult = MraaResult { mraaResult :: CInt } deriving (Eq, Show)
#{enum MraaResult, MraaResult
, mraaSuccess = MRAA_SUCCESS                      /**< Expected response */
, mraaErrorFeatureNotImplemented = MRAA_ERROR_FEATURE_NOT_IMPLEMENTED       /**< Feature TODO */
, mraaErrorFeatureNotSupported = MRAA_ERROR_FEATURE_NOT_SUPPORTED         /**< Feature not supported by HW */
, mraaErrorInvalidVerbosityLevel = MRAA_ERROR_INVALID_VERBOSITY_LEVEL       /**< Verbosity level wrong */
, mraaErrorInvalidParameter = MRAA_ERROR_INVALID_PARAMETER             /**< Parameter invalid */
, mraaErrorInvalidHandle = MRAA_ERROR_INVALID_HANDLE                /**< Handle invalid */
, mraaErrorNoResources = MRAA_ERROR_NO_RESOURCES                  /**< No resource of that type avail */
, mraaErrorInvalidResource = MRAA_ERROR_INVALID_RESOURCE              /**< Resource invalid */
, mraaErrorInvalidQueueType = MRAA_ERROR_INVALID_QUEUE_TYPE            /**< Queue type incorrect */
, mraaErrorNoDataAvailable = MRAA_ERROR_NO_DATA_AVAILABLE             /**< No data available */
, mraaErrorInvalidPlatform = MRAA_ERROR_INVALID_PLATFORM              /**< Platform not recognised */
, mraaErrorPlatformNotInitialised = MRAA_ERROR_PLATFORM_NOT_INITIALISED      /**< Board information not initialised */
, mraaErrorPlatformAlreadyInitialised = MRAA_ERROR_PLATFORM_ALREADY_INITIALISED  /**< Board is already initialised */

, mraaErrorUnspecified = MRAA_ERROR_UNSPECIFIED                  /**< Unknown Error */
}
