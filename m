Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754066AbeEOPfT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 11:35:19 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:12235 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752433AbeEOPfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 11:35:17 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <alexandre.torgue@st.com>, <mcoquelin.stm32@gmail.com>,
        <jic23@kernel.org>, <thierry.reding@gmail.com>, <lee.jones@linaro.org>
CC: <vilhelm.gray@gmail.com>, <fabrice.gasnier@st.com>,
        <benjamin.gaignard@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: Add entry for STM32 timer and lptimer drivers
Date: Tue, 15 May 2018 17:33:19 +0200
Message-ID: <1526398399-31753-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-15_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry to make myself a maintainer of STM32 timer and lptimer
drivers.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b65225..94d8e47 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13425,6 +13425,16 @@ T:	git git://linuxtv.org/media_tree.git
 S:	Maintained
 F:	drivers/media/usb/stk1160/
 
+STM32 TIMER/LPTIMER DRIVERS
+M:	Fabrice Gasnier <fabrice.gasnier@st.com>
+S:	Maintained
+F:	drivers/*/stm32-*timer*
+F:	drivers/pwm/pwm-stm32*
+F:	include/linux/*/stm32-*tim*
+F:	Documentation/ABI/testing/*timer-stm32
+F:	Documentation/devicetree/bindings/*/stm32-*timer
+F:	Documentation/devicetree/bindings/pwm/pwm-stm32*
+
 STMMAC ETHERNET DRIVER
 M:	Giuseppe Cavallaro <peppe.cavallaro@st.com>
 M:	Alexandre Torgue <alexandre.torgue@st.com>
-- 
1.9.1
