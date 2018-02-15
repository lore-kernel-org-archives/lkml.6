Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425324AbeBOPz1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 10:55:27 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:35184 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1425290AbeBOPzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:55:22 -0500
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 2/3] ARM: dts: stm32: select otg mode for usbotg_hs on stm32746g_eval
Date: Thu, 15 Feb 2018 16:54:39 +0100
Message-ID: <1518710080-18164-3-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518710080-18164-1-git-send-email-amelie.delaunay@st.com>
References: <1518710080-18164-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-15_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure USB OTG HS in OTG (DRD) mode on STM32746G_eval.
The USB connector used will determine the role of USB OTG controller.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32746g-eval.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32746g-eval.dts b/arch/arm/boot/dts/stm32746g-eval.dts
index 2d4e717..90a4056 100644
--- a/arch/arm/boot/dts/stm32746g-eval.dts
+++ b/arch/arm/boot/dts/stm32746g-eval.dts
@@ -119,7 +119,7 @@
 };
 
 &usbotg_hs {
-	dr_mode = "host";
+	dr_mode = "otg";
 	phys = <&usbotg_hs_phy>;
 	phy-names = "usb2-phy";
 	pinctrl-0 = <&usbotg_hs_pins_a>;
-- 
2.7.4
