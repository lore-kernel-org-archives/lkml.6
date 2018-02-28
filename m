Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752560AbeB1Kgx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:36:53 -0500
Received: from mail.bootlin.com ([62.4.15.54]:55882 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752229AbeB1Kgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:36:48 -0500
From: Quentin Schulz <quentin.schulz@bootlin.com>
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org
Cc: maxime.ripard@bootlin.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        linux-sunxi@googlegroups.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH v5 2/6] mfd: axp20x: probe axp20x_adc driver for AXP813
Date: Wed, 28 Feb 2018 11:35:57 +0100
Message-Id: <4795b70e4298aa0d1fc01cafe17f5b0a416e90f8.1519813976.git-series.quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.07d02d245f44e63775b331815e9bf584598d2e9f.1519813976.git-series.quentin.schulz@bootlin.com>
References: <cover.07d02d245f44e63775b331815e9bf584598d2e9f.1519813976.git-series.quentin.schulz@bootlin.com>
In-Reply-To: <cover.07d02d245f44e63775b331815e9bf584598d2e9f.1519813976.git-series.quentin.schulz@bootlin.com>
References: <cover.07d02d245f44e63775b331815e9bf584598d2e9f.1519813976.git-series.quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the axp20x_adc driver probe with platform device id
"axp813-adc".

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mfd/axp20x.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 1977a03..e5516aa 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -885,7 +885,10 @@ static struct mfd_cell axp813_cells[] = {
 	}, {
 		.name			= "axp20x-gpio",
 		.of_compatible		= "x-powers,axp813-gpio",
-	}
+	}, {
+		.name			= "axp813-adc",
+		.of_compatible		= "x-powers,axp813-adc",
+	},
 };
 
 static struct axp20x_dev *axp20x_pm_power_off;
-- 
git-series 0.9.1
