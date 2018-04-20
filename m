Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754279AbeDTJSn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 05:18:43 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:2087 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754149AbeDTJSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 05:18:42 -0400
From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Yangbo Lu <yangbo.lu@nxp.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH v1 1/5] ARM: configs: multi_v7: Add I2C support
Date: Fri, 20 Apr 2018 11:17:50 +0200
Message-ID: <1524215874-15093-2-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524215874-15093-1-git-send-email-pierre-yves.mordret@st.com>
References: <1524215874-15093-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.116]
X-ClientProxiedBy: GPXDAG1NODE4.st.com (10.75.127.65) To GPXDAG5NODE5.st.com
 (10.75.127.78)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-20_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds I2C F7 support to multi_v7_defconfig

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
     v1:
        * Initial
---
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e6b3c96..2a87784 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -385,6 +385,7 @@ CONFIG_I2C_S3C2410=y
 CONFIG_I2C_SH_MOBILE=y
 CONFIG_I2C_SIRF=y
 CONFIG_I2C_ST=y
+CONFIG_I2C_STM32F7=y
 CONFIG_I2C_SUN6I_P2WI=y
 CONFIG_I2C_TEGRA=y
 CONFIG_I2C_UNIPHIER=y
-- 
2.7.4
