Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751233AbeBQTIn (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 14:08:43 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:27619 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751166AbeBQTIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 14:08:41 -0500
X-UUID: 6349fd0feba94606827c98c649de6afa-20180218
From: <sean.wang@mediatek.com>
To: <vinod.koul@intel.com>, <dan.j.williams@intel.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v5 3/3] dmaengine: mediatek: update MAINTAINERS entry with MediaTek DMA driver
Date: Sun, 18 Feb 2018 03:08:31 +0800
Message-ID: <4ebffd841fc3b2093fb35c3d10b8b167a9e42bcc.1518857747.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1518857746.git.sean.wang@mediatek.com>
References: <cover.1518857746.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
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
