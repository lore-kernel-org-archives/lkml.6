Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752589AbeB1KhB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:37:01 -0500
Received: from mail.bootlin.com ([62.4.15.54]:55909 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752559AbeB1Kg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:36:58 -0500
From: Quentin Schulz <quentin.schulz@bootlin.com>
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org
Cc: maxime.ripard@bootlin.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        linux-sunxi@googlegroups.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH v5 6/6] mfd: axp20x: add battery power supply cell for AXP813
Date: Wed, 28 Feb 2018 11:36:01 +0100
Message-Id: <dc220101006c4df198b2d410121334a2ae98ad22.1519813976.git-series.quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.07d02d245f44e63775b331815e9bf584598d2e9f.1519813976.git-series.quentin.schulz@bootlin.com>
References: <cover.07d02d245f44e63775b331815e9bf584598d2e9f.1519813976.git-series.quentin.schulz@bootlin.com>
In-Reply-To: <cover.07d02d245f44e63775b331815e9bf584598d2e9f.1519813976.git-series.quentin.schulz@bootlin.com>
References: <cover.07d02d245f44e63775b331815e9bf584598d2e9f.1519813976.git-series.quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As axp20x-battery-power-supply now supports AXP813, add a cell for it.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mfd/axp20x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index e5516aa..aaf2acb 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -888,6 +888,9 @@ static struct mfd_cell axp813_cells[] = {
 	}, {
 		.name			= "axp813-adc",
 		.of_compatible		= "x-powers,axp813-adc",
+	}, {
+		.name		= "axp20x-battery-power-supply",
+		.of_compatible	= "x-powers,axp813-battery-power-supply",
 	},
 };
 
-- 
git-series 0.9.1
