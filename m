Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbeBTRBX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 12:01:23 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:33917 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752079AbeBTRBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 12:01:22 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: arm@kernel.org, Jesper Nilsson <jespern@axis.com>,
        Lars Persson <larper@axis.com>, Niklas Cassel <niklass@axis.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@axis.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] ARM: dts: artpec: use 1 GiB RAM
Date: Tue, 20 Feb 2018 18:00:43 +0100
Message-Id: <20180220170049.22809-3-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180220170049.22809-1-niklas.cassel@axis.com>
References: <20180220170049.22809-1-niklas.cassel@axis.com>
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There has never been an artpec6 devboard produced
with less than 1 GiB RAM.

Increase the default value to 1 GiB RAM, so that we
can netboot with large initramfs without going OOM.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 arch/arm/boot/dts/artpec6-devboard.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/artpec6-devboard.dts b/arch/arm/boot/dts/artpec6-devboard.dts
index 9dfe845694cf..502f3de6dc5b 100644
--- a/arch/arm/boot/dts/artpec6-devboard.dts
+++ b/arch/arm/boot/dts/artpec6-devboard.dts
@@ -26,7 +26,7 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0x0 0x10000000>;
+		reg = <0x0 0x40000000>;
 	};
 };
 
-- 
2.14.2
