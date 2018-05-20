Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752688AbeETRCf (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 13:02:35 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:7183 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752247AbeETRCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 13:02:21 -0400
X-UUID: a6c2bfda534c41aabad6596325c2243b-20180521
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linus.walleij@linaro.org>, <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 6/7] MAINTAINERS: update entry for PIN CONTROLLER - MEDIATEK
Date: Mon, 21 May 2018 01:01:52 +0800
Message-ID: <e5bcfc9671a79fef4f38933bb04894f0f53b3d63.1526835466.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1526835466.git.sean.wang@mediatek.com>
References: <cover.1526835466.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add new files for the entry

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9051a9c..7f3cced 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11193,6 +11193,7 @@ L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
 F:	Documentation/devicetree/bindings/pinctrl/pinctrl-mt7622.txt
+F:	drivers/pinctrl/mediatek/mtk-eint.*
 F:	drivers/pinctrl/mediatek/pinctrl-mtk-common.*
 F:	drivers/pinctrl/mediatek/pinctrl-mt2701.c
 F:	drivers/pinctrl/mediatek/pinctrl-mt7622.c
-- 
2.7.4
