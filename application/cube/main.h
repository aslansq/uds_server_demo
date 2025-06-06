/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    FDCAN/FDCAN_Classic_Frame_Networking/Inc/main.h
  * @author  MCD Application Team
  * @brief   Header for main.c module
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2024 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MAIN_H
#define __MAIN_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "stm32c0xx_hal.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */
#include "isotp.h"
/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

#define ISOTP_BUFSIZE  (128)
#define MAX_DLC        (8)
typedef struct {
	FDCAN_RxHeaderTypeDef rx_header;
	FDCAN_TxHeaderTypeDef tx_header;
	IsoTpLink isotp_link;
	uint8_t isotp_rx_arr[ISOTP_BUFSIZE];
	uint8_t isotp_tx_arr[ISOTP_BUFSIZE];
	uint8_t rx_data_arr[MAX_DLC];
	uint8_t tx_data_arr[MAX_DLC];
} ecu_handle_s;
/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/


/* USER CODE BEGIN EFP */
extern ecu_handle_s _ecu_handle;
/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/

/* USER CODE BEGIN Private defines */

/* USER CODE END Private defines */

#ifdef __cplusplus
}
#endif

#endif /* __MAIN_H */
