Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753165AbeDKI6F (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 04:58:05 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:51194 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751972AbeDKIyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 04:54:15 -0400
X-UUID: e5f199463f7e468ca323d9d00534d4a7-20180411
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 04/12] arm: dts: mt7623: fix available memory size on bananapi-r2
Date: Wed, 11 Apr 2018 16:53:57 +0800
Message-ID: <705d03d06a7668d66689777bb90806953e0744b3.1523434758.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1523434757.git.sean.wang@mediatek.com>
References: <cover.1523434757.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

There is 2GB DDR3 available on bananapi-r2 board as [1] specified.

[1] http://www.banana-pi.org/r2.html

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>
---
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
index 5938e4c..d2a354e 100644
--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -110,7 +110,7 @@
 
 	memory@80000000 {
 		device_type = "memory";
-		reg = <0 0x80000000 0 0x40000000>;
+		reg = <0 0x80000000 0 0x80000000>;
 	};
 };
 
-- 
2.7.4
