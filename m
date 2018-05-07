Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbeEGC0H (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 22:26:07 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:50810 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751854AbeEGC0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 22:26:03 -0400
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: gregory.clement@bootlin.com, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] pinctrl: mvebu: use correct MPP sel value for dev pins
Date: Mon,  7 May 2018 14:25:55 +1200
Message-Id: <20180507022555.31645-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "dev" function is selected with the value 0x4 not 0x01.

Fixes: commit d7ae8f8dee7f ("pinctrl: mvebu: pinctrl driver for 98DX3236 SoC")
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
index 28b199796fae..5e828468e43d 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
@@ -437,34 +437,34 @@ static struct mvebu_mpp_mode mv98dx3236_mpp_modes[] = {
 		 MPP_VAR_FUNCTION(0x4, "dev", "we0",         V_98DX3236_PLUS)),
 	MPP_MODE(21,
 		 MPP_VAR_FUNCTION(0x0, "gpo", NULL,          V_98DX3236_PLUS),
-		 MPP_VAR_FUNCTION(0x1, "dev", "ad0",         V_98DX3236_PLUS)),
+		 MPP_VAR_FUNCTION(0x4, "dev", "ad0",         V_98DX3236_PLUS)),
 	MPP_MODE(22,
 		 MPP_VAR_FUNCTION(0x0, "gpo", NULL,          V_98DX3236_PLUS),
-		 MPP_VAR_FUNCTION(0x1, "dev", "ad1",         V_98DX3236_PLUS)),
+		 MPP_VAR_FUNCTION(0x4, "dev", "ad1",         V_98DX3236_PLUS)),
 	MPP_MODE(23,
 		 MPP_VAR_FUNCTION(0x0, "gpo", NULL,          V_98DX3236_PLUS),
-		 MPP_VAR_FUNCTION(0x1, "dev", "ad2",         V_98DX3236_PLUS)),
+		 MPP_VAR_FUNCTION(0x4, "dev", "ad2",         V_98DX3236_PLUS)),
 	MPP_MODE(24,
 		 MPP_VAR_FUNCTION(0x0, "gpo", NULL,          V_98DX3236_PLUS),
-		 MPP_VAR_FUNCTION(0x1, "dev", "ad3",         V_98DX3236_PLUS)),
+		 MPP_VAR_FUNCTION(0x4, "dev", "ad3",         V_98DX3236_PLUS)),
 	MPP_MODE(25,
 		 MPP_VAR_FUNCTION(0x0, "gpo", NULL,          V_98DX3236_PLUS),
-		 MPP_VAR_FUNCTION(0x1, "dev", "ad4",         V_98DX3236_PLUS)),
+		 MPP_VAR_FUNCTION(0x4, "dev", "ad4",         V_98DX3236_PLUS)),
 	MPP_MODE(26,
 		 MPP_VAR_FUNCTION(0x0, "gpo", NULL,          V_98DX3236_PLUS),
-		 MPP_VAR_FUNCTION(0x1, "dev", "ad5",         V_98DX3236_PLUS)),
+		 MPP_VAR_FUNCTION(0x4, "dev", "ad5",         V_98DX3236_PLUS)),
 	MPP_MODE(27,
 		 MPP_VAR_FUNCTION(0x0, "gpo", NULL,          V_98DX3236_PLUS),
-		 MPP_VAR_FUNCTION(0x1, "dev", "ad6",         V_98DX3236_PLUS)),
+		 MPP_VAR_FUNCTION(0x4, "dev", "ad6",         V_98DX3236_PLUS)),
 	MPP_MODE(28,
 		 MPP_VAR_FUNCTION(0x0, "gpo", NULL,          V_98DX3236_PLUS),
-		 MPP_VAR_FUNCTION(0x1, "dev", "ad7",         V_98DX3236_PLUS)),
+		 MPP_VAR_FUNCTION(0x4, "dev", "ad7",         V_98DX3236_PLUS)),
 	MPP_MODE(29,
 		 MPP_VAR_FUNCTION(0x0, "gpo", NULL,          V_98DX3236_PLUS),
-		 MPP_VAR_FUNCTION(0x1, "dev", "a0",          V_98DX3236_PLUS)),
+		 MPP_VAR_FUNCTION(0x4, "dev", "a0",          V_98DX3236_PLUS)),
 	MPP_MODE(30,
 		 MPP_VAR_FUNCTION(0x0, "gpo", NULL,          V_98DX3236_PLUS),
-		 MPP_VAR_FUNCTION(0x1, "dev", "a1",          V_98DX3236_PLUS)),
+		 MPP_VAR_FUNCTION(0x4, "dev", "a1",          V_98DX3236_PLUS)),
 	MPP_MODE(31,
 		 MPP_VAR_FUNCTION(0x0, "gpio", NULL,         V_98DX3236_PLUS),
 		 MPP_VAR_FUNCTION(0x1, "slv_smi", "mdc",     V_98DX3236_PLUS),
-- 
2.17.0
