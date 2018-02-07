Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753830AbeBGKW6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 05:22:58 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:7346 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753675AbeBGKW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 05:22:56 -0500
X-UUID: b6b054dc4ea34cd59864a41bee2635c9-20180207
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <rjw@rjwysocki.net>,
        <khilman@baylibre.com>
CC: <ulf.hansson@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/4] dt-bindings: soc: add header files required for MT7623A SCPSYS dt-binding
Date: Wed, 7 Feb 2018 18:22:48 +0800
Message-ID: <9955178588f8bde01782d0645b25a7b24cceb87b.1517998367.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <ecfc548fc3d22aa335b50e552ad2ad88427a0bb2.1517998367.git.sean.wang@mediatek.com>
References: <ecfc548fc3d22aa335b50e552ad2ad88427a0bb2.1517998367.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add relevant header files required for dt-bindings of SCPSYS power domain
control for subsystems found on MT7623A SoC.

v1 -> v2: fix typos and treat the patch as a dt-binding patch

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/power/mt7623a-power.h | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 include/dt-bindings/power/mt7623a-power.h

diff --git a/include/dt-bindings/power/mt7623a-power.h b/include/dt-bindings/power/mt7623a-power.h
new file mode 100644
index 0000000..2544822
--- /dev/null
+++ b/include/dt-bindings/power/mt7623a-power.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _DT_BINDINGS_POWER_MT7623A_POWER_H
+#define _DT_BINDINGS_POWER_MT7623A_POWER_H
+
+#define MT7623A_POWER_DOMAIN_CONN	0
+#define MT7623A_POWER_DOMAIN_ETH	1
+#define MT7623A_POWER_DOMAIN_HIF	2
+#define MT7623A_POWER_DOMAIN_IFR_MSC	3
+
+#endif /* _DT_BINDINGS_POWER_MT7623A_POWER_H */
-- 
2.7.4
