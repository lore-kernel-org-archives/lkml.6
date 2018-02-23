Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751632AbeBWNgx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 08:36:53 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:53874 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751580AbeBWNgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 08:36:51 -0500
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <thierry.reding@gmail.com>, <alexandre.torgue@st.com>
CC: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <benjamin.gaignard@linaro.org>
Subject: [RESEND PATCH 3/3] ARM: dts: stm32: update pwm-cells for LPTimer on stm32h743
Date: Fri, 23 Feb 2018 14:36:05 +0100
Message-ID: <1519392965-28235-4-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519392965-28235-1-git-send-email-fabrice.gasnier@st.com>
References: <1519392965-28235-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-23_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LPTimer pwm cells should be updated to 3, to allow initialization of
channel, period and polarity.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32h743.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
index bbfcbac..40d7d76 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -85,6 +85,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm-lp";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -238,6 +239,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm-lp";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -264,6 +266,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm-lp";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -285,6 +288,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm-lp";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 		};
@@ -300,6 +304,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm-lp";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 		};
-- 
1.9.1
