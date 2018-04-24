Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754189AbeDXJm1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 05:42:27 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:59755 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753241AbeDXJmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 05:42:24 -0400
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH v2 4/4] ARM: multi_v7_defconfig: enable STM32 USB PHY Controller (USBPHYC)
Date: Tue, 24 Apr 2018 11:41:45 +0200
Message-ID: <1524562905-19361-5-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524562905-19361-1-git-send-email-amelie.delaunay@st.com>
References: <1524562905-19361-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-24_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the STM32 USB PHY Controller (USBPHYC) driver, implemented on
STM32MP1 SoC.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e6b3c96..e78b43f 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -972,6 +972,7 @@ CONFIG_PHY_QCOM_APQ8064_SATA=m
 CONFIG_PHY_MIPHY28LP=y
 CONFIG_PHY_RCAR_GEN2=m
 CONFIG_PHY_STIH407_USB=y
+CONFIG_PHY_STM32_USBPHYC=y
 CONFIG_PHY_SUN4I_USB=y
 CONFIG_PHY_SUN9I_USB=y
 CONFIG_PHY_SAMSUNG_USB2=m
-- 
2.7.4
