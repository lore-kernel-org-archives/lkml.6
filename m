Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932573AbeE2JBP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 05:01:15 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:16664 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932435AbeE2JBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 05:01:08 -0400
From: Roger Quadros <rogerq@ti.com>
To: <tony@atomide.com>
CC: <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>,
        "[4.16+]" <stable@vger.kernel.org>
Subject: [PATCH 1/5] ARM: dts: dra7: Disable metastability workaround for USB2
Date: Tue, 29 May 2018 12:00:54 +0300
Message-ID: <1527584458-6257-2-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527584458-6257-1-git-send-email-rogerq@ti.com>
References: <1527584458-6257-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable the metastability workaround for USB2. The original
patch disabled the workaround on the wrong USB port.

Fixes: b8c9c6fa2002 ("ARM: dts: dra7: Disable USB metastability workaround for USB2")
Cc: <stable@vger.kernel.org>        [4.16+]
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index f4ddd86..9cace9f 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1582,7 +1582,6 @@
 				dr_mode = "otg";
 				snps,dis_u3_susphy_quirk;
 				snps,dis_u2_susphy_quirk;
-				snps,dis_metastability_quirk;
 			};
 		};
 
@@ -1610,6 +1609,7 @@
 				dr_mode = "otg";
 				snps,dis_u3_susphy_quirk;
 				snps,dis_u2_susphy_quirk;
+				snps,dis_metastability_quirk;
 			};
 		};
 
-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
