Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752315AbeCWJTE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:19:04 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:30758 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752015AbeCWJPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:15:32 -0400
X-UUID: 324ecfafe73546ebba7a7575a69979a1-20180323
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <sre@kernel.org>,
        <lee.jones@linaro.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@free-electrons.com>, <eddie.huang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 05/16] rtc: mediatek: add MT6323 support to RTC driver
Date: Fri, 23 Mar 2018 17:15:02 +0800
Message-ID: <c49898db977a0b37363a35d3e3b297af891d7219.1521794177.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1521794176.git.sean.wang@mediatek.com>
References: <cover.1521794176.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23736.004
X-TM-AS-Result: No-5.827400-8.000000-10
X-TMASE-MatchedRID: TEv/LuC73NgxFdXyW/P+XW3NvezwBrVmTJDl9FKHbrkKogmGusPLb5g1
        FOMOQofR/l3Eaff8G3C4LZzenDhGPx8TzIzimOwPlpYqKNmWxsHZs3HUcS/scCq2rl3dzGQ1Fti
        yCwivF1UQyEmUp3PatH0YUdglkHG0YuAxZQ07Yh3z3KzY/7te+8C+ksT6a9fy
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.827400-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23736.004
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Just to add MT6323 support to the existent RTC driver.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/rtc/rtc-mt6397.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index 385f830..0df7ccd 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -398,6 +398,7 @@ static SIMPLE_DEV_PM_OPS(mt6397_pm_ops, mt6397_rtc_suspend,
 			mt6397_rtc_resume);
 
 static const struct of_device_id mt6397_rtc_of_match[] = {
+	{ .compatible = "mediatek,mt6323-rtc", },
 	{ .compatible = "mediatek,mt6397-rtc", },
 	{ }
 };
-- 
2.7.4
