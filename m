Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752435AbeCWJSC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:18:02 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:30758 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752053AbeCWJPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:15:35 -0400
X-UUID: b9adf91f2c3d42d4b4697aef028861d0-20180323
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <sre@kernel.org>,
        <lee.jones@linaro.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@free-electrons.com>, <eddie.huang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 03/16] dt-bindings: mfd: mediatek: add a description for MT6323 RTC
Date: Fri, 23 Mar 2018 17:15:00 +0800
Message-ID: <ba4708a34e43fbc12e78804840be1698f84243cc.1521794177.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1521794176.git.sean.wang@mediatek.com>
References: <cover.1521794176.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23736.004
X-TM-AS-Result: No-2.893900-8.000000-10
X-TMASE-MatchedRID: AuCKiGuH5B5BHBd/Q+ztB1z+axQLnAVBWwKGivsEuI0CsxyhR8y7CVO4
        BD7nLMxn8DRYXhYkzdlwHcoQdKA87G7h416xddkPngIgpj8eDcAZ1CdBJOsoY9mzcdRxL+xwKra
        uXd3MZDWAsWj3EVhgWF6vHBiAQ88KfoX94EvS3g0l1JLQVyV5cyoZ8Qjnc2MZ+h1fVyf13Stt5n
        zsB/rWY8bmPUgpke3oWBajT16GeVXh5DhSqF3J1jigZBQJvBjlD6DuZ3COjrnoW0NkKZgEnW3Lg
        NyHejuiQwymtxuJ6y0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.893900-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23736.004
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add a description for MT6323 RTC and link it to the detailed binding
documentation.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 Documentation/devicetree/bindings/mfd/mt6397.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
index d1df77f..11a748d 100644
--- a/Documentation/devicetree/bindings/mfd/mt6397.txt
+++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
@@ -22,8 +22,10 @@ compatible: "mediatek,mt6397" or "mediatek,mt6323"
 Optional subnodes:
 
 - rtc
-	Required properties:
+	Required properties: Should be one of follows
+		- compatible: "mediatek,mt6323-rtc"
 		- compatible: "mediatek,mt6397-rtc"
+	For details, see Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
 - regulators
 	Required properties:
 		- compatible: "mediatek,mt6397-regulator"
-- 
2.7.4
