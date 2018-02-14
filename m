Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967107AbeBNKGO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 05:06:14 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:44719 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S966986AbeBNKGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 05:06:10 -0500
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <lee.jones@linaro.org>, <thierry.reding@gmail.com>,
        <alexandre.torgue@st.com>
CC: <benjamin.gaignard@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <benjamin.gaignard@st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
Subject: [RESEND PATCH v2 1/8] pwm: stm32: fix, remove unused struct device
Date: Wed, 14 Feb 2018 11:04:32 +0100
Message-ID: <1518602679-3064-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1518602679-3064-1-git-send-email-fabrice.gasnier@st.com>
References: <1518602679-3064-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-14_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev is never assigned nor used. remove it.

Fixes: 7edf7369205b ("pwm: Add driver for STM32 plaftorm")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 drivers/pwm/pwm-stm32.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 6139512..59524f9 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -21,7 +21,6 @@
 
 struct stm32_pwm {
 	struct pwm_chip chip;
-	struct device *dev;
 	struct clk *clk;
 	struct regmap *regmap;
 	u32 max_arr;
-- 
1.9.1
