Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754240AbeE1JJW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:09:22 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:42108 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754159AbeE1JJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:09:18 -0400
From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Stefan Agner <stefan@agner.ch>, Tony Lindgren <tony@atomide.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH v1] ARM: multi_v7_defconfig: enable STM32 DMAv2, DMAMUX and MDMA
Date: Mon, 28 May 2018 11:08:33 +0200
Message-ID: <1527498513-19167-1-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-28_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables drivers for STM32:
 - DMAv2
 - DMMAUX
 - MDMA

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
     v1:
        * Initial
---
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 89167cd..9f62957 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -887,6 +887,9 @@ CONFIG_QCOM_BAM_DMA=y
 CONFIG_XILINX_DMA=y
 CONFIG_DMA_SUN6I=y
 CONFIG_ST_FDMA=m
+CONFIG_STM32_DMA=y
+CONFIG_STM32_DMAMUX=y
+CONFIG_STM32_MDMA=y
 CONFIG_STAGING=y
 CONFIG_SENSORS_ISL29018=y
 CONFIG_SENSORS_ISL29028=y
-- 
2.7.4
