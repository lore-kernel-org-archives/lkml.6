Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754323AbeDTJFl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 05:05:41 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:42708 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754204AbeDTJFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 05:05:37 -0400
From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH v1 3/3] ARM: dts: stm32: Add I2C1 support for STM32F746-DISCO Board
Date: Fri, 20 Apr 2018 11:05:10 +0200
Message-ID: <1524215110-13967-4-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524215110-13967-1-git-send-email-pierre-yves.mordret@st.com>
References: <1524215110-13967-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.119]
X-ClientProxiedBy: GPXDAG2NODE5.st.com (10.75.127.69) To GPXDAG5NODE5.st.com
 (10.75.127.78)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-20_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add I2C1 support for STM32F746-DISCO Board

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
     v1:
        * Initial
---
---
 arch/arm/boot/dts/stm32f746-disco.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f746-disco.dts b/arch/arm/boot/dts/stm32f746-disco.dts
index be94c6a..f9ad71f 100644
--- a/arch/arm/boot/dts/stm32f746-disco.dts
+++ b/arch/arm/boot/dts/stm32f746-disco.dts
@@ -90,6 +90,14 @@
 	clock-frequency = <25000000>;
 };
 
+&i2c1 {
+	pinctrl-0 = <&i2c1_pins_b>;
+	pinctrl-names = "default";
+	i2c-scl-rising-time-ns = <185>;
+	i2c-scl-falling-time-ns = <20>;
+	status = "okay";
+};
+
 &sdio1 {
 	status = "okay";
 	vmmc-supply = <&mmc_vcard>;
-- 
2.7.4
