Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751035AbeCGIRF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 03:17:05 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:3614 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751214AbeCGIQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 03:16:49 -0500
X-UUID: 0ac330edf2fc49d98fe7dabf0c1d3599-20180307
From: <sean.wang@mediatek.com>
To: <vinod.koul@intel.com>, <dan.j.williams@intel.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v6 3/3] dmaengine: mediatek: update MAINTAINERS entry with MediaTek DMA driver
Date: Wed, 7 Mar 2018 16:16:28 +0800
Message-ID: <add90f15265dfca3b7fdcba449aa76e9ee2d8ee1.1520407882.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1520407882.git.sean.wang@mediatek.com>
References: <cover.1520407882.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23704.005
X-TM-AS-Result: No-3.441600-8.000000-10
X-TMASE-MatchedRID: K16+lmNpxx1VDs7/hETL61VN8laWo90MTJDl9FKHbrn7efdnqtsaE3bk
        pdDhAgYmuy15YxaxQ5YboV2v/uTAixyonC1Qcu05ngIgpj8eDcAZ1CdBJOsoY9mzcdRxL+xwKra
        uXd3MZDV4y+hGG+Bmo4M899wVDqhWLVlhRJY/Kt+LZkctjRFeByucMoLsW2FRlAzbkFNTLRECLB
        qy4yFYMFb7Up0uEgEmSAvpeyoFUdiha29PxydnQTigZBQJvBjlD6DuZ3COjrnoW0NkKZgEnW3Lg
        NyHejuiQwymtxuJ6y0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.441600-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23704.005
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

I work for MediaTek and maintain SoC targeting to home gateway and
also will keep extending and testing the function.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3bdc260..d3c33d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8785,6 +8785,15 @@ M:	Sean Wang <sean.wang@mediatek.com>
 S:	Maintained
 F:	drivers/media/rc/mtk-cir.c
 
+MEDIATEK DMA DRIVER
+M:	Sean Wang <sean.wang@mediatek.com>
+L:	dmaengine@vger.kernel.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/dma/mtk-*
+F:	drivers/dma/mediatek/
+
 MEDIATEK PMIC LED DRIVER
 M:	Sean Wang <sean.wang@mediatek.com>
 S:	Maintained
-- 
2.7.4
