Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967624AbeCAKy1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 05:54:27 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43681 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S966977AbeCAKyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 05:54:23 -0500
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <alexandre.torgue@st.com>,
        <lee.jones@linaro.org>
CC: <mcoquelin.stm32@gmail.com>, Patrice Chotard <patrice.chotard@st.com>
Subject: [PATCH v2 5/6] dt-bindings: mfd: Add STM32F7 SDMMC2 rcc entry
Date: Thu, 1 Mar 2018 11:53:42 +0100
Message-ID: <1519901623-23216-6-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519901623-23216-1-git-send-email-patrice.chotard@st.com>
References: <1519901623-23216-1-git-send-email-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

STM32F769 SoC provides 2 SDMMC instances, add missing
RCC SDMMC2 entry for it.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 include/dt-bindings/mfd/stm32f7-rcc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/mfd/stm32f7-rcc.h b/include/dt-bindings/mfd/stm32f7-rcc.h
index 8b7b7197ffd7..a90f3613c584 100644
--- a/include/dt-bindings/mfd/stm32f7-rcc.h
+++ b/include/dt-bindings/mfd/stm32f7-rcc.h
@@ -91,6 +91,7 @@
 #define STM32F7_RCC_APB2_TIM8		1
 #define STM32F7_RCC_APB2_USART1		4
 #define STM32F7_RCC_APB2_USART6		5
+#define STM32F7_RCC_APB2_SDMMC2		7
 #define STM32F7_RCC_APB2_ADC1		8
 #define STM32F7_RCC_APB2_ADC2		9
 #define STM32F7_RCC_APB2_ADC3		10
-- 
1.9.1
