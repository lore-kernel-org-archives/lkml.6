Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752364AbeCWJRo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:17:44 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:8094 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752004AbeCWJPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:15:36 -0400
X-UUID: 52ddf7a4798b4e9e96d5c54e0410dc0a-20180323
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <sre@kernel.org>,
        <lee.jones@linaro.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@free-electrons.com>, <eddie.huang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 16/16] MAINTAINERS: add an entry for MediaTek board level shutdown driver
Date: Fri, 23 Mar 2018 17:15:13 +0800
Message-ID: <47102dcc92322c21d94b810feee0ba5f657ee17a.1521794177.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1521794176.git.sean.wang@mediatek.com>
References: <cover.1521794176.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23736.004
X-TM-AS-Result: No-5.083900-8.000000-10
X-TMASE-MatchedRID: VznsoVq3PH8xFdXyW/P+XYv73wEu0Nx7v8yqWnJhUsENAzuXf98XU2b6
        PphVtfZglW4UQD0mrH2FECvR4Kt3tByonC1Qcu05dOc7KAdVCk7Q6kBvBIlXtZsoi2XrUn/J8m+
        hzBStansUGm4zriL0oQtuKBGekqUpbGVEmIfjf3to+989r3nfAvRDgqGnBtXi8tVEVF/BSLDumW
        krWTSyK0dhbEY4c4Xo
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.083900-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23736.004
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add an entry for the MediaTek board level shutdown driver.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1c13f29..863d1e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8818,6 +8818,13 @@ S:	Maintained
 F:	drivers/net/dsa/mt7530.*
 F:	net/dsa/tag_mtk.c
 
+MEDIATEK BOARD LEVEL SHUTDOWN DRIVERS
+M:	Sean Wang <sean.wang@mediatek.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/reset/mt6397-rtc-poweroff.txt
+F:	drivers/power/reset/mt6397-rtc-poweroff.c
+
 MEDIATEK JPEG DRIVER
 M:	Rick Chang <rick.chang@mediatek.com>
 M:	Bin Liu <bin.liu@mediatek.com>
-- 
2.7.4
