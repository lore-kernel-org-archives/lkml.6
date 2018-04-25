Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751829AbeDYJfB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 05:35:01 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:62845 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751328AbeDYJdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 05:33:07 -0400
X-UUID: 661b760ab043466ca544d9555c6d2d9a-20180425
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <sre@kernel.org>,
        <lee.jones@linaro.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@free-electrons.com>, <matthias.bgg@gmail.com>,
        <eddie.huang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 13/17] rtc: mt6397: cleanup header files to include
Date: Wed, 25 Apr 2018 17:32:39 +0800
Message-ID: <ac254bb75a28a6a7c55557eedc9e466a5dbba075.1524646231.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1524646231.git.sean.wang@mediatek.com>
References: <cover.1524646231.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Clean up those included header files by removing unreferenced ones,
add missing ones the driver explicitly depends on and finally list
all #includes in alphabetical order.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/rtc/rtc-mt6397.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index 4c5cdaa..3672d622 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -12,17 +12,14 @@
 * GNU General Public License for more details.
 */
 
-#include <linux/delay.h>
-#include <linux/init.h>
+#include <linux/err.h>
 #include <linux/interrupt.h>
+#include <linux/mfd/mt6397/core.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/rtc.h>
-#include <linux/platform_device.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/io.h>
-#include <linux/mfd/mt6397/core.h>
 #include <linux/mfd/mt6397/rtc.h>
 
 static int mtk_rtc_write_trigger(struct mt6397_rtc *rtc)
-- 
2.7.4
