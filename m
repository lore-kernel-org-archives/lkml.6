Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753385AbeD2MLE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 08:11:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52686 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752875AbeD2MLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 08:11:02 -0400
From: Colin King <colin.king@canonical.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: sun8i: v3s: fix spelling mistake: "disbaled" -> "disabled"
Date: Sun, 29 Apr 2018 13:10:56 +0100
Message-Id: <20180429121056.10501-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in status text string

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
index d1311098ea45..ad173605b1b8 100644
--- a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
+++ b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
@@ -51,7 +51,7 @@
 
 	leds {
 		/* The LEDs use PG0~2 pins, which conflict with MMC1 */
-		status = "disbaled";
+		status = "disabled";
 	};
 };
 
-- 
2.17.0
